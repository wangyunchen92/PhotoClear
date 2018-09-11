//
//  HttpClient.h
//  XLAFNetworking
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "UploadModel.h"
#import "HttpFileLoadProgress.h"
#import "HttpRequestMode.h"
#import "NSMutableDictionary+Utils.h"

#define HTTPCLIENT [HttpClient sharedInstance]

@interface HttpClient : NSObject
/**
 *  单例
 *
 *  @return 返回实例
 */
+ (HttpClient *)sharedInstance;

/**
 *  校验网络状态
 *  网络状态
 *  1 网络不通
 *  2 WIFI
 *  3 3G 4G
 *  4 未知
 *  @param nil
 */
- (void)checkNetworkingStatus:(NetwokingStatusBlcok)block;

#pragma mark ----------------------Create Request----------------------


- (void)requestApiWithHttpRequestMode:(HttpRequestMode *)requestMode
                              Success:(CompletionHandlerSuccessBlock)success
                              Failure:(CompletionHandlerFailureBlock)failure;
/**
 *  创建普通接口请求
 *
 *  @param requestMode  请求模型
 *  @param success      成功回调
 *  @param failure      失败回调
 *  @param requestStart 请求开始回调
 *  @param responseEnd  请求结束回调
 *
 *  @return nil
 */
- (void)requestApiWithHttpRequestMode:(HttpRequestMode *)requestMode
                                       Success:(CompletionHandlerSuccessBlock)success
                                       Failure:(CompletionHandlerFailureBlock)failure
                                  RequsetStart:(RequstStartBlock)requestStart
                                   ResponseEnd:(ResponseEndBlock)responseEnd;

/**
 *  创建普通接口请求（带缓存）
 *
 *  @param requestMode  请求模型
 *  @param success      成功回调
 *  @param failure      失败回调
 *  @param requestStart 请求开始回调
 *  @param responseEnd  请求结束回调
 *
 *  @return nil
 */
- (void)requestApiCacheWithHttpRequestMode:(HttpRequestMode *)requestMode
                                   Success:(CompletionHandlerSuccessBlock)success
                                   Failure:(CompletionHandlerFailureBlock)failure
                              RequsetStart:(RequstStartBlock)requestStart
                               ResponseEnd:(ResponseEndBlock)responseEnd;

/**
 *  上传文件接口请求
 *
 *  @param requestMode  请求模型
 *  @param progress     进度条回调
 *  @param success      成功回调
 *  @param failure      失败回调
 *  @param requestStart 请求开始回调
 *  @param responseEnd  请求结束回调
 *
 *  @return 返回请求对象
 */
- (HttpRequest *)uploadPhotoWithHttpRequestMode:(HttpRequestMode *)requestMode
                                       Progress:(UploadProgressBlock)progress
                                        Success:(CompletionHandlerSuccessBlock)success
                                        Failure:(CompletionHandlerFailureBlock)failure
                                   RequsetStart:(RequstStartBlock)requestStart
                                    ResponseEnd:(ResponseEndBlock)responseEnd;

/**
 *  下载文件接口请求
 *
 *  @param requestMode  请求模型
 *  @param progress     进度条回调
 *  @param destination  文件保存路径回调
 *  @param success      成功回调
 *  @param failure      失败回调
 *  @param requestStart 请求开始回调
 *  @param responseEnd  请求结束回调
 *
 *  @return 返回请求对象
 */
- (HttpRequest *)downloadPhotoWithHttpRequestMode:(HttpRequestMode *)requestMode
                                         Progress:(UploadProgressBlock)progress
                                      Destination:(downloadDestinationBlock)destination
                                          Success:(CompletionHandlerSuccessBlock)success
                                          Failure:(CompletionHandlerFailureBlock)failure
                                     RequsetStart:(RequstStartBlock)requestStart
                                      ResponseEnd:(ResponseEndBlock)responseEnd;


-(NSString* )getTokenWithParam:(NSDictionary* )params;

@end
