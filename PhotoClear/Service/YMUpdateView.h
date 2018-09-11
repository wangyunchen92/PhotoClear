//
//  YMUpdateView.h
//  Daiba
//
//  Created by YouMeng on 2017/9/18.
//  Copyright © 2017年 YouMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMUpdateView : UIView

typedef void(^AlertResult)(NSInteger index);
@property (nonatomic,copy) AlertResult resultIndex;


//创建alertView
- (instancetype)initWithTitle:(NSString *)title imgStr:(NSString* )imgStr message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showXLAlertView;


@end
