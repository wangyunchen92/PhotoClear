//
//  HttpError.h
//  XLAFNetworking
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpError : NSObject

/**
 *  响应名字
 */
@property (nonatomic,strong) NSString *responseName;

/**
 *  错误的URL
 */
@property (nonatomic,strong) NSString *failingURLString;

/**
 *  错误信息
 */
@property (nonatomic,strong) NSString *localizedDescription;
/**
 *  错误代码
 */
@property (nonatomic,strong) NSString *errorCode;

/**
 *  错误信息
 */
@property (nonatomic,strong) NSString *errorMsg;

/**
 *  处理错误
 *
 *  @param error 错误对象
 */
- (void)handleHttpError:(NSError *)error;

@end
