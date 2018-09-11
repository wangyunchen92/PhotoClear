//
//  SimpleNavigationBar.h
//  Midas
//
//  Created by BillyWang on 15/12/11.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBarUIUtil.h"



#define NBFrameBG               CGRectMake(0, 0, kScreenWidth, kHeightNavigation)
#define NBFrameBGIPHONEX        CGRectMake(0, 24, kScreenWidth, kHeightNavigation)

#define NBFrameLeftBtnBG        CGRectMake(0, kHeightStatusBar, kNBButtonWidth, kHeightCellNormal)
#define NBFrameMainBtnLeft      CGRectMake(20, 12, 11, 20)
#define NBFrameMainBtn          CGRectMake(0, 0, kNBButtonWidth, kHeightCellNormal)
#define NBFrameMainBtnText      CGRectMake(0, 0, kNBButtonWidth, kHeightCellNormal)
#define NBFrameRightBtnBG       CGRectMake(kScreenWidth - kNBButtonWidth, kHeightStatusBar, kNBButtonWidth, kHeightCellNormal)

/**
 *  修改右前侧按钮位置
 *
 */
#define NBFrameRightBtnExBG     CGRectMake(kScreenWidth - kNBButtonWidth * 2 + 15.0f, kHeightStatusBar, kNBButtonWidth, kHeightCellNormal)
#define NBFrameTitle            CGRectMake((kScreenWidth - kNBTitleWidth) / 2, kHeightStatusBar, kNBTitleWidth, kHeightCellNormal)
#define NBFrameBottomLine       CGRectMake(0, kHeightNavigation - 0.5, kScreenWidth, 0.5)


@interface SimpleNavigationBar : UIView

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *rightButtonEx;
@property (nonatomic, strong) UIView *bottomLineView;

+ (SimpleNavigationBar *)createWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftText:(NSString *)leftText leftImage:(NSString *)leftImage rightText:(NSString *)rightText rightImage:(NSString *)rightImage target:(id)target action:(SEL)action;

//创建自定义话的nav,含有合规UI
+ (SimpleNavigationBar *)createCustomNavWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftText:(NSString *)leftText leftImage:(NSString *)leftImage rightText:(NSString *)rightText rightImage:(NSString *)rightImage target:(id)target action:(SEL)action;

//新增右前侧按钮
+ (SimpleNavigationBar *)createWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftText:(NSString *)leftText leftImage:(NSString *)leftImage rightText:(NSString *)rightText preRightText:(NSString *)preRightText preRightImage:(NSString *)preRightImage rightImage:(NSString *)rightImage target:(id)target action:(SEL)action;

- (void)addBottomLine:(CGRect)rt color:(UIColor *)color;
// 设置按钮frame
- (void)layoutRightCustomButton:(CGSize)size;

- (void)layoutLeftCustomButton:(CGSize)size;
@end
