//
//  UserInfo.h
//  Fortune
//
//  Created by Sj03 on 2017/11/21.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic, assign) BOOL isLoginStatus;// 当前用户的登录状态
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *loginTime;// 登录时间，为0则是首次登录
+ (instancetype)shareInstance;
@end
