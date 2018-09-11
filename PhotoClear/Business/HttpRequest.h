//
//  HttpRequest.h
//  XLAFNetworking
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HttpResponse.h"
#import "HttpError.h"
#import "HttpFileLoadProgress.h"

/**
 *  在Debug模式下，输出内容
 */
#ifdef DEBUG
#define DLOG(...) NSLog(__VA_ARGS__)
#else 
#define DLOG(...)  //DLog(...) NSlog(...)
#endif
//缺省超时时间
#define TIMEOUTINTERVAL 30

@class HttpRequest;
@class HttpResponse;
@class HttpFileLoadProgress;

typedef NS_ENUM(NSInteger,RequstType) {
    NormalTask = 0,//普通任务
    UploadTask,//上传任务
    DownloadTask //下载任务
};

/**
 *  网络状态
 *  1 网络不通
 *  2 WIFI
 *  3 3G 4G
 *  4 未知
 *  @param int 状态值
 */
typedef void(^NetwokingStatusBlcok)(AFNetworkReachabilityStatus status);

/**
 *  请求开始回调
 */
typedef void(^RequstStartBlock)();

/**
 *  响应结束回调
 */
typedef void(^ResponseEndBlock)();

/**
 *  成功回调
 *
 *  @param request  请求
 *  @param response 响应
 */
typedef void(^CompletionHandlerSuccessBlock)(HttpRequest *request,HttpResponse *response);
/**
 *  失败回调
 *
 *  @param request  请求
 *  @param response 响应
 */
typedef void(^CompletionHandlerFailureBlock)(HttpRequest *request,HttpResponse *response);
/**
 *  进度条回调
 *
 *  @param uploadProgress 进度条信息类
 */
typedef void (^UploadProgressBlock)(HttpFileLoadProgress *uploadProgress);

/**
 *  下载任务保存路径回调
 *
 *  @param targetPath 路径
 *  @param response   响应
 *
 *  @return 返回需要保存的路径
 */
typedef NSURL *(^downloadDestinationBlock)(NSURL *targetPath, NSURLResponse *response);

@interface HttpRequest : NSObject
#pragma mark 属性

/**
 * 是否缓存
 */
@property (nonatomic,assign,readonly) BOOL isCache;
/**
 *  超时时间
 */
@property (nonatomic,assign,readonly) NSUInteger timeoutInterval;

/**
 *  请求类型
 */
@property (nonatomic, strong,readonly) NSString *requestType;

/**
 * POST GET
 */
@property (nonatomic, assign,readonly) BOOL isGet;
/**
 *  请求名字
 */
@property (nonatomic, strong,readonly) NSString *requestName;

/**
 *  请求路径
 */
@property (nonatomic, strong,readonly) NSString *requestPath;

/**
 *  请求参数
 */
@property (nonatomic, strong,readonly) NSDictionary *params;
/**
 *  请求
 */
@property (nonatomic,strong,readonly) NSMutableURLRequest *urlRequest;

#pragma mark 普通请求
- (instancetype)initWithRequestWithName:(NSString *)name UrlString:(NSString *)urlString Parameters:(id)parameters IsGET:(BOOL)isGET IsCache:(BOOL)isCache;

#pragma mark 普通请求开始
- (void)startRequestWithSuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                         FailedBlock:(CompletionHandlerFailureBlock)failedBlock
                        RequsetStart:(RequstStartBlock)requestStart
                         ResponseEnd:(ResponseEndBlock)responseEnd;

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
- (HttpRequest *)uploadRequestWithRequestName:(NSString *)requestName UrlString:(NSString *)urlString Parameters:(id)parameters PhotoFile:(NSArray *)photoFile IsGET:(BOOL)isGET;

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
                              Progress:(UploadProgressBlock)progress
                          SuccessBlock:(CompletionHandlerSuccessBlock)successBlock
                           FailedBlock:(CompletionHandlerFailureBlock)failedBlock
                          RequsetStart:(RequstStartBlock)requestStart
                           ResponseEnd:(ResponseEndBlock)responseEnd;

#pragma mark 下载任务

/**
 *  下载任务
 *
 *  @param requestName 请求名字
 *  @param URLString   请求路径
 *
 *  @return HttpRequest
 */
- (HttpRequest *)downloadRequestWithrequestName:(NSString *)requestName UrlString:(NSString *)urlString;

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
                             ResponseEnd:(ResponseEndBlock)responseEnd;

/**
 *  获取缓存数据
 */
- (void)getCacheDataWithSuccess:(CompletionHandlerSuccessBlock)success;

#pragma mark 取消任务
/**
 *  取消请求
 */
- (void)cannel;

@end
