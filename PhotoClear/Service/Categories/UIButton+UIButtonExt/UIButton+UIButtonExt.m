//
//  UIButton+UIButtonExt.m
//  ColorfulFund
//
//  Created by Madis on 2016/11/1.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "UIButton+UIButtonExt.h"

@implementation UIButton (UIButtonExt)

- (void)setImageAndTitleLeft:(float)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    self.imageEdgeInsets = UIEdgeInsetsMake( - (totalHeight - imageSize.height)-15.0f, 0.0, 0.0, - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake( 0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
}

- (void)setImageAndTitleLeft{
    const int SPACING = 3.0f;
    [self setImageAndTitleLeft:SPACING];
}

-(void)setImageTopAndTitleBottom{
//    [self setTitleColor:[UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0] forState:UIControlStateNormal];
//    self.titleLabel.font = [UIFont systemFontOfSize:11.0];
    CGFloat totalHeight = (self.imageView.frame.size.height + self.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [self setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - self.imageView.frame.size.height),  self.titleLabel.frame.size.width*0.5, 0.0, -self.titleLabel.frame.size.width*0.5)];
    // 设置按钮标题偏移
    [self setTitleEdgeInsets:UIEdgeInsetsMake(8, -self.imageView.frame.size.width, -(totalHeight - self.titleLabel.frame.size.height),0.0)];
}
@end
