//
//  Config.h
//  Fortune
//
//  Created by Sj03 on 2017/11/21.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

/*-------------------------预处理-----------------*/
#define dispatch_main_async(block) \
if ([NSThread isMainThread]) { \
block(); \
} \
else { \
dispatch_async(dispatch_get_main_queue(), block); \
}


#define kChannel              @"qsjk"
#define KType                 @"qsjk"
#define kJpushAppKey          @"bf435c4f4bb479fb6e11da1e"
#define kUMAppKey             @"5b84aaabf29d9841bb000021"
#define kIsProduct            YES

//应用名称(保证唯一性)
#define ServiceName @"com.Fortune.youmeng"
#define ServiceAccount @"1"


// CallKitExtension bundle ID
#define ExtensionIdentifier @"com.PhotoClear.youmeng.PhotoClearCall"
// app group id
#define AppGroupIdentifier @"group.PhotoClearGroup"


//重新定义宏定义
#define LOG_LEVEL_DEF ddLogLevel
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#define LOG_ASYNC_ENABLED YES

//log日志输出
#ifdef DEBUG
//DDLogVerbose>DDLogDebug>DDLogInfo>DDLogWarn>DDLogError
#define MSLog(...) DDLogVerbose(__VA_ARGS__)
//NSLog(__VA_ARGS__)
//printf("\n%s %s:%s",__TIME__,__FUNCTION__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define MSLog(...) DDLogVerbose(__VA_ARGS__)
#endif


#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif



#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本
#define kAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kAppVersions [NSString stringWithFormat:@"%@.%@",[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] componentsSeparatedByString:@"."][0],[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] componentsSeparatedByString:@"."][1]]

#define kUIWindow             [[UIApplication sharedApplication].delegate window] 

#define kScreenBounds         [[UIScreen mainScreen] bounds]
#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kApplicationSize      [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth     [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)

#define RGB(r,g,b)          RGBA(r,g,b,1)
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00)>> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00)>> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define IMAGE_NAME(name)    [UIImage imageNamed:name]

#define kColorTitleBlack    UIColorFromRGB(0x333333)
#define kColorHWBlack       UIColorFromRGB(0x222222)
#define kColorWeekWhite     UIColorFromRGB(0xf1f1f1)
#define kFontHWSmall        [UIFont systemFontOfSize:17.0]


// 默认值
#define Version                @"2"
#define kNBButtonWidth          50
#define kNBTitleWidth           160

#define kHeightStatusBar        20
#define kHeightTabBar           49
#define kHeightNavigation       64
#define kHeightNavigationCustomView 30
#define kHeightCustomNavigation kHeightNavigation+kHeightNavigationCustomView

#define kHeightButtonBig        49
#define kHeightCellNormal       44
#define kHeightNormal           30
#define kHeightCellNormalEx     40



// 请求错误code
static NSString *const kRequestSuccessfulCode = @"1000";
static NSString *const kRequestErrorCode   = @"1001";
static NSString *const kSessionTimeoutCode = @"1002";

// 登录状态
static NSString *const isLoginIdentifier = @"isLogin";// 是否登录
static NSString *const userAccountIdentifier = @"account"; //账户
static NSString *const userPasswordIdentifier = @"userPassword";
static NSString *const userIdIdentifier = @"userId";// 用户id
static NSString *const userNameIdentifier = @"userName"; // 用户名
static NSString *const phoneNumberIdentifier = @"phoneNumber"; //手机号码

static NSString *const FortuneNumber = @"FortuneNumber";

// 记录用户状态
static NSString *const LoginDate = @"LoginDate";
static NSString *const isFirstLogin= @"isFirstLogin"; // 是否第一次启动




#define requestErrorStrings(error)  \
NSString *errorString = @"";\
if (error.userInfo) {\
NSDictionary *dict = error.userInfo;\
errorString = [NSString stringWithFormat:@"NSDebugDescription:%@",dict[@"NSDebugDescription"]];\
}else{\
errorString = error.description;\
}\
[[[UIAlertView alloc] initWithTitle:@"温馨提示" \
message:[NSString stringWithFormat:@"url:%@\nparams:%@\nerror.description:%@",url,params,errorString]\
delegate:nil\
cancelButtonTitle:@"好的" \
otherButtonTitles:nil] show];\

#define NAV_BACKBUTTON_DISABLE(sender) \
NSAssert([sender isKindOfClass:[UIButton class]], @"sender必须是UIButton类型");\
[(UIButton*)sender setEnabled:NO];



typedef NS_ENUM(NSInteger, NewType) {
    OneImage_NewType          = 0,//一张图片的新闻
    ThreeImage_NewType        = 1,//两张图片的新闻
};

typedef NS_ENUM(NSInteger,CeSuanType) {
    fortune_CeSuanType     = 0,
    marry_CeSuanType       = 1,
    name_CeSuanType        = 2,
};


#endif /* Defines_h */
