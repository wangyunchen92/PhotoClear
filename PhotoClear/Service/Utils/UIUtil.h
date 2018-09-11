//
//  UIUtil.h
//  ZrtTool
//
//  Created by BillyWang on 15/10/15.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtil : NSObject

/**
 * 创建导航栏按钮
 * @returns 导航栏按钮
 */
+ (UIBarButtonItem *)createNavCustomButtonWithTarget:(id)target
                                              action:(SEL)action
                                                size:(CGSize)size
                                               title:(NSString *)title
                                                  bg:(UIImage *)image;

// 创建View
+ (UIView *)createView:(CGRect)rect
               bgColor:(UIColor *)bgColor;

// 创建ImageView
+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image;

/*!
 *  @author zrt, 16-02-29 10:02:48
 *
 *  设置图片圆角(性能更优化)
 *
 *  @param rect   imageView大小
 *  @param image  image图片
 *  @param radius imageView圆角
 *
 *  @return iamgeView
 */
//???: 更换imageView的图片后,圆角的设置失效
+ (UIImageView *)createImageView:(CGRect)rect
                           image:(UIImage *)image
                    cornerRadius:(CGFloat)radius;

// 创建UILabel, textAlignment == NSTextAlignmentLeft
+ (UILabel *)createLabel:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
                 bgColor:(UIColor *)bgColor
               textColor:(UIColor *)textColor;

// 创建UILabel
+ (UILabel *)createLabel:(CGRect)rect
                    text:(NSString *)text
                    font:(UIFont *)font
                 bgColor:(UIColor *)bgColor
               textColor:(UIColor *)textColor
           textAlignment:(NSTextAlignment)textAlignment;


// 创建UITextField
+ (UITextField *)createTextField:(CGRect)rect
                            text:(NSString *)text
                     placeholder:(NSString *)placeholder
                            font:(UIFont *)font
                         bgColor:(UIColor *)bgColor
                       textColor:(UIColor *)textColor
                        delegate:(id)delegate;

// 创建UITextView
+ (UITextView *)createTextView:(CGRect)rect
                          text:(NSString *)text
                          font:(UIFont *)font
                       bgColor:(UIColor *)bgColor
                     textColor:(UIColor *)textColor
                 textAlignment:(NSTextAlignment)textAlignment;


// 创建按钮 无tag
+ (UIButton *)createButton:(CGRect)rect
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                   bgImage:(UIImage *)bgImage
                    target:(id)target
                    action:(SEL)action;
// 创建按钮
+ (UIButton *)createButton:(CGRect)rect
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                   bgImage:(UIImage *)bgImage
                    target:(id)target
                    action:(SEL)action
                       tag:(NSInteger)tag;

// 创建TableView
+ (UITableView *)createTableView:(CGRect)rect rowHeight:(CGFloat)rowHeight separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource style:(UITableViewStyle)style;

// 创建CollectionView
+ (UICollectionView *)createCollectionView:(CGRect)rect delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource collectionViewFlowLayout:(UICollectionViewFlowLayout *)layout;


// 创建UISwitch控件
+ (UISwitch *)createSwitch:(CGRect)rect
                        on:(BOOL)on
                    target:(id)target
                    action:(SEL)action;

//当图片大于某值时,压缩图片
+(UIImage*)compressedImageToLimitSizeOfKB:(CGFloat)kb
                                    image:(UIImage*)image;


//当图片大于某值时,压缩图片
+(NSData*)returnDataCompressedImageToLimitSizeOfKB:(CGFloat)kb
                                             image:(UIImage*)image;

+ (void)showTabBarFromChildViewController:(UIViewController *)childVC;

+(UIAlertController *)alertTitle:(NSString *)title
                         mesasge:(NSString *)message
                    confirmTitle:(NSString *)confirmTitle
                     cancelTitle:(NSString *)cancelTitle
                  confirmHandler:(void(^)(UIAlertAction *confirmAction))confirmHandler
                   cancelHandler:(void(^)(UIAlertAction *cancelAction))cancelHandler
                  viewController:(UIViewController *)vc;

//设置layer
+ (void)viewLayerWithView:(UIView* )view  cornerRadius:(CGFloat)cornerRadius boredColor:(UIColor* )boredColor borderWidth:(CGFloat)borderWidth;

// 绘制虚线
+ (void)addline:(UIView *)view;


// 添加阴影
+ (void)addshadows:(UIView *)view;
@end
