//
//  UserInfo.m
//  Fortune
//
//  Created by Sj03 on 2017/11/21.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import "UserInfo.h"
static UserInfo *_instance;

@implementation UserInfo
+ (id)shareInstance
{
    //里面的代码永远都只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *name = [UserDefaultsTool getStringWithKey:userNameIdentifier];
        self.authorName = name ? name:@"";
        NSString *phoneNumber = [UserDefaultsTool getStringWithKey:phoneNumberIdentifier];
        self.phoneNumber = phoneNumber ? phoneNumber:@"";
        NSString *userId = [UserDefaultsTool getStringWithKey:userIdIdentifier];
        self.userId = userId ? userId:@"";
        BOOL isLoginStatus = [UserDefaultsTool getBoolWithKey:isLoginIdentifier];
        self.isLoginStatus = isLoginStatus;
    }
    return self;
}



- (void)saveUserInfoToUserDefaultsWithAuthorInfo:(UserInfo *)authorInfo
{
    [UserDefaultsTool setString:authorInfo.userId withKey:userIdIdentifier];
    [UserDefaultsTool setString:authorInfo.authorName withKey:userNameIdentifier];
    [UserDefaultsTool setString:authorInfo.phoneNumber withKey:phoneNumberIdentifier];
    [UserDefaultsTool setBool:authorInfo.isLoginStatus withKey:isLoginIdentifier];
}

- (void)requestPoAssetWithPoCode:(NSString *)poCode
                        callBack:(void (^)(BOOL isSucessed,id callBackObject) )callBack {
    
}




@end
