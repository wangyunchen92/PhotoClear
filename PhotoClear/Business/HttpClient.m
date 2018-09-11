//
//  HttpClient.m
//  XLAFNetworking
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 along. All rights reserved.
//

#import "HttpClient.h"

#define HTTPURL @""
#define HTTPIMAGEURL @""
#define PrivalStr   @"e176de519a0a97a8"

@interface HttpClient ()
@end

@implementation HttpClient

#pragma mark 单例
static HttpClient *httpClient = nil;
+ (HttpClient *)sharedInstance {
    
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        if(httpClient == nil) {
            httpClient = [[HttpClient alloc]init];                        
        }
    });
    
    return httpClient;
}

/**
 *  校验网络状态
 *  网络状态
 *  1 网络不通
 *  2 WIFI
 *  3 3G 4G
 *  4 未知
 *  @param block 回调
 */
- (void)checkNetworkingStatus:(NetwokingStatusBlcok)block {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:
                //网络不通
                if(block) {
                    block(AFNetworkReachabilityStatusNotReachable);
                }
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //WiFi
                if(block) {
                    block(AFNetworkReachabilityStatusReachableViaWiFi);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //无线连接
                if(block) {
                    block(AFNetworkReachabilityStatusReachableViaWWAN);
                }
                break;
            case AFNetworkReachabilityStatusUnknown:
                //未知
                if(block) {
                    block(AFNetworkReachabilityStatusUnknown);
                }
                break;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)requestApiWithHttpRequestMode:(HttpRequestMode *)requestMode
                              Success:(CompletionHandlerSuccessBlock)success
                              Failure:(CompletionHandlerFailureBlock)failure {
        [self requestBaseWithName:requestMode.name Url:requestMode.url Parameters:requestMode.parameters IsGet:requestMode.isGET IsCache:NO Success:success Failure:failure RequsetStart:nil ResponseEnd:nil];
}

- (void)requestApiWithHttpRequestMode:(HttpRequestMode *)requestMode
                           Success:(CompletionHandlerSuccessBlock)success
                           Failure:(CompletionHandlerFailureBlock)failure
                      RequsetStart:(RequstStartBlock)requestStart
                       ResponseEnd:(ResponseEndBlock)responseEnd {
    [self requestBaseWithName:requestMode.name Url:requestMode.url Parameters:requestMode.parameters IsGet:requestMode.isGET IsCache:NO Success:success Failure:failure RequsetStart:requestStart ResponseEnd:responseEnd];

}

- (void)requestApiCacheWithHttpRequestMode:(HttpRequestMode *)requestMode
                              Success:(CompletionHandlerSuccessBlock)success
                              Failure:(CompletionHandlerFailureBlock)failure
                         RequsetStart:(RequstStartBlock)requestStart
                          ResponseEnd:(ResponseEndBlock)responseEnd {
    [self requestBaseWithName:requestMode.name Url:requestMode.url Parameters:requestMode.parameters IsGet:requestMode.isGET IsCache:YES Success:success Failure:failure RequsetStart:requestStart ResponseEnd:responseEnd];
}
//上传照片
- (HttpRequest *)uploadPhotoWithHttpRequestMode:(HttpRequestMode *)requestMode
                                 Progress:(UploadProgressBlock)progress
                         Success:(CompletionHandlerSuccessBlock)success
                                  Failure:(CompletionHandlerFailureBlock)failure
                             RequsetStart:(RequstStartBlock)requestStart
                              ResponseEnd:(ResponseEndBlock)responseEnd {
    //增加统一的参数
    NSMutableDictionary* newParamDic = [[NSMutableDictionary alloc]initWithDictionary:requestMode.parameters];
     newParamDic = [self getDefaultparams:newParamDic];
    requestMode.parameters = newParamDic;
    
    HttpRequest *httpRequest = [[HttpRequest alloc]init];

    [httpRequest uploadRequestWithRequestName:requestMode.name UrlString:requestMode.url Parameters:requestMode.parameters PhotoFile:requestMode.uploadModels IsGET:requestMode.isGET];
    
    [httpRequest uploadStartRequsetWithUnitSize:UntiSizeIsKByte Progress:progress SuccessBlock:^(HttpRequest *request, HttpResponse *response) {
        //可以在这里转模型数据传出去 付给response.sourceModel
        success(request,response);
    } FailedBlock:failure RequsetStart:requestStart ResponseEnd:responseEnd];
    
    return httpRequest;
}

- (HttpRequest *)downloadPhotoWithHttpRequestMode:(HttpRequestMode *)requestMode
                                         Progress:(UploadProgressBlock)progress
                               Destination:(downloadDestinationBlock)destination
                                   Success:(CompletionHandlerSuccessBlock)success
                                   Failure:(CompletionHandlerFailureBlock)failure
                              RequsetStart:(RequstStartBlock)requestStart
                               ResponseEnd:(ResponseEndBlock)responseEnd {
    
    HttpRequest *httpRequest = [[HttpRequest alloc]init];
    
    [httpRequest downloadRequestWithrequestName:requestMode.name UrlString:requestMode.url];
    
    [httpRequest downloadStartRequsetWithUnitSize:UntiSizeIsByte Progress:progress Destination:destination SuccessBlock:^(HttpRequest *request, HttpResponse *response) {
        //可以在这里转模型数据传出去 付给response.sourceModel
        success(request,response);
    } FailedBlock:failure RequsetStart:requestStart ResponseEnd:responseEnd];
    
    return httpRequest;

}

//通一请求累
- (void)requestBaseWithName:(NSString *)name
                        Url:(NSString *)url
                 Parameters:(NSDictionary *)parameters
                      IsGet:(BOOL)isGet
                    IsCache:(BOOL)isCache
                    Success:(CompletionHandlerSuccessBlock)success
                    Failure:(CompletionHandlerFailureBlock)failure
               RequsetStart:(RequstStartBlock)requestStart
                ResponseEnd:(ResponseEndBlock)responseEnd {
    NSMutableDictionary* newParamDic = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    newParamDic = [self getDefaultparams:newParamDic];
    HttpRequest *request = [[HttpRequest alloc]initWithRequestWithName:name UrlString:url Parameters:newParamDic IsGET:isGet IsCache:isCache];
    [request startRequestWithSuccessBlock:success FailedBlock:failure RequsetStart:requestStart ResponseEnd:responseEnd];
}

- (NSMutableDictionary *)getDefaultparams:(NSMutableDictionary *)dic {
    [dic addUnEmptyString:Version forKey:@"api_version"];
    [dic addUnEmptyString:@"ios" forKey:@"source"];
    NSString *version = [kAppVersions stringByReplacingOccurrencesOfString:@"." withString:@""];
    [dic setObject:version forKey:@"app_version"];
    NSString* sign = [self getTokenWithParam:dic];

    [dic setObject:sign forKey:@"sign"];
    return dic;
}

//根据param 生成token
-(NSString* )getTokenWithParam:(NSDictionary* )params{
    //获取参数中所有的key 按字母顺序进行排序
    NSMutableArray *sortKeyArr = [[NSMutableArray alloc]initWithArray:[params allKeys]];
    //a按照首位排序
    sortKeyArr = [[NSMutableArray alloc] initWithArray:[sortKeyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //  return [obj1 compare:obj2 options:NSNumericSearch]; // 按数字排序
        return [obj1 compare:obj2 options:NSForcedOrderingSearch];
    }]];
    //签名字符串
    NSMutableString* tmpSignStr = [[NSMutableString alloc]init];
    for (int i = 0 ;i < sortKeyArr.count ; i ++) {
        
        NSString *tmpStr = sortKeyArr[i];
        //最后一个
        if (i == sortKeyArr.count - 1) {
            tmpSignStr = [[tmpSignStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",tmpStr,[params valueForKey:tmpStr]]]mutableCopy];
        }else{
            tmpSignStr = [[tmpSignStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",tmpStr,[params valueForKey:tmpStr]]]mutableCopy];
        }
    }
    
    NSString* token = [self base64Endcode:[NSString stringWithFormat:@"%@%@",tmpSignStr,PrivalStr]].MD5;
    return token;
}

-(NSString *)base64Endcode:(NSString *)str{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

@end
