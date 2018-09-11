//
//  AppDelegate.m
//  Fortune
//
//  Created by Sj03 on 2017/11/20.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "CommandTool.h"
#import "HZLaunchImageViewController.h"
#import "DSNavViewController.h"
#import "MainViewController.h"

// 引入JPush功能所需头文件
#import <UserNotifications/UserNotifications.h>

#import "CallManager.h"



@interface AppDelegate ()
@property (retain, nonatomic) UIView *bottomView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化友盟sdk
    [self initUMSDK];
    
    [self initWindowWithOptions:launchOptions];
    
    if (@available (iOS 10.0, *)) {
        [[CallManager shareManager] extensionIdentifier:ExtensionIdentifier applicationGroupIdentifier:AppGroupIdentifier];
    }
    
//    [self initJpushSDKWithOptions:launchOptions];
    
    return YES;
}

-(void)initUMSDK {
    [UMConfigure initWithAppkey:kUMAppKey channel:nil];
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    //发布需要移除
    //  [UMConfigure setEncryptEnabled:YES];
    
    [UMConfigure setLogEnabled:NO];
}

#pragma mark 界面初始化
- (void)initWindowWithOptions:(NSDictionary *)launchOptions {
    
    if (![UserDefaultsTool getBoolWithKey:@"isloadApp"]) {
        [UserDefaultsTool setBool:YES withKey:@"isloadApp"];
        NSDate *date = [NSDate date];
        NSDateFormatter *dateformate = [[NSDateFormatter alloc] init];
        dateformate.dateFormat = @"yyyy-MM-dd";
        NSString *str = [dateformate stringFromDate:date];
        [UserDefaultsTool setString:str withKey:@"setAppTime"];
    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    HZLaunchImageViewController *launchVC = [[HZLaunchImageViewController alloc] initWithDefaultImage];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    RACSubject *subject_init = [[RACSubject alloc] init];
    CommandTool *command = [[CommandTool alloc] init];
    
    [[[[subject_init  flattenMap:^RACStream *(id value) {
        // App更新
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if ([UserDefaultsTool getBoolWithKey:isFirstLogin]) {
                [[command.command_haveNewVersion.executionSignals switchToLatest] subscribeNext:^(id x) {
                    [subscriber sendNext:@YES];
                    [subscriber sendCompleted];
                }];
                
                [command.command_haveNewVersion.errors subscribeNext:^(id x) {
                    [subscriber sendNext:@YES];
                    [subscriber sendCompleted];
                }];
                [command.command_haveNewVersion execute:@YES];
            } else {
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }
            return nil;
        }];
        
    }] flattenMap:^RACStream *(id value) {
        // APP 广告页面
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //HZLaunchImageViewController *launchVC = [[HZLaunchImageViewController alloc] init];
            //                launchVC.block_activityViewClicked = ^(ActivityViewClickedTag clickedTag){
            //                    if (!(clickedTag == kActivityViewClickedView)) {
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            //                    } else {
            //
            //                    }
            //                };
            //                self.window.rootViewController = launchVC;
            
            return nil;
        }];
        
    }] flattenMap:^RACStream *(id value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.mainNum = 32;
            MainTabViewController *mainCtl = [[MainTabViewController alloc] init];
            self.window.rootViewController = mainCtl;
            return nil;
        }];
        
    }] subscribeNext:^(id x) {
        
    }];
    
    [subject_init sendNext:@1];
}

+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //设置badge值，本地仍须调用UIApplication:setApplicationIconBadgeNumber函数
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
