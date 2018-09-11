//
//  BackgroundViewController.m
//  ColorfulFund
//
//  Created by Madis on 16/9/30.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "BackgroundViewController.h"
#import "LoginViewController.h"

@interface BackgroundViewController ()
@property (nonatomic, copy) void(^autoLoginCallback)(void);
@end

@implementation BackgroundViewController
static BackgroundViewController *_instance = nil;
+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BackgroundViewController alloc]init];
        _instance.messageUnReadCount = @"";
      });
    return _instance;
}

// 调出登录界面,统一从rootController跳转
- (void)showLoginViewController:(LoginViewController *)loginVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
}

// 调出登录界面
- (void)showLoginViewController:(LoginViewController *)loginVC animated:(BOOL)animated completion:(void (^ __nullable)(void))completion
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    [rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:animated completion:^{
        if (completion) {
            completion();
        }
    }];
}



//
//- (RACSignal *)signal_requestForAutoLogin
//{
//    // 自动登录
//    NSString *account = [UserDefaultsTool getStringWithKey:userAccountIdentifier];
//    NSString *password = [UserDefaultsTool getStringWithKey:userPasswordIdentifier];
//    MSLog(@"将要发起自动登录account= %@, password = %@", account, password);
//    if([account isEqualToString:@""] || [password isEqualToString:@""]){
//        return [RACSignal empty];
//    }
//    return [self signal_loginNetworkRequestWith:account password:password];
//}
//
//
//#pragma mark sessionTimeout
//- (void)sessionTimeoutAction:(NSNotification *)notify
//{
//    NSDictionary *responseDict = (NSDictionary *)notify.object;
//    if(responseDict && responseDict[@"optype"]){
//        NSString *optype = responseDict[@"optype"];
//        if(![optype isEqualToString:@"/user/logoff"]  && ![optype isEqualToString:@"/user/refreshUserSession"]){
//            // session 超时,自动登录
//            UserInfo *userInfo = [UserInfo shareInstance];
//            if(userInfo.isLoginStatus){
//                userInfo.isLoginStatus = NO;
//                [self autoLogin];
//            }
//            //    [self showLoginViewController:[[LoginViewController alloc] init]];
//        }
//    }
//}
//
//#pragma mark login action networkRequest
//- (RACSignal *)signal_loginNetworkRequestWith:(NSString *)userAccout password:(NSString *)password
//{
//    [BasePopoverView showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES withMessage:@"正在登录..."];
//    return [[[[[[Login signal_requestWithloginName:userAccout password:password] deliverOnMainThread]
//               doNext:^(CallBackModel_Login *x) {
//                   [BasePopoverView hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
//                   MSLog(@"自动登陆成功");
//                   // 登录成功保存用户个人信息
//                   {
//                       HZAuthorModel *authorInfo = [[HZAuthorModel alloc]init];
//                       authorInfo.authorName = x.userInfo.nickname;
//                       authorInfo.authorPhoto = x.userInfo.photoUrl;
//                       authorInfo.phoneNumber = x.userInfo.phone;
//                       authorInfo.userId = x.userInfo.userId;
//                       authorInfo.loginTime = x.userInfo.lastLogin;
//                       authorInfo.userAlias = x.userInfo.userAlias;
//                       NSMutableArray *tagArray = [NSMutableArray array];
//                       for (Login_UserTagsObject *tagObj in x.userInfo.userTagsArray) {
//                           HZPushTagObject *pushTag = [HZPushTagObject new];
//                           pushTag.tagCode = tagObj.tagCode;
//                           [tagArray addObject:pushTag];
//                       }
//                       authorInfo.tagCodeArray = tagArray;
//
//                       [[UserInfo shareInstance] saveUserInfoToUserDefaultsWithAuthorInfo:authorInfo];
//                       MSLog(@"userInfo nickName == %@\nphoneNumber == %@\nuserid == %@", authorInfo.authorName, authorInfo.phoneNumber,authorInfo.userId);
//                   }
//                   // 设置登录状态存储用户名及密码信息
//                   {
//                       [[UserInfo shareInstance] setIsLoginStatus:YES];// 设置为登录成功状态
//                       [UserDefaultsTool setString:userAccout withKey:userAccountIdentifier];
//                       [UserDefaultsTool setString:password withKey:userPasswordIdentifier];
//                       [UserDefaultsTool setBool:YES withKey:isLoginIdentifier];
//                   }
//                   //登陆成功发送通知
//                   [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:@"登陆成功" userInfo:nil];
//               }] flattenMap:^RACStream *(id value) {
//                   NSString *userId = [UserDefaultsTool getStringWithKey:userIdIdentifier];
//                   //消息未读数
//                   RACSignal *signal_requestUnReadMessageCount = [[self signal_requestForNewsUnReadCount:userId] catchTo:[RACSignal empty]];
//                   //活动信息
//                   RACSignal *signal_requestForActivityInfo = [[BackgroundViewController share] signal_requestForActivityInfo];
//                   return [RACSignal merge:@[signal_requestUnReadMessageCount,
//                                             signal_requestForActivityInfo]];
//               }] doError:^(NSError *error) {
////                   [BasePopoverView showFailHUDToWindow:@"登录失败,请稍后重试"];
//                   [BasePopoverView hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
//                   MSLog(@"自动登录失败");
//               }] doCompleted:^{
//
//               }];
//}
//
//#pragma mark RACSignal check version
//- (RACSignal *)signal_checkUpVersionUpdate
//{
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        MSLog(@"升级提醒");
//            NSString *oldVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//            VersionInfoObject *versionInfo = [INIT share].versionInfo;
//            NSString *currentVersion = versionInfo.currentVersion;
//            NSString *tipUpdateString = versionInfo.tipUpdateString;
//            NSString *iosDownloadUrl = versionInfo.iosDownloadUrl;
//            BOOL upgradeType = versionInfo.upgradeType;
//            if ([oldVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
//                NSString *msg = tipUpdateString.length > 0 ? tipUpdateString : @"尊敬的用户：\r\t欢迎您的到来，多彩基金感到荣幸和踏实。";
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//
//                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iosDownloadUrl]];
//                    if(upgradeType){
//                        UIWindow *window = [UIApplication sharedApplication].delegate.window;
//                        [UIView animateWithDuration:0.5f animations:^{
//                            window.alpha = 0;
//                            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//                        } completion:^(BOOL finished) {
//                            exit(0);
//                        }];
//                    }
//                    [subscriber sendNext:@YES];
//                    [subscriber sendCompleted];
//                }];
//
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    if (upgradeType) {// 强制更新否则退出程序
//                        // 强制更新时，退出程序
//                        UIWindow *window = [UIApplication sharedApplication].delegate.window;
//                        [UIView animateWithDuration:1.0f animations:^{
//                            window.alpha = 0;
//                            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//                        } completion:^(BOOL finished) {
//                            exit(0);
//                        }];
//                    }
//                    [subscriber sendNext:@NO];
//                    [subscriber sendCompleted];
//                }];
//
//                [alertController addAction:cancelAction];
//                [alertController addAction:okAction];
//
//                // 获取当前已经跳转出的VC
//                UIViewController *tabVC = kUIWindow.rootViewController;
//                if (tabVC.presentedViewController) {
//                    tabVC = tabVC.presentedViewController;
//                }
//                [tabVC presentViewController:alertController animated:YES completion:nil];
//            } else {
//                [subscriber sendNext:@YES];
//                [subscriber sendCompleted];
//            }
//        return nil;
//    }];
//}
//
//#pragma mark check version
//- (BOOL)checkUpVersionUpdate
//{
//    NSString *oldVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//    VersionInfoObject *versionInfo = [INIT share].versionInfo;
//    NSString *currentVersion = versionInfo.currentVersion;
//    NSString *tipUpdateString = versionInfo.tipUpdateString;
//    NSString *iosDownloadUrl = versionInfo.iosDownloadUrl;
//    BOOL upgradeType = versionInfo.upgradeType;
//    if ([oldVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
//        NSString *msg = tipUpdateString.length > 0 ? tipUpdateString : @"尊敬的用户：\r\t欢迎您的到来，多彩基金感到荣幸和踏实。";
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iosDownloadUrl]];
//            if(upgradeType){
//                UIWindow *window = [UIApplication sharedApplication].delegate.window;
//                [UIView animateWithDuration:0.5f animations:^{
//                    window.alpha = 0;
//                    window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//                } completion:^(BOOL finished) {
//                    exit(0);
//                }];
//            }
//        }];
//
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            if (upgradeType) {// 强制更新否则退出程序
//                // 强制更新时，退出程序
//                UIWindow *window = [UIApplication sharedApplication].delegate.window;
//                [UIView animateWithDuration:1.0f animations:^{
//                    window.alpha = 0;
//                    window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//                } completion:^(BOOL finished) {
//                    exit(0);
//                }];
//            }
//        }];
//
//        [alertController addAction:cancelAction];
//        [alertController addAction:okAction];
//
//        // 获取当前已经跳转出的VC
//        UIViewController *tabVC = kUIWindow.rootViewController;
//        if (tabVC.presentedViewController) {
//            tabVC = tabVC.presentedViewController;
//        }
//        [tabVC presentViewController:alertController animated:YES completion:nil];
//
//
//        return YES;
//    }
//    return NO;
//}
//
//- (void)checkUpNewVersionInfo:(void(^)(BOOL needUpdate,
//                                       NSString *showMsg,
//                                       NSString *downLoadURL,
//                                       BOOL upgradeType))callBack
//{
//    NSString *oldVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//    VersionInfoObject *versionInfo = [INIT share].versionInfo;
//    NSString *currentVersion = versionInfo.currentVersion;
//    //更新话术
//    NSString *tipUpdateString = versionInfo.tipUpdateString;
//    //下载地址
//    NSString *iosDownloadUrl = versionInfo.iosDownloadUrl;
//    //是否强制更新
//    BOOL upgradeType = versionInfo.upgradeType;
//    if ([oldVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
//        NSString *msg = tipUpdateString.length > 0 ? tipUpdateString : @"尊敬的用户：\r\t欢迎您的到来，多彩基金感到荣幸和踏实。";
//        callBack(YES,msg,iosDownloadUrl,upgradeType);
//    }else{
//        callBack(NO,tipUpdateString,iosDownloadUrl,upgradeType);
//    }
//}
//
//- (RACSignal *)signal_requestForActivityInfo
//{
//    MSLog(@"signal_requestForActivityInfo times");
//    RACSignal *signal_requestForExperienceActivityInfo = [[[ActivityInfo shareInstance] signal_requestForExperienceActivityInfo] catchTo:[RACSignal empty]];
//
//    RACSignal *signal_requestForCommonActivityInfo = [[[ActivityInfo shareInstance] signal_requestForCommonActivityInfo] catchTo:[RACSignal empty]];
//
////    RACMulticastConnection *connectSignal = [[RACSignal zip:@[signal_requestForExperienceActivityInfo,
////                              signal_requestForCommonActivityInfo]] publish];
////    [connectSignal connect];
////    return [connectSignal signal];
//    return [RACSignal zip:@[signal_requestForExperienceActivityInfo,
//                            signal_requestForCommonActivityInfo]];
//}
//
//#pragma mark MajordomoNewsUnReadCount
//- (RACSignal *)signal_requestForNewsUnReadCount:(NSString *)userId
//{
//    @weakify(self);
//    return [[[[[GetUnreadNo4FortuneMgrMsg4C signal_requestWithuserId:userId] deliverOnMainThread] doNext:^(CallBackModel_GetUnreadNo4FortuneMgrMsg4C* x) {
//        @strongify(self);
//        //有新管家动态时候，显示红点数字，红点数字最大2位数，超过2位数显示...
//        NSString *messageUnReadNumber = x.unreadMsgNumberInfo.unreadMsgNumber;
//        MSLog(@"请求消息未读数成功:%@未读",messageUnReadNumber);
//        if([messageUnReadNumber integerValue] ==0){
//            self.messageUnReadCount = @"";
//        }else if([messageUnReadNumber integerValue] >99){
//            self.messageUnReadCount = @"···";
//        }else{
//            self.messageUnReadCount = @"···";
////            messageUnReadNumber;
//        }
//    }] doError:^(NSError *error) {
//        MSLog(@"请求消息未读数失败");
//    }] catchTo:[RACSignal empty]];
//}
//
//#pragma mark 处理统一跳转到绑卡界面
//- (RACSignal *)signal_requestUserFirstInvitation:(NSString *)userID
//{
//    return [[[[IsInviteValid signal_requestWithuserid:userID]
//            doNext:^(CallBackModel_IsInviteValid *x) {
//                HZAuthorModel *author = [[UserInfo shareInstance] authorInfo];
//                if (x.isInviteValid && [author.loginTime isEqualToString:@"0"]) {
//                    // 跳转至绑卡页面
//                    UITabBarController *rootViewController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//                    // 请求银行卡列表接口
//                    [[[GetUserBankCards4C signal_request] deliverOnMainThread] subscribeNext:^(CallBackModel_GetUserBankCards4C *x) {
//                        HZBankCardListViewController *bankCardListViewController = [[HZBankCardListViewController alloc] initWithModel:x.userBankCardListArray];
//                        UINavigationController *nav = rootViewController.selectedViewController;
//                        if (![nav.viewControllers.firstObject isKindOfClass:[FamilyViewController class]]) {
//                            bankCardListViewController.hidesBottomBarWhenPushed = YES;
//                        }
//                        bankCardListViewController.block_firstInvitedBindingCardTipMessage = ^{
//                            [CustomProgressHUD showCustomInfoImage:@"万元体验金" withContentMessage:@"您领取了好友的红包\n红包将返回到您绑定的活动支持银行卡中，请绑卡" sleepTime:3];
//                        };
//                        MSLog(@"rootViewController.navigationController == %@", rootViewController.navigationController);
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [rootViewController.selectedViewController pushViewController:bankCardListViewController animated:YES];
//                        });
//                        MSLog(@"response %@", x);
//                    } error:^(NSError *error) {
//                    }];
//                }
//                MSLog(@"用户被邀请跳转绑卡页面");
//            }] doError:^(NSError *error) {
//
//            }] catchTo:[RACSignal empty]];
//}
@end
