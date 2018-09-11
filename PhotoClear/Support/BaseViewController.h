//
//  BaseViewController.h
//  Fortune
//
//  Created by Sj03 on 2017/11/21.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SimpleNavigationBar.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong) SimpleNavigationBar *theSimpleNavigationBar;
@property (nonatomic,assign) BOOL canSwipeBackToParentVC;

#pragma mark - 工程中的ViewController 须重写下面方法
/**************************************************************************
 FunctionName:  initData
 FunctionDesc:  扩展的初始化数据(子类继承时,子类初始化数据处理可在此函数中进行数据初始化)
 Parameters:    NONE
 ReturnVal:     NONE
 **************************************************************************/
- (void)initData;

/**************************************************************************
 FunctionName:  loadUIData
 FunctionDesc:  界面加载(子类继承时,子类扩展界面加载可在此函数中进行)
 Parameters:    NONE
 ReturnVal:     NONE
 **************************************************************************/
- (void)loadUIData;

/**************************************************************************
 FunctionName:  receiveLowMemoryWarning
 FunctionDesc:  内存告警调用
 Parameters:    NONE
 ReturnVal:     NONE
 **************************************************************************/
- (void)receiveLowMemoryWarning;

#pragma mark - SimpleNavigationBar 创建方法
// 默认 返回箭头的
- (void)createNavWithTitle:(NSString *)title;
// 大部分使用-1 左右图片
- (void)createNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage;
// 大部分使用-1 左右图片- 可选择父view
- (void)createNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage superView:(UIView *)superView;
//创建自定义nav,含有合规UI
- (void)createCustomNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage superView:(UIView *)superView;
// 大部分使用-2 左图片 右文字
- (void)createNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightText:(NSString *)rightText;
// 大部分使用-3 左右文字
- (void)createNavWithTitle:(NSString *)title leftText:(NSString *)leftText rightText:(NSString *)rightText;

// 首页
- (void)createNavWithTitleImage:(NSString *)titleImage leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage;

////首页+搜索
- (void)createNavWithTitleImage:(NSString *)titleImage leftImage:(NSString *)leftImage preRightImage:(NSString *)preRightImage rightImage:(NSString *)rightImage;


#pragma mark - Actions Method

// navBar 回调
- (void)navBarButtonAction:(UIButton *)sender;
@end
