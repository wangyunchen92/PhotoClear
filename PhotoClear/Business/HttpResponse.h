//
//  HttpResponse.h
//  XLAFNetworking
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpError;

static NSString  *const DATA_FORMAT_ERROR = @"数据格式错误";
static NSString  *const NETWORK_UNABLE = @"网络状况异常";
static NSString  *const REQUEST_FAILE = @"网络请求失败";
static NSString  *const NETCONNECT_FAILE = @"无网络连接！";
static NSString  *const NETCONNECTTIME_FAILE = @"网络连接超时，请稍后再试！";

static NSString  *const CODE_SUCCESS        = @"200";
static NSString  *const CODE_TOKEN_ABNORMAL = @"-1";
static NSString  *const CODE_UPDATE         = @"301";



@interface HttpResponse : NSObject <NSCoding>

/**
 *  是否成功
 */
@property (nonatomic,assign,readonly) BOOL isSuccess;

/**
 *  响应名字
 */
@property (nonatomic,strong,readwrite) NSString *responseName;

/**
 *  错误代码
 */
@property (nonatomic,strong,readwrite) NSString *errorCode;

/**
 *  错误信息
 */
@property (nonatomic,strong,readwrite) NSString *errorMsg;

/**
 *  未处理之前的数据
 */
@property (nonatomic,assign,readwrite) NSDictionary *objectData;

/**
 *  结果数据
 */
@property (nonatomic,strong,readwrite) NSDictionary *result;

/**
 *  错误
 */
@property (nonatomic,strong,readwrite) HttpError *httpError;

/**
 *  响应返回数据处理
 *
 *  @param ObjectData 解析数据
 */
- (void)loadResopnseWithObjectData:(NSDictionary *)objectData;

@end
