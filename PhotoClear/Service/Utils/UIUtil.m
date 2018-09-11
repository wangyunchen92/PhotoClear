//
//  UIUtil.m
//  ZrtTool
//
//  Created by BillyWang on 15/10/15.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import "UIUtil.h"

@implementation UIUtil

+ (UIBarButtonItem *)createNavCustomButtonWithTarget:(id)target
                                              action:(SEL)action
                                                size:(CGSize)size
                                               title:(NSString *)title
                                                  bg:(UIImage *)image
{
    UIFont * font = [UIFont systemFontOfSize:14.];
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame=CGRectMake(.0, .0, size.width, size.height);
    [customButton setBackgroundImage:image forState:UIControlStateNormal];
    [customButton setContentEdgeInsets:UIEdgeInsetsMake(.0, 5., .0, .0)];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customButton.titleLabel.font=font;
    return [[UIBarButtonItem alloc] initWithCustomView:customButton];
}

// 创建View
+ (UIView *)createView:(CGRect)rect
               bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = bgColor;
    
    return view;
}

// 创建ImageView
+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    
    imageView.image = image;   // image属性默认是nil

    return imageView;
}

// 创建ImageView,设置圆角
+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
                    cornerRadius:(CGFloat)radius
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    
    CGRect cornerRadiusRect = (CGRect){0.f, 0.f, rect.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:cornerRadiusRect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [image drawInRect:cornerRadiusRect];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image = outputImage;   // image属性默认是nil
    
    return imageView;
}

// 创建UILabel, textAlignment == NSTextAlignmentLeft
+ (UILabel *)createLabel:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
                 bgColor:(UIColor *)bgColor
               textColor:(UIColor *)textColor
{
    return [[self class] createLabel:rect text:text font:font bgColor:bgColor textColor:textColor textAlignment:NSTextAlignmentLeft];
}

// 创建UILabel
+ (UILabel *)createLabel:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
                 bgColor:(UIColor *)bgColor
               textColor:(UIColor *)textColor
           textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.font = font;
    label.backgroundColor = bgColor ? bgColor : [UIColor clearColor];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}

// 创建UITextField
+ (UITextField *)createTextField:(CGRect)rect
                            text:(NSString *)text
                     placeholder:(NSString *)placeholder
                            font:(UIFont *)font
                         bgColor:(UIColor *)bgColor
                       textColor:(UIColor *)textColor
                        delegate:(id)delegate
{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];

    textField.text = text;
    textField.placeholder = placeholder;
    textField.font = font;
    textField.backgroundColor = bgColor;
    textField.textColor = textColor;
//    textField.textAlignment = NSTextAlignmentLeft;
    textField.delegate = delegate;
    
    return textField;
}

// 创建UITextView
+ (UITextView *)createTextView:(CGRect)rect
                          text:(NSString *)text
                          font:(UIFont *)font
                       bgColor:(UIColor *)bgColor
                     textColor:(UIColor *)textColor
                 textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.text = text;
    textView.font = font;
    textView.backgroundColor = bgColor ? bgColor : [UIColor clearColor];
    textView.textColor = textColor;
    textView.textAlignment = textAlignment;
    
    return textView;
}

// 创建按钮 无tag
+ (UIButton *)createButton:(CGRect)rect
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                   bgImage:(UIImage *)bgImage
                    target:(id)target
                    action:(SEL)action
{
    return [[self class] createButton:rect title:title titleColor:titleColor bgImage:bgImage target:target action:action tag:0];
}

// 创建按钮
+ (UIButton *)createButton:(CGRect)rect
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                   bgImage:(UIImage *)bgImage
                    target:(id)target
                    action:(SEL)action
                       tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = rect;
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    return button;
}


// 创建TableView
+ (UITableView *)createTableView:(CGRect)rect rowHeight:(CGFloat)rowHeight separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource style:(UITableViewStyle)style
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:style];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.rowHeight = rowHeight;
    tableView.separatorStyle = separatorStyle;
    
    return tableView;
}

// 创建CollectionView
+ (UICollectionView *)createCollectionView:(CGRect)rect delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource collectionViewFlowLayout:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView  = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    collectionView.delegate = delegate;
    collectionView.dataSource = dataSource;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    return collectionView;
}

// 创建UISwitch控件
+ (UISwitch *)createSwitch:(CGRect)rect
                        on:(BOOL)on
                    target:(id)target
                    action:(SEL)action
{
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:rect];
    [switchButton setOn:on];
    [switchButton addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    return switchButton;
}

+(UIImage*)compressedImageToLimitSizeOfKB:(CGFloat)kb
                                    image:(UIImage*)image
{
    //大于多少kb的图片需要压缩
//    long imagePixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    long imageKB = UIImageJPEGRepresentation(image,1.0f).length/1024.0f;
//    imagePixel * CGImageGetBitsPerPixel(image.CGImage) / (8 * 1024);
    if (imageKB > kb){
        float compressedParam = kb / imageKB;
        return [UIImage imageWithData:UIImageJPEGRepresentation(image, compressedParam)];
    }
    //返回原图
    else{
        return image;
    }
}

+(NSData*)returnDataCompressedImageToLimitSizeOfKB:(CGFloat)kb
                                             image:(UIImage*)image
{
    //大于多少kb的图片需要压缩
    long imagePixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    long imageKB = imagePixel * CGImageGetBitsPerPixel(image.CGImage) / (8 * 1024);
    if (imageKB > kb){
        float compressedParam = kb / imageKB;
        return UIImageJPEGRepresentation(image, compressedParam);
    }
    //返回原图
    else{
        return UIImageJPEGRepresentation(image, 1);
    }
}

+ (void)showTabBarFromChildViewController:(UIViewController *)childVC
{
    UIViewController *vc = childVC.parentViewController;
    if (vc.tabBarController.tabBar.hidden == NO){
        return;
    }
    UIView *contentView;
    if ([[vc.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        contentView = [vc.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [vc.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - vc.tabBarController.tabBar.frame.size.height);
    vc.tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight - 49.0f, kScreenWidth, 49.0f);
    vc.tabBarController.tabBar.hidden = NO;
}

+(UIAlertController *)alertTitle:(NSString *)title
                         mesasge:(NSString *)message
                    confirmTitle:(NSString *)confirmTitle
                     cancelTitle:(NSString *)cancelTitle
                  confirmHandler:(void(^)(UIAlertAction *confirmAction))confirmHandler
                   cancelHandler:(void(^)(UIAlertAction *cancelAction))cancelHandler
                  viewController:(UIViewController *)vc
{
    if(!message || !confirmHandler){
        return nil;
    }
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title ?title:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:confirmTitle ?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmHandler];
    
    if(cancelTitle){
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:cancelAction];
    }
    
    [alertController addAction:confirmAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

//设置layer
+ (void)viewLayerWithView:(UIView* )view  cornerRadius:(CGFloat)cornerRadius boredColor:(UIColor* )boredColor borderWidth:(CGFloat)borderWidth{
    
    if (boredColor == nil) {
        boredColor = [UIColor clearColor];
    }
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderColor = boredColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.clipsToBounds = cornerRadius;
    
}

+ (void)addline:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = RGB(198, 187, 172).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, view.frame.size.height)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, view.frame.size.height)];
    [path addLineToPoint:CGPointMake(view.frame.size.width, 0)];
    //设置路径
    border.path = path.CGPath;
    
    border.frame = view.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    //    view.layer.masksToBounds = YES;
    
    [view.layer addSublayer:border];
}

+ (void)addshadows:(UIView *)view {
    CALayer *sublayer =[CALayer layer];
    //    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowRadius = 4.0;
    view.layer.shadowColor =RGB(54, 133, 246).CGColor;
    view.layer.shadowOffset = CGSizeMake(-3, 3);
    view.layer.shadowOpacity = 0.4;
    view.layer.cornerRadius = 4.0;
    [view.layer addSublayer:sublayer];
    
    CALayer *imageLayer =[CALayer layer];
    imageLayer.frame = sublayer.bounds;
    imageLayer.cornerRadius = 4.0;
    imageLayer.masksToBounds = YES;
    [view.layer addSublayer:imageLayer];
}


@end
