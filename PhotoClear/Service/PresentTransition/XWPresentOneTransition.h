//
//  XWPresentOneTransition.h
//  persentViewDemo
//
//  Created by Sj03 on 2017/11/2.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XWPresentOneTransitionType) {
    XWPresentOneTransitionTypePresent = 0,//管理present动画
    XWPresentOneTransitionTypeDismiss//管理dismiss动画
};

@interface XWPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>
//根据定义的枚举初始化的两个方法
@property (assign, nonatomic)XWPresentOneTransitionType type;
+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type;

@end
