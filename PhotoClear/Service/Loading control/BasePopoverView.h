//
//  BasePopoverView.h
//  PANewToapAPP
//
//  Created by Tyson on 14-10-12.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface BasePopoverView : UIView<MBProgressHUDDelegate>

#pragma mark - HUD 封装
/**
 *  查找HUD subview 并且隐藏
 *
 *  @param view     要查找的view
 *  @param animated 是否支持动画
 *  @param title    标题
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDInView:(UIView *)view animated:(BOOL)animated andTitle:(NSString *)title;
/**
 *  在Window中查找 HUD subview 并且隐藏
 *
 *  @param animated 是否支持动画
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDForWindow:(BOOL)animated;
/**
 *  查找HUD subview 并且隐藏， 对应 showHUDAddedTo:animated:
 *
 *  @param view     要查找的view
 *  @param animated 是否支持动画
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
/**
 *  创建一个新的HUD view，添加到Window并且显示，对应 hideHUDForWindow: 来隐藏
 *
 *  @param animated 是否支持动画
 *  @param message  消息内容
 *
 *  @return 返回创建的HUD view
 *
 *  @see hideHUDForWindow:
 */
+ (MBProgressHUD *)showHUDToWindow:(BOOL)animated withMessage:(NSString *)message;


/**
 *  创建一个新的HUD view，添加到view并且显示，对应 hideHUDForView:animated: 来隐藏
 *
 *  @param view     添加的view
 *  @param animated 是否支持动画
 *  @param message  消息内容
 *
 *  @return 返回创建Hud view
 *
 *  @see hideHUDForView:animated:
 */
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message;

/**
 *  XXX成功之后显示HUD XX秒之后消失
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showSuccessHUDToWindow:(NSString *)message;

/**
 *  XXX失败之后显示HUD XX秒之后消失 (此方法不带图片，只有文字)
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showFailHUDToWindow:(NSString *)message;

+ (void)showFailHUDToWindow:(NSString *)message showTime:(CGFloat)second;

/**
 *  XXX失败之后显示HUD XX秒之后消失 (此方法不带图片，只有文字)
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showInfoHUDToWindow:(NSString *)message;

+ (void)myMixedTask:(NSNumber *)number;

/**
 *  XXX失败之后显示HUD XX秒之后消失 (此方法不带图片，只有文字)
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showInfoHUDToWindow:(NSString *)message delay:(NSInteger)delay;

@end
