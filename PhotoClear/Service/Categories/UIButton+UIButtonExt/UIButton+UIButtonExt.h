//
//  UIButton+UIButtonExt.h
//  ColorfulFund
//
//  Created by Madis on 2016/11/1.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonExt)
//imageView在上,label在下
- (void)setImageAndTitleLeft:(float)space;
- (void)setImageAndTitleLeft;
-(void)setImageTopAndTitleBottom;

@end
