//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"
#import "UIImage+GIF.h"


@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (MBProgressHUD *)showGifToView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //使用SDWebImage 放入gif 图片
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    
    //自定义imageView
    UIImageView *cusImageV = [[UIImageView alloc] initWithImage:image];
    
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    
    //设置方框view为该模式后修改颜色才有效果
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //设置方框view背景色
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    //设置总背景view的背景色，并带有透明效果
   // hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    hud.customView = cusImageV;
    return hud;
}
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    
    if (text == nil || [text length] == 0) {
        return;
    }
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    
//    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 100)];
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];//48X48
//    iv.image = [UIImage imageNamed:icon];
//    iv.center = CGPointMake(tipView.center.x, iv.center.y);
    //    [tipView addSubview:iv];
//    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, CGRectGetWidth(tipView.bounds), CGRectGetHeight(tipView.bounds) - 48)];
//    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(tipView.bounds), CGRectGetHeight(tipView.bounds) - 20)];
//    tipLab.text = text;
//    tipLab.textColor = [UIColor whiteColor];
//    tipLab.textAlignment = NSTextAlignmentCenter;
//    tipLab.font = [UIFont systemFontOfSize:15];
//    tipLab.numberOfLines = 0;
//    tipLab.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
//    [tipView addSubview:tipLab];
    
    // 设置图片
//    hud.customView = tipView;
    // 再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
    
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}


#pragma mark 显示失败/成功/警告信息

+ (void)showNetErrorInView:(UIView* )view{
    [self show:@"网络连接超时，请检查网络或稍候重试！" icon:@"HUD_warn" view:view];
}
+ (void)showFail:(NSString *)tip view:(UIView *)view {
    [self show:tip icon:@"HUD_fail" view:view];
}

+ (void)showSuccess:(NSString *)tip view:(UIView *)view {
    [self show:tip icon:@"HUD_success" view:view];
}

+ (void)showWarn:(NSString *)tip view:(UIView *)view {
    [self show:tip icon:@"HUD_warn" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:15];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = NO;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error ToView:(UIView *)view{
    [self showCustomIcon:@"error.png" Title:error ToView:view];
}

+ (void)showSuccess:(NSString *)success ToView:(UIView *)view
{
    [self showCustomIcon:@"success.png" Title:success ToView:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.textColor = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

//加载视图
+(void)showLoadToView:(UIView *)view{
    [self showMessage:@"加载中..." ToView:view];
}


//下载视图
+(void)showDownloadToView:(UIView *)view{
    [self showMessage:@"下载中..." ToView:view];
}
/**
 *  进度条View
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view ProgressMode:(MBProgressHUDMode)mode Text:(NSString *)text{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = mode;
    hud.labelText = text;
    return hud;
}


//快速显示一条提示信息
+ (void)showAutoMessage:(NSString *)message{
    
    [self showAutoMessage:message ToView:nil];
}


//自动消失提示，无图
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view{
    [self showMessage:message ToView:view RemainTime:0.9 Model:MBProgressHUDModeText];
}

//自定义停留时间，有图
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
}

//自定义停留时间，无图
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeText];
}

+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time Model:(MBProgressHUDMode)model{
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    //模式
    hud.mode = model;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // X秒之后再消失
    [hud hide:YES afterDelay:time];
}

+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    // 设置图片
    if ([iconName isEqualToString:@"error.png"] || [iconName isEqualToString:@"success.png"]) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", iconName]]];
    }else{
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.9];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


@end
