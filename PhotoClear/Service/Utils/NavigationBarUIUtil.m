//
//  NavigationBarUIUtil.m
//  ZrtTool
//
//  Created by BillyWang on 15/10/23.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import "NavigationBarUIUtil.h"
//#import "SegmentButton.h"


#define kNBButtonWidth          50
#define kNBTitleWidth           160

#define NBFrameBG               CGRectMake(0, 0, kScreenWidth, kHeightNavigation)
#define NBFrameLeftBtnBG        CGRectMake(0, kHeightStatusBar, kNBButtonWidth, kHeightCellNormal)
#define NBFrameMainBtn          CGRectMake(18, 13, 18, 18)
//#define NBFrameLeftBtn          CGRectMake(4, 2, 0, 83)
#define NBFrameRightBtnBG       CGRectMake(kScreenWidth - kNBButtonWidth, kHeightStatusBar, kNBButtonWidth, kHeightCellNormal)
//#define NBFrameRightBtn         CGRectMake(4, 2, ScreenW - 8, 83)
#define NBFrameRightBtnExBG     CGRectMake(kScreenWidth - kNBButtonWidth * 2 + 15.0f, kHeightStatusBar, kNBButtonWidth, kHeightCellNormal)
//#define NBFrameRightBtnEx       CGRectMake(4, 2, ScreenW - 8, 83)
#define NBFrameTitle            CGRectMake((kScreenWidth - kNBTitleWidth) / 2, kHeightStatusBar, kNBTitleWidth, kHeightCellNormal)

@implementation NavigationBarUIUtil

+ (UIBarButtonItem *)createLeftBarButton:(NSString *)title target:(id)target selector:(SEL)selector imageName:(NSString *)imageName showArrow:(BOOL)showArrow
{
    UIImage *image = [UIImage imageNamed:(showArrow ? imageName : @"")];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];

    if ([title length] > 0) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    CGSize titleSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName, nil]];
    
    if (titleSize.width < 44) {
        titleSize.width = 44;
    }
    button.frame = CGRectMake(0, 0, titleSize.width, 44);
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor colorWithRed:130.0/255 green:56.0/255 blue:23.0/255 alpha:1] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    // iOS7之前的版本需要手动设置和屏幕边缘的间距
    if (kIOSVersions < 7.0) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (UIBarButtonItem *)createRightBarButton:(NSString *)title target:(id)obj selector:(SEL)selector imageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    //iOS7之前的版本需要手动设置和屏幕边缘的间距
    if (kIOSVersions < 7.0) {
        button.frame = CGRectInset(button.frame, -10, 0);
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

//+ (UIBarButtonItem *)createRightBarButtonForHomeWithTarget:(id)target selector:(SEL)selector
//{
//    UIBarButtonItem *item = [[self class] loadNavBarItem:nil
//                                           itemNameArray:[NSArray arrayWithObjects:IMAGE_NAME(@"会议邀请"),
//                                                          IMAGE_NAME(@"创建直播"),
//                                                          nil]
//                                            itemTagArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:1], nil]
//                                              rtItemSize:CGSizeMake(36, 36)
//                                                  target:target
//                                                selector:selector
//                                 itemNameHightlightArray:[NSArray arrayWithObjects:IMAGE_NAME(@"会议邀请"),
//                                                          IMAGE_NAME(@"创建直播"),
//                                                          nil]];
//    return item;
//}


//+ (UIBarButtonItem *)loadNavBarItem:(NSArray *)backImagNameArray itemNameArray:(NSArray *)itemNameArray itemTagArray:(NSArray *)itemTagArray rtItemSize:(CGSize)rtItemSize target:(id)target selector:(SEL)selector itemNameHightlightArray:(NSArray *)itemNameHightlightArray
//{
//    UIBarButtonItem *barBtnItem = nil;
//    if (itemTagArray && [itemTagArray count] > 0)
//    {
//        SegmentButton *segBtns = [[SegmentButton alloc] initWithFrame:CGRectMake(0, 0, rtItemSize.width * [itemNameArray count], rtItemSize.height)];
//        
//        [segBtns setSegmentWithBackImages:backImagNameArray
//                             buttonImages:itemNameArray
//                                    bgClr:[UIColor clearColor]
//                                borderClr:[UIColor clearColor]
//                                   target:target
//                                selAction:selector
//                   buttonHightlightImages:itemNameHightlightArray];
//        
//        barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:segBtns];
//    }
//    return barBtnItem;
//    
//}


#pragma mark - 创建导航栏背景
+ (UIView *)createNavBG
{
    CGRect rt = CGRectMake(0, 0, kScreenWidth, kHeightNavigation);
    UIView *view = [UIUtil createView:rt bgColor:[UIColor clearColor]];
    
    return view;
}

#pragma mark - 创建标题

+ (UILabel *)createNavTitle:(CGRect)rt title:(NSString *)title
{
    UILabel *lab = [UIUtil createLabel:rt text:title font:kFontHWSmall bgColor:[UIColor clearColor] textColor:kColorTitleBlack textAlignment:NSTextAlignmentCenter];
    return lab;
}

#pragma mark - 创建左侧按钮
+ (UIView *)createNavLeftButton:(NSString *)text imageName:(NSString *)imageName
{
    CGRect rtBtn = CGRectMake(0, 0, kScreenWidth, kHeightNavigation);
    CGRect rtBgBtn = CGRectMake(0, 0, kScreenWidth, kHeightNavigation);
    
    UIButton *btn = [UIUtil createButton:rtBtn title:text titleColor:kColorHWBlack bgImage:IMAGE_NAME(imageName) target:nil action:nil];
    UIButton *bgBtn = [UIUtil createButton:rtBgBtn title:text titleColor:kColorHWBlack bgImage:nil target:self action:nil];
    bgBtn.tag = NBButtonLeft;
    [bgBtn addSubview:btn];
    
    return bgBtn;
}

#pragma mark - 创建右侧按钮
+ (UIView *)createNavRightButton:(NSString *)text imageName:(NSString *)imageName
{
    CGRect rtBtn = CGRectMake(0, 0, kScreenWidth, kHeightNavigation);
    CGRect rtBgBtn = CGRectMake(0, 0, kScreenWidth, kHeightNavigation);
    
    UIButton *btn = [UIUtil createButton:rtBtn title:text titleColor:kColorHWBlack bgImage:imageName?IMAGE_NAME(imageName):nil target:nil action:nil];
    UIButton *bgBtn = [UIUtil createButton:rtBgBtn title:text titleColor:kColorHWBlack bgImage:imageName?IMAGE_NAME(imageName):nil target:self action:nil];
    [bgBtn addSubview:btn];
    
    return bgBtn;
}

#pragma mark - 创建NB按钮
+ (UIView *)createNavButton:(CGRect)rt text:(NSString *)text imageName:(NSString *)imageName tag:(NBButton)tag target:(id)target action:(SEL)action
{
    // 只做展示
    UIButton *btn = [UIUtil createButton:NBFrameMainBtn title:text titleColor:kColorHWBlack bgImage:imageName?IMAGE_NAME(imageName):nil target:nil action:nil];
//    btn.backgroundColor = [UIColor orangeColor];
    btn.userInteractionEnabled = NO;
    
    // 事件监听
    UIButton *bgBtn = [UIUtil createButton:rt title:text titleColor:kColorHWBlack bgImage:nil target:target action:action];
    bgBtn.tag = tag;
    [bgBtn addSubview:btn];
    
//    bgBtn.backgroundColor = [UIColor blueColor];
    return bgBtn;
}

#pragma mark - 创建导航栏

+ (UIView *)createNavBar:(NSString *)title
                leftText:(NSString *)leftText
               leftImage:(NSString *)leftImage
               rightText:(NSString *)rightText
              rightImage:(NSString *)rightImage
             rightTextEx:(NSString *)rightTextEx
            rightImageEx:(NSString *)rightImageEx
                  target:(id)target
                  action:(SEL)action
{
    UIView *view = [NBUtil createNavBG];
    
    if (title)     
    
    if (leftText || leftImage) {
        [view addSubview:[NBUtil createNavButton:NBFrameLeftBtnBG text:leftText imageName:leftImage tag:NBButtonLeft target:target action:action]];
    }
    
    if (rightText || rightImage) {
        [view addSubview:[NBUtil createNavButton:NBFrameRightBtnBG text:rightText imageName:rightImage tag:NBButtonRight target:target action:action]];
    }
    
    if (rightTextEx || rightImageEx) {
        [view addSubview:[NBUtil createNavButton:NBFrameRightBtnExBG text:rightTextEx imageName:rightImageEx tag:NBButtonRightEx target:target action:action]];
    }

    return view;
}


// 基类使用 大部分是这种
+ (UIView *)createNavBar:(NSString *)title
               leftImage:(NSString *)leftImage
              rightImage:(NSString *)rightImage
                  target:(id)target
                  action:(SEL)action
{
    return [NBUtil createNavBar:title leftText:nil leftImage:leftImage rightText:nil rightImage:rightImage rightTextEx:nil rightImageEx:nil target:target action:action];
}

+ (UIView *)createNavBar:(NSString *)title
               leftButtonText:(NSString *)leftButtonText
              rightButtonText:(NSString *)rightButtonText
            rightButtonTextEx:(NSString *)rightButtonTextEx
                        target:(id)target
                        action:(SEL)action
{
    return [NBUtil createNavBar:title leftText:leftButtonText leftImage:nil rightText:rightButtonText rightImage:nil rightTextEx:rightButtonTextEx rightImageEx:nil target:target action:action];
}

//+ (UIView *)createNavBar:(NSString *)title
//               leftImage:(NSString *)leftImage
//              rightImage:(NSString *)rightImage
//                  target:(id)target
//                  action:(SEL)action
//{
//    return [NBUtil createNavBar:title leftText:nil leftImage:leftImage rightText:nil rightImage:rightImage rightTextEx:nil rightImageEx:nil target:target action:action];
//}


//createNavBar:@"全部" leftButtonText:@"左侧" rightButtonText:@"右侧" rightButtonTextEx:@"右侧ex" target:self action:@selector(navBarButtonAction:)]];


@end
