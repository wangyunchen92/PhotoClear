//
//  BasePopoverView.m
//  PANewToapAPP
//
//  Created by Tyson on 14-10-12.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import "BasePopoverView.h"

#define CurrentView    [UIApplication sharedApplication].keyWindow.rootViewController.view
#define kWindow        [[[UIApplication sharedApplication] delegate] window]

@implementation BasePopoverView

#pragma mark - HUD 封装
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
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated withMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if(!message)
    {
        hud.detailsLabelText = @"正在加载";
    }
    else{
        hud.detailsLabelText = message;
    }
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];

    return hud;
}

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
+ (MBProgressHUD *)showHUDToWindow:(BOOL)animated withMessage:(NSString *)message
{
    //UIWindow *window = [[[UIApplication sharedApplication] delegate] window];

    return [BasePopoverView showHUDAddedTo:kWindow animated:animated withMessage:message];
}

/**
 *  XXX成功之后显示HUD XX秒之后消失
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showSuccessHUDToWindow:(NSString *)message
{
   // UIView* currentView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:CurrentView];
    [CurrentView addSubview:hud];
    hud.customView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"MBProgressSucceed"]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud showWhileExecuting:@selector(myMixedTask:) onTarget:self withObject:[NSNumber numberWithFloat:1] animated:YES];
}

+ (void)myMixedTask:(NSNumber *)number {
    
    CGFloat delay = number.floatValue;
    sleep(delay);
}

/**
 *  XXX失败之后显示HUD XX秒之后消失 (此方法不带图片，只有文字)
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showFailHUDToWindow:(NSString *)message
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:kWindow];
    [kWindow addSubview:hud];
    hud.customView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"MBProgressFailed"]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud showWhileExecuting:@selector(myMixedTask:) onTarget:self withObject:[NSNumber numberWithFloat:1.0] animated:YES];
}

+ (void)showFailHUDToWindow:(NSString *)message showTime:(CGFloat)second
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:kWindow];
    [CurrentView addSubview:hud];
    hud.customView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"MBProgressFailed"]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud showWhileExecuting:@selector(myMixedTask:) onTarget:self withObject:[NSNumber numberWithFloat:second] animated:YES];
}

/**
 *  XXX失败之后显示HUD XX秒之后消失 (此方法不带图片，只有文字)
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showInfoHUDToWindow:(NSString *)message delay:(NSInteger)delay
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:kWindow];
    [CurrentView addSubview:hud];
    hud.customView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"MBProgressInfo"]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud showWhileExecuting:@selector(myMixedTask:) onTarget:self withObject:[NSNumber numberWithFloat:delay] animated:YES];
}

/**
 *  XXX失败之后显示HUD XX秒之后消失 (此方法不带图片，只有文字)
 *
 *  @param message 消息内容
 *  @param delay   延迟多少秒消失
 */
+ (void)showInfoHUDToWindow:(NSString *)message
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:kWindow];
    [CurrentView addSubview:hud];
    hud.customView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"MBProgressInfo"]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud showWhileExecuting:@selector(myMixedTask:) onTarget:self withObject:[NSNumber numberWithFloat:1.0] animated:YES];
}

/**
 *  查找HUD subview 并且隐藏， 对应 showHUDAddedTo:animated:
 *
 *  @param view     要查找的view
 *  @param animated 是否支持动画
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated
{
    //    debug_NSLog_Line();
    
    __block BOOL isHud = NO;
    //dispatch_block_t block = ^{@autoreleasepool{
        isHud = [MBProgressHUD hideAllHUDsForView:view animated:animated];
    //}};
    
    //dispatch_main_async(block);
    
    return isHud;
}

/**
 *  在Window中查找 HUD subview 并且隐藏
 *
 *  @param animated 是否支持动画
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDForWindow:(BOOL)animated
{
    //    debug_NSLog_Line();
    //UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    return [BasePopoverView hideHUDForView:kWindow animated:animated];
}

/**
 *  查找HUD subview 并且隐藏
 *
 *  @param view     要查找的view
 *  @param animated 是否支持动画
 *  @param title    标题
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDInView:(UIView *)view animated:(BOOL)animated andTitle:(NSString *)title
{
    //    debug_NSLog_Line();
    
    __block BOOL isHud = NO;
    dispatch_block_t block = ^{@autoreleasepool{
        //isHud = [MBProgressHUD hideHUDInView:view animated:animated andTitle:title];
    }};
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
    
    return isHud;
}
/**
 *  查找HUD subview 并且隐藏
 *
 *  @param view     要查找的view
 *  @param animated 是否支持动画
 *  @param title    标题
 *  @param delay    延时
 *
 *  @return 返回 是否隐藏
 */
+ (BOOL)hideHUDInView:(UIView *)view animated:(BOOL)animated andTitle:(NSString *)title afterDelay:(NSTimeInterval)delay
{
    //	debug_NSLog_Line();
    
    __block BOOL isHud = NO;
    dispatch_block_t block = ^{@autoreleasepool{
        //isHud = [MBProgressHUD hideHUDInView:view animated:animated andTitle:title afterDelay:delay];
    }};
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
    
    return isHud;
}

@end
