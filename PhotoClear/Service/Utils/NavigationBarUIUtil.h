//
//  NavigationBarUIUtil.h
//  ZrtTool
//
//  Created by BillyWang on 15/10/23.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NBUtil  NavigationBarUIUtil


// navbar 3个按钮，用于设置tag，设置在背景按钮上面，扩大点击区域
typedef enum {
    NBButtonLeft = 2000,    // 左侧按钮
    NBButtonRight,          // 右侧按钮
    NBButtonRightEx,        // 右侧按钮（靠左的一个）
    NBButtonTitle ,         // 标题
    NBButtonCustom,         // 自定义按钮
} NBButton;


@interface NavigationBarUIUtil : NSObject

// 创建导航栏左侧按钮
+ (UIBarButtonItem *)createLeftBarButton:(NSString *)title target:(id)target selector:(SEL)selector imageName:(NSString *)imageName showArrow:(BOOL)showArrow;

// 创建导航栏右侧按钮 - 一个按钮
+ (UIBarButtonItem *)createRightBarButton:(NSString *)title target:(id)obj selector:(SEL)selector imageName:(NSString *)imageName;

//// 创建导航栏右侧按钮-首页
//+ (UIBarButtonItem *)createRightBarButtonForHomeWithTarget:(id)target selector:(SEL)selector;


#pragma mark - 创建导航栏背景
//+ (UIView *)createNavBG
#pragma mark - 创建标题
#pragma mark - 创建左侧按钮
#pragma mark - 创建右侧按钮

#pragma mark - 创建导航栏

+ (UIView *)createNavBar:(NSString *)title
                leftText:(NSString *)leftText
               leftImage:(NSString *)leftImage
               rightText:(NSString *)rightText
              rightImage:(NSString *)rightImage
             rightTextEx:(NSString *)rightTextEx
            rightImageEx:(NSString *)rightImageEx
                  target:(id)target
                  action:(SEL)action;

// 基类使用 大部分是这种
+ (UIView *)createNavBar:(NSString *)title
               leftImage:(NSString *)leftImage
              rightImage:(NSString *)rightImage
                  target:(id)target
                  action:(SEL)action;

+ (UIView *)createNavBar:(NSString *)title
          leftButtonText:(NSString *)leftButtonText
         rightButtonText:(NSString *)rightButtonText
       rightButtonTextEx:(NSString *)rightButtonTextEx
                  target:(id)target
                  action:(SEL)action;



@end
