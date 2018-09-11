//
//  DSViewController.m
//  daikuanchaoshi
//
//  Created by Sj03 on 2017/12/7.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import "DSNavViewController.h"

@interface DSNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DSNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
    // 一定要禁止系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}

//重写跳转方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  不是第一个push进来的子控制器)
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
}


- (void)back{
    
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
