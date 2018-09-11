//
//  BackgroundViewController.h
//  ColorfulFund
//
//  Created by Madis on 16/9/30.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "BaseViewController.h"
@class LoginViewController;
@class AutoLoginHelper;

@interface BackgroundViewController : BaseViewController
+ (instancetype _Nullable )share;
//消息未读数
@property (nonatomic,copy) NSString *messageUnReadCount;

- (void)showLoginViewController:(LoginViewController *)loginVC;
- (void)showLoginViewController:(LoginViewController *)loginVC animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
/** 当前用户是否登录 */
- (BOOL)isUserLogin;
//- (void)autoLogin;// 自动登录
//- (void)autoLoginWithBlock:(void(^)(BOOL loginStatus))loginBlock;
//
//- (RACSignal *)signal_requestForAutoLogin;
//- (BOOL)checkUpVersionUpdate;// app更新
//- (void)checkUpNewVersionInfo:(void(^)(BOOL needUpdate,
//                                       NSString *showMsg,
//                                       NSString *downLoadURL,
//                                       BOOL upgradeType))callBack;
//- (RACSignal *)signal_checkUpVersionUpdate;
//
//- (RACSignal *)signal_requestForActivityInfo;
//- (RACSignal *)signal_requestForNewsUnReadCount:(NSString *)userId;
//- (RACSignal *)signal_requestUserFirstInvitation:(NSString *)userID;

@end
