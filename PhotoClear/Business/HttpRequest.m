//
//  HttpRequest.m
//  XLAFNetworking
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 along. All rights reserved.
//

#import "HttpRequest.h"
#import "HttpClient.h"
#import "UploadModel.h"
#import "YYCache.h"

static NSString * const cacheName = @"cacheName";

@interface HttpRequest () {
    CFAbsoluteTime startTime;//记录请求开始的时候
}
@property (nonatomic,strong) NSURLSessionDataTask *dataTask;//数据任务
@property (nonatomic,strong) NSURLSessionUploadTask *uploadTask;//上传任务
@property (nonatomic,strong) NSURLSessionDownloadTask *downloadTask;//下载任务
@property (nonatomic,strong,readwrite) AFHTTPRequestSerializer *requestSerializer;
@property (nonatomic,strong) YYCache *cache;
@end

@implementation HttpRequest

- (YYCache *)cache {
    if(_cache == nil) {
        _cache = [YYCache cacheWithName:cacheName];
    }
    return _cache;
}

#pragma mark 普通请求
- (instancetype)initWithRequestWithName:(NSString *)name UrlString:(NSString *)urlString Parameters:(id)parameters IsGET:(BOOL)isGET IsCache:(BOOL)isCache {
    if (self = [super init]) {
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        _isCache = isCache;
        [self setRequsetDisplayInfoWithRequestType:[self getRequestTypeWithRequestType:NormalTask] RequestName:name RequestPath:urlString Parameters:parameters UrlRequest:nil isGet:isGET];
    }
    return self;
}

#pragma mark 普通请求开始
- (void)startRequestWithSuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                                           FailedBlock:(CompletionHandlerFailureBlock)failedBlock
                                          RequsetStart:(RequstStartBlock)requestStart
                                           ResponseEnd:(ResponseEndBlock)responseEnd {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    if(requestStart) {
        requestStart();
    }
    
    startTime = CFAbsoluteTimeGetCurrent();
    
    if(_isGet) {
        
         _dataTask = [manager GET:_requestPath parameters:_params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
             [self handleSuccessBlockDataWithresponseObject:responseObject SuccessBlock:successBlock FailedBlock:failedBlock];
             
             if(responseEnd) {
                 responseEnd();
             }
             
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(_isCache) {
                [self getCacheDataWithSuccess:successBlock];
            } else {
                if(error) {
                    [self handleRequestErrorWithError:error FailedBlock:failedBlock];
                }
            }
            
            if(responseEnd) {
                responseEnd();
            }
        }];
        
    } else {
        
        _dataTask = [manager POST:_requestPath parameters:_params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self handleSuccessBlockDataWithresponseObject:responseObject SuccessBlock:successBlock FailedBlock:failedBlock];
            
            if(responseEnd) {
                responseEnd();
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(_isCache) {
                [self getCacheDataWithSuccess:successBlock];
            } else {
                if(error) {
                    [self handleRequestErrorWithError:error FailedBlock:failedBlock];
                }//处理除error以外的错误信息
//                else{
//                     [self getCacheDataWithSuccess:successBlock];
//                }
            }
            
            if(responseEnd) {
                responseEnd();
            }
        }];
    }
}

#pragma mark 上传任务
/**
 *  上传文件任务请求
 *
 *  @param requestName 请求名字
 *  @param URLString   请求路径
 *  @param parameters  请求参数
 *  @param PhotoFile   文件数据
 *  @param isPOST      是否POST
 *
 *  @return HttpRequest
 */
- (HttpRequest *)uploadRequestWithRequestName:(NSString *)requestName UrlString:(NSString *)urlString Parameters:(id)parameters PhotoFile:(NSArray *)photoFile IsGET:(BOOL)isGET {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:isGET?@"GET":@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (id imageModel in photoFile) {
            if([imageModel isKindOfClass:[UploadModel class]]) {
                
                UploadModel *uploadModel = imageModel;
//                [formData throttleBandwidthWithPacketSize:100 delay:1];设置上传包的大小和时间
                [formData appendPartWithFileData:uploadModel.fileData name:uploadModel.name fileName:uploadModel.fileName mimeType:uploadModel.mimeType];
            }
            
        }
        
    } error:nil];
    
    //设置请求的显示信息
    
    [self setRequsetDisplayInfoWithRequestType:[self getRequestTypeWithRequestType:UploadTask] RequestName:requestName RequestPath:urlString Parameters:parameters UrlRequest:request isGet:_isGet];
    
    [self Log:self];
 
    return self;
}

/**
 *  上传任务开始请求
 *
 *  @param Progress     进度条回调
 *  @param unitSize     单位大小
 *  @param successBlock 成功回调
 *  @param failedBlock  失败回调
 *  @param requestStart 请求开始回调
 *  @param responseEnd  响应结束回调
 */
- (void)uploadStartRequsetWithUnitSize:(UnitSize)unitSize
                              Progress:(UploadProgressBlock)Progress
                          SuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                           FailedBlock:(CompletionHandlerFailureBlock)failedBlock
                          RequsetStart:(RequstStartBlock)requestStart
                           ResponseEnd:(ResponseEndBlock)responseEnd {
    
    //记录请求开始时间
    startTime = CFAbsoluteTimeGetCurrent();
    
    //请求开始
    if(requestStart) {
        requestStart();
    }
    
    //创建管理者
    AFURLSessionManager *mamager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //进度条数据
    __block HttpFileLoadProgress *httpFileLoadProgress = [[HttpFileLoadProgress alloc]initWithUnitSize:unitSize];
    
    _uploadTask = [mamager uploadTaskWithStreamedRequest:_urlRequest progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if(Progress) {
            //进度
            httpFileLoadProgress.loadProgress = uploadProgress.completedUnitCount;
            
            httpFileLoadProgress.maxSize = uploadProgress.totalUnitCount;
            
            httpFileLoadProgress.loadFractionCompleted = uploadProgress.fractionCompleted;
            
            Progress(httpFileLoadProgress);
            
            [self Log:httpFileLoadProgress];
        }
    
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error) {
            [self handleRequestErrorWithError:error FailedBlock:failedBlock];
        }else {
            [self handleSuccessBlockDataWithresponseObject:responseObject SuccessBlock:successBlock FailedBlock:failedBlock];
        }
        
        //响应结束
        if(responseEnd) {
            responseEnd();
        }
    }];
    
    [_uploadTask resume];
}

#pragma mark 下载任务

- (HttpRequest *)downloadRequestWithrequestName:(NSString *)requestName UrlString:(NSString *)urlString {
    
    //设置请求的显示信息
    [self setRequsetDisplayInfoWithRequestType:[self getRequestTypeWithRequestType:DownloadTask] RequestName:requestName RequestPath:urlString Parameters:nil UrlRequest:[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]] isGet:_isGet];
    
    [self Log:self];
  
    return self;
}

/**
 *  下载任务
 *
 *  @param unitSize     单位大小
 *  @param Progress     进度条
 *  @param successBlock 成功回调
 *  @param failedBlock  失败回调
 *  @param requestStart 请求开始回调
 *  @param responseEnd  响应结束回调
 */
- (void)downloadStartRequsetWithUnitSize:(UnitSize)unitSize
                                         Progress:(UploadProgressBlock)progress
                                      Destination:(downloadDestinationBlock)destination
                                     SuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                                      FailedBlock:(CompletionHandlerFailureBlock)failedBlock
                                     RequsetStart:(RequstStartBlock)requestStart
                                      ResponseEnd:(ResponseEndBlock)responseEnd {
    
    //记录请求开始时间
    startTime = CFAbsoluteTimeGetCurrent();
    
    //请求开始
    if(requestStart) {
        requestStart();
    }
            
    //创建管理者
    AFURLSessionManager *mamager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //进度条数据
    __block HttpFileLoadProgress *httpFileLoadProgress = [[HttpFileLoadProgress alloc]initWithUnitSize:unitSize];
    
    _downloadTask = [mamager downloadTaskWithRequest:_urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if(progress) {
            httpFileLoadProgress.loadProgress = downloadProgress.completedUnitCount;
            
            httpFileLoadProgress.maxSize = downloadProgress.totalUnitCount;
            
            httpFileLoadProgress.loadFractionCompleted = downloadProgress.fractionCompleted;
            
            progress(httpFileLoadProgress);
            
            [self Log:httpFileLoadProgress];
            
        }
    
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
    
        if(destination) {
            return destination(targetPath,response);
        }else {
    
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            
            NSURL *UrlPath = [NSURL fileURLWithPath:[cachesPath stringByAppendingPathComponent:response.suggestedFilename]];
            
            return UrlPath;
        }
        
                
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //设置下载完成操作
        
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
        if(error) {
            [self handleRequestErrorWithError:error FailedBlock:failedBlock];
        }else {
            [self handleDownloadSuccessBlockDataWithDownloadResponse:response FilePath:filePath SuccessBlock:successBlock FailedBlock:failedBlock];
        }
        
        //响应结束
        if(responseEnd) {
            responseEnd();
        }
        
    }];

    [_downloadTask resume];
    
}

#pragma mark 请求信息设置
/**
 *  设置请求的显示信息
 *
 *  @param requestType 类型
 *  @param requestName 名称
 *  @param requestPath 路径
 *  @param parameters 参数
 *  @param urlRequest  url
 */
- (void)setRequsetDisplayInfoWithRequestType:(NSString *)requestType RequestName:(NSString *)requestName RequestPath:(NSString *)requestPath Parameters:(NSMutableDictionary *)parameters UrlRequest:(NSMutableURLRequest *)urlRequest isGet:(BOOL)isGet {
    
    _requestType = requestType;
    
    _requestName = requestName;
    
    _requestPath = requestPath;
    
    _params = parameters;
    
    _urlRequest = urlRequest;
    
    _isGet = isGet;
    
    if(_timeoutInterval == 0) {
        _timeoutInterval = TIMEOUTINTERVAL;
    }
    
    [self Log:self];
}

#pragma mark response处理
/**
 *  处理请求成功获得的数据
 *
 *  @param responseObject 返回的数据
 *  @param successBlock   成功回调
 *  @param failedBlock    失败回调
 */
- (void)handleSuccessBlockDataWithresponseObject:(id _Nullable)responseObject
                              SuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                               FailedBlock:(CompletionHandlerFailureBlock)failedBlock{
    
    NSMutableDictionary *responseData = [NSMutableDictionary dictionary];
    
    //判断是否是json数据
    if([NSJSONSerialization isValidJSONObject:responseObject]) {
        responseData = responseObject;
    }else {
        //转json
        @try {
            responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        @catch (NSException *exception) {
            [self Log:exception];//数据有问题
        }
        @finally {
            
        }
    }
    
    //响应数据处理
    HttpResponse *response = [[HttpResponse alloc]init];
    response.responseName = [NSString stringWithFormat:@"%@响应",_requestName];
    [response loadResopnseWithObjectData:responseData];
    
    [self Log:response];
    [self Log:[NSString stringWithFormat:@"\n========================Use Time: %lf ==========================\n", CFAbsoluteTimeGetCurrent() - startTime]];
    
    //判断服务器是否返回成功
    if(response.isSuccess) {
        if(successBlock) {
            //创建离线缓存
            if(_isCache) {
                [self.cache setObject:response forKey:[NSString stringWithFormat:@"%@-response",self.requestPath]];
            }
            successBlock(self,response);
        }
    }else {
        if(failedBlock) {
            failedBlock(self,response);
        }
    }
}

/**
 *  处理下载任务成功响应
 *
 *  @param downloadResponse 响应
 *  @param filePath         文件路径
 *  @param successBlock     成功回调
 *  @param failedBlock      失败回调
 */
- (void)handleDownloadSuccessBlockDataWithDownloadResponse:(NSURLResponse *)downloadResponse
                                          FilePath:(NSURL *)filePath
                                    SuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                                     FailedBlock:(CompletionHandlerFailureBlock)failedBlock{
    
    //响应数据处理
    HttpResponse *response = [[HttpResponse alloc]init];
    response.responseName = [NSString stringWithFormat:@"%@响应",_requestName];
    response.result = @{@"file path is":filePath?filePath:@"nil"};
    
    [self Log:response];
    [self Log:[NSString stringWithFormat:@"\n========================Use Time: %lf ==========================\n", CFAbsoluteTimeGetCurrent() - startTime]];
    
    if(successBlock) {
        successBlock(self,response);
    }
}

/**
 *  处理请求错误
 *
 *  @param error        错误
 *  @param successBlock 成功回调
 *  @param failedBlock  失败回调
 */
- (void)handleRequestErrorWithError:(NSError  * _Nullable )error
                        FailedBlock:(CompletionHandlerFailureBlock)failedBlock {
    
    HttpError *httpError = [[HttpError alloc]init];
    httpError.responseName = [NSString stringWithFormat:@"%@响应",_requestName];
    [httpError handleHttpError:error];

    HttpResponse *response = [[HttpResponse alloc]init];
    response.objectData = [error userInfo];
    DLOG(@"objectData == %@",[error userInfo]);
    response.errorMsg = httpError.localizedDescription;
    response.httpError = httpError;
    
    [self Log:httpError];
    [self Log:[NSString stringWithFormat:@"\n========================Use Time: %lf ==========================\n", CFAbsoluteTimeGetCurrent() - startTime]];
    
    if(failedBlock) {
        //隐藏hub
        failedBlock(self,response);
    }
}

/**
 *  枚举替换
 *
 *  @param requestType 枚举值
 *
 *  @return 返回对应字符
 */
- (NSString *)getRequestTypeWithRequestType:(RequstType)requestType {
    switch (requestType) {
        case 0: {
            return @"普通请求";
        }
            break;
        case 1: {
            return @"上传请求";
        }
            break;
        case 2: {
            return @"下载请求";
        }
            break;
        default:
            return @"未知";
            break;
    }
}

#pragma mark 缓存
/**
 *  获取缓存数据
 */
- (void)getCacheDataWithSuccess:(CompletionHandlerSuccessBlock)success {
    [self Log:@"\n======================== 接口请求失败，获取缓存数据 ==========================\n"];
    if(success) {
        id cacheObj = [self.cache objectForKey:[NSString stringWithFormat:@"%@-response",self.requestPath]];
        if([cacheObj isKindOfClass:[HttpResponse class]]) {
            HttpResponse *response = cacheObj;
            success(self,response);
            [self Log:response];
        } else {
            [self Log:@"\n======================== 获取缓存数据失败！ ==========================\n"];
        }
    }
}


#pragma mark 取消任务
/**
 *  取消请求
 */
- (void)cannel {

    if(_dataTask) {
        [_dataTask cancel];
        _dataTask = nil;
    }
    
    if(_uploadTask) {
        [_uploadTask cancel];
        _uploadTask = nil;
    }
    
    if(_downloadTask) {
        [_downloadTask cancel];
        _downloadTask = nil;
    }
    
}

#pragma mark setProperty
- (void)setRequestName:(NSString *)requestName {
    if(![requestName isEqualToString:@""] && requestName) {
        _requestName = requestName;
    }else {
        _requestName = @"无";
    }
}

- (void)setRequestPath:(NSString *)requestPath {
    if(![requestPath isEqualToString:@""] && requestPath) {
        _requestPath = requestPath;
    }else {
        _requestPath = @"无";
    }
}

#pragma mark description
//打印消息
- (void)Log:(id)str {
    NSLog(@"%@",str);
}

- (NSString *)description{
    NSMutableString *descripString = [NSMutableString stringWithFormat:@""];
    [descripString appendString:@"\n========================Request Info==========================\n"];
    if(_isCache) {
        [descripString appendFormat:@"Request Type:%@(缓存)\n",_requestType];
    } else {
        [descripString appendFormat:@"Request Type:%@\n",_requestType];
    }
    [descripString appendFormat:@"Request Name:%@\n",_requestName];
    [descripString appendFormat:@"Request Url:%@\n",_requestPath];
    [descripString appendFormat:@"Request Methods:%@\n",_isGet?@"GET":@"POST"];
    [descripString appendFormat:@"Request params(%lu 个参数):\n%@\n",[_params count],_params?_params:@"无"];
    if (_urlRequest) {
        [descripString appendFormat:@"Request header:\n%@\n",[_urlRequest allHTTPHeaderFields]?[_urlRequest allHTTPHeaderFields]:@"无"];
    } else {
        [descripString appendFormat:@"Request header:\n%@\n",_requestSerializer.HTTPRequestHeaders];
    }
    [descripString appendString:@"===============================================================\n"];
    return descripString;
}

//- (void)dealloc {
//    NSLog(@"%s",__func__);
//}

@end
