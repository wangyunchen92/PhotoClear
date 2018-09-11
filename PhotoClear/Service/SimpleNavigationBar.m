//
//  SimpleNavigationBar.m
//  Midas
//
//  Created by BillyWang on 15/12/11.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import "SimpleNavigationBar.h"

@interface SimpleNavigationBar ()

//@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;
@property (nonatomic, copy) NSString *rightTextEx;

@property (nonatomic, copy) NSString *titleImage;
@property (nonatomic, copy) NSString *leftImage;
@property (nonatomic, copy) NSString *rightImage;
@property (nonatomic, copy) NSString *rightImageEx;

@property (nonatomic, weak) id    target;
@property (nonatomic) SEL   action;

@end

@implementation SimpleNavigationBar

- (void)reloadAllView{
    // 背景View，在self 上面
    [self createNavBG];

    // 标题
    [self createNavTitle];
    
    // 先创建展示按钮，在创建背景按钮，  展示按钮 加在背景按钮上
    // 左侧按钮
    self.leftButton = [self createKeyButton:NBFrameMainBtnLeft text:_leftText imageName:_leftImage];
    [self createNavButton:NBFrameLeftBtnBG tag:NBButtonLeft sonButton:self.leftButton];
    
    // 右侧按钮
    self.rightButton = [self createKeyButton:NBFrameMainBtn text:_rightText imageName:_rightImage];
    [self createNavButton:NBFrameRightBtnBG tag:NBButtonRight sonButton:self.rightButton];
    
    // 右侧ex按钮
    self.rightButtonEx = [self createKeyButton:NBFrameMainBtn text:_rightTextEx imageName:_rightImageEx];
    [self createNavButton:NBFrameRightBtnExBG tag:NBButtonRightEx sonButton:self.rightButtonEx];

}
- (void)reloadCustomView
{
    // 背景View，在self 上面
    [self createNavBG];
    
    //自定义View
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth,kHeightNavigationCustomView)];
    customView.backgroundColor = UIColorFromRGB(0xff681f);
    [self addSubview:customView];
    
    UIImage *image = [UIImage imageNamed:@"锁"];
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    NSString *content = @"   您正在通过 盈米财富 进行基金安全交易";
    [attachText appendAttributedString:[[NSAttributedString alloc] initWithString:content]];
    attachText.yy_font = font;
    attachText.yy_color = [UIColor whiteColor];
    YYLabel *label = [YYLabel new];
    label.attributedText = attachText;
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    [customView addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kHeightNavigationCustomView));
        make.centerX.equalTo(customView.mas_centerX);
        make.centerY.equalTo(customView.mas_centerY);
    }];
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.tag = NBButtonCustom;
    [customBtn setTitle:@"退出" forState:UIControlStateNormal];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [customBtn addTarget:_target action:_action forControlEvents:UIControlEventTouchUpInside];
    customBtn.layer.borderWidth = 0.8f;
    customBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [customView addSubview:customBtn];
    [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(customView).offset(-5);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
        make.centerY.equalTo(customView.mas_centerY);
    }];
    
    // 标题
    self.titleButton = [UIUtil createButton:CGRectMake((kScreenWidth - kNBTitleWidth) / 2, kHeightStatusBar+kHeightNavigationCustomView, kNBTitleWidth, kHeightCellNormal) title:self.title titleColor:kColorTitleBlack bgImage:self.titleImage? IMAGE_NAME(self.titleImage):nil target:nil action:nil];
    //    self.titleButton.backgroundColor = [UIColor blueColor];
    self.titleButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    self.titleButton.userInteractionEnabled = NO;
    [self addSubview:self.titleButton];
    
    // 先创建展示按钮，在创建背景按钮，  展示按钮 加在背景按钮上
    // 左侧按钮
    self.leftButton = [self createKeyButton:NBFrameMainBtnLeft text:_leftText imageName:_leftImage];
    [self createNavButton:CGRectMake(0, kHeightStatusBar+kHeightNavigationCustomView, kNBButtonWidth, kHeightCellNormal) tag:NBButtonLeft sonButton:self.leftButton];
    
    // 右侧按钮
    self.rightButton = [self createKeyButton:NBFrameMainBtn text:_rightText imageName:_rightImage];
    [self createNavButton:CGRectMake(kScreenWidth - kNBButtonWidth, kHeightStatusBar+kHeightNavigationCustomView, kNBButtonWidth, kHeightCellNormal) tag:NBButtonRight sonButton:self.rightButton];
    
    // 右侧ex按钮
    self.rightButtonEx = [self createKeyButton:NBFrameMainBtn text:_rightTextEx imageName:_rightImageEx];
    [self createNavButton:NBFrameRightBtnExBG tag:NBButtonRightEx sonButton:self.rightButtonEx];
}

+ (SimpleNavigationBar *)createWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftText:(NSString *)leftText leftImage:(NSString *)leftImage rightText:(NSString *)rightText rightImage:(NSString *)rightImage target:(id)target action:(SEL)action {
    SimpleNavigationBar *nb = [[SimpleNavigationBar alloc] initWithFrame:NBFrameBG];
   
    nb.title = title;
    nb.titleImage = titleImage;
    
    nb.leftText = leftText;
    nb.leftImage = leftImage;

    nb.rightText = rightText;
    nb.rightImage = rightImage;
    
    nb.target = target;
    nb.action = action;
    
    [nb reloadAllView];
    
    return nb;
}

+ (SimpleNavigationBar *)createCustomNavWithTitle:(NSString *)title
                                       titleImage:(NSString *)titleImage
                                         leftText:(NSString *)leftText
                                        leftImage:(NSString *)leftImage
                                        rightText:(NSString *)rightText
                                       rightImage:(NSString *)rightImage
                                           target:(id)target
                                           action:(SEL)action
{
    SimpleNavigationBar *nb = [[SimpleNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeightCustomNavigation)];
    
    nb.title = title;
    nb.titleImage = titleImage;
    
    nb.leftText = leftText;
    nb.leftImage = leftImage;
    
    nb.rightText = rightText;
    nb.rightImage = rightImage;
    
    nb.target = target;
    nb.action = action;
    
    [nb reloadCustomView];
    
    return nb;
}


+ (SimpleNavigationBar *)createWithTitle:(NSString *)title titleImage:(NSString *)titleImage leftText:(NSString *)leftText leftImage:(NSString *)leftImage rightText:(NSString *)rightText preRightText:(NSString *)preRightText preRightImage:(NSString *)preRightImage rightImage:(NSString *)rightImage target:(id)target action:(SEL)action {
    
    SimpleNavigationBar *nb = [[SimpleNavigationBar alloc] initWithFrame:NBFrameBG];
    nb.title = title;
    nb.titleImage = titleImage;
    
    nb.leftText = leftText;
    nb.leftImage = leftImage;
    
    //右侧前置按钮
    nb.rightText = preRightText;
    nb.rightImageEx = preRightImage;
    
    nb.rightText = rightText;
    nb.rightImage = rightImage;
    
    nb.target = target;
    nb.action = action;
    
    [nb reloadAllView];
    return nb;
}


#pragma mark - 创建导航栏背景
- (void)createNavBG
{
}

#pragma mark - 创建标题
- (void)createNavTitle
{
    self.titleButton = [UIUtil createButton:NBFrameTitle title:self.title titleColor:kColorTitleBlack bgImage:self.titleImage? IMAGE_NAME(self.titleImage):nil target:nil action:nil];
//    self.titleButton.backgroundColor = [UIColor blueColor];
    self.titleButton.titleLabel.font = kFontHWSmall;
    self.titleButton.userInteractionEnabled = NO;
    [self addSubview:self.titleButton];
}

- (UIButton *)createKeyButton:(CGRect)rt text:(NSString *)text imageName:(NSString *)imageName {

    // 只做展示
    UIButton *btn = [UIUtil createButton:rt title:text titleColor:kColorHWBlack bgImage:imageName?IMAGE_NAME(imageName):nil target:nil action:nil];
    btn.userInteractionEnabled = NO;
    return btn;
}

#pragma mark - 创建NB按钮
- (void)createNavButton:(CGRect)rt tag:(NBButton)tag sonButton:(UIButton *)sonButton {
    
    // 事件监听
    UIButton *bgBtn = [UIUtil createButton:rt title:nil titleColor:kColorHWBlack bgImage:nil target:_target action:_action];
    bgBtn.tag = tag;
    [bgBtn addSubview:sonButton];

    [self addSubview:bgBtn];
}

- (void)addBottomLine:(CGRect)rt color:(UIColor *)color {

    self.bottomLineView = [UIUtil createView:rt bgColor:color];
    [self addSubview:self.bottomLineView];
}

- (void)layoutRightCustomButton:(CGSize)size
{
    if (self.rightButton) {
        self.rightButton.size = CGSizeMake(size.width, size.height);
    }
}

- (void)layoutLeftCustomButton:(CGSize)size
{
    if (self.leftButton) {
        self.leftButton.size = CGSizeMake(size.width, size.height);
    }
}
@end
