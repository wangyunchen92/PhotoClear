//
//  BaseViewController.m
//  Fortune
//
//  Created by Sj03 on 2017/11/21.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end
@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initBaseData];
        [self initData];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorWeekWhite;
    [self loadBaseUIData];
    [self loadUIData];
}

- (void)viewDidUnload           // iOS 6 later, the viewDidUnload method is not used
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    MSLog(@" first didReceiveMemoryWarning VC: %@", self);
    
    
    if ([self isViewLoaded] && self.view.window == nil)
    {
        MSLog(@"didReceiveMemoryWarning VC: %@", self);
        [self receiveLowMemoryWarning];
        
        self.theSimpleNavigationBar = nil;
        
        //        [[[SDWebImageManager sharedManager] imageCache] clearDisk];
        //        [[[SDWebImageManager sharedManager] imageCache] clearMemory];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        self.view = nil;
    }
}


/**
 *当界面重用时,追加特殊的字符串区分不同用途
 * "_purchasePo"
 * "_purchaseDuocaibao"
 @return <#return value description#>
 */
- (NSString *)reSetStatisticSerial {
    return @"";
}

- (NSString *)getStatisticSerial {
    // TODO: 类名和友盟的key对应
    NSString *className = NSStringFromClass([self class]);
    NSString *statisticSerial = [self reSetStatisticSerial];
    return [className stringByAppendingString:statisticSerial];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    

    
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private's methods
- (void)initBaseData
{
    // 预留
}

- (void)loadBaseUIData
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.navigationController.navigationBar.titleTextAttributes];
    [dic setObject:kFontHWSmall forKey:NSFontAttributeName];
    [dic setObject:kColorHWBlack forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = [dic copy];
    self.view.backgroundColor = [UIColor whiteColor];
    if(kIOSVersions >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    //滑动手势
    self.canSwipeBackToParentVC = NO;
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToParentVC:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGesture];
}

#pragma mark - Public's methods
- (void)initData
{
    
}

- (void)loadUIData
{
    
}



- (void)receiveLowMemoryWarning
{
    
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //
    //    if (UIInterfaceOrientationIsLandscape(orientation)) {
    //        return UIInterfaceOrientationMaskLandscape;
    //    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - SimpleNavigationBar 创建方法

// 默认 返回箭头 + title
- (void)createNavWithTitle:(NSString *)title {
    [self createNavWithTitle:title leftImage:@"navBackBlack" rightImage:nil superView:nil];
}

// 大部分使用-1 左右图片
- (void)createNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage {
    [self createNavWithTitle:title leftImage:leftImage rightImage:rightImage superView:nil];
}

// 大部分使用-1 左右图片- 可选择父view
- (void)createNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage superView:(UIView *)superView {
    
    if (self.theSimpleNavigationBar == nil) {
        self.theSimpleNavigationBar = [SimpleNavigationBar createWithTitle:title titleImage:nil leftText:nil leftImage:leftImage rightText:nil rightImage:rightImage target:self action:@selector(navBarButtonAction:)];
        
        self.theSimpleNavigationBar.backgroundColor = [UIColor whiteColor];
        [(superView ? superView : self.view) addSubview:self.theSimpleNavigationBar];
        [self.theSimpleNavigationBar addBottomLine:NBFrameBottomLine color:kColorWeekWhite];
    }
}


- (void)createCustomNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage superView:(UIView *)superView {
    
    if (self.theSimpleNavigationBar == nil) {
        self.theSimpleNavigationBar = [SimpleNavigationBar createCustomNavWithTitle:title titleImage:nil leftText:nil leftImage:leftImage rightText:nil rightImage:nil target:self action:@selector(navBarButtonAction:)];
        
        self.theSimpleNavigationBar.backgroundColor = [UIColor whiteColor];
        [(superView ? superView : self.view) addSubview:self.theSimpleNavigationBar];
        [self.theSimpleNavigationBar addBottomLine:CGRectMake(0, kHeightCustomNavigation - 0.5, kScreenWidth, 0.5) color:kColorWeekWhite];
    }
}


// 大部分使用-2 左图片 右文字
- (void)createNavWithTitle:(NSString *)title leftImage:(NSString *)leftImage rightText:(NSString *)rightText {
    if (self.theSimpleNavigationBar == nil) {
        self.theSimpleNavigationBar = [SimpleNavigationBar createWithTitle:title titleImage:nil leftText:nil leftImage:leftImage rightText:rightText rightImage:nil target:self action:@selector(navBarButtonAction:)];
        
        self.theSimpleNavigationBar.backgroundColor = [UIColor whiteColor];
        self.theSimpleNavigationBar.rightButton.frame = NBFrameMainBtnText;
        [self.theSimpleNavigationBar.rightButton setTitleColor:kColorHWBlack forState:UIControlStateNormal];
        self.theSimpleNavigationBar.rightButton.titleLabel.font = kFontHWSmall;
        self.theSimpleNavigationBar.rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.theSimpleNavigationBar addBottomLine:NBFrameBottomLine color:kColorWeekWhite];
        
        [self.view addSubview:self.theSimpleNavigationBar];
    }
}

// 大部分使用-3 左右文字
- (void)createNavWithTitle:(NSString *)title leftText:(NSString *)leftText rightText:(NSString *)rightText {
    if (self.theSimpleNavigationBar == nil) {
        self.theSimpleNavigationBar = [SimpleNavigationBar createWithTitle:title titleImage:nil leftText:leftText leftImage:nil rightText:rightText rightImage:nil target:self action:@selector(navBarButtonAction:)];
        
        self.theSimpleNavigationBar.backgroundColor = [UIColor whiteColor];
        
        self.theSimpleNavigationBar.leftButton.frame = NBFrameMainBtnText;
        self.theSimpleNavigationBar.leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 50-18*2, 0, 0);
        //        CGRectMake(15.0f, 0, 50.0f, 44.0f);
        [self.theSimpleNavigationBar.leftButton setTitleColor:kColorHWBlack forState:UIControlStateNormal];
        self.theSimpleNavigationBar.leftButton.titleLabel.font = kFontHWSmall;
        self.theSimpleNavigationBar.leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.theSimpleNavigationBar.rightButton.frame = NBFrameMainBtnText;
        self.theSimpleNavigationBar.rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,50-18*2);
        [self.theSimpleNavigationBar.rightButton setTitleColor:kColorHWBlack forState:UIControlStateNormal];
        self.theSimpleNavigationBar.rightButton.titleLabel.font = kFontHWSmall;
        self.theSimpleNavigationBar.rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.theSimpleNavigationBar addBottomLine:NBFrameBottomLine color:kColorWeekWhite];
        
        [self.view addSubview:self.theSimpleNavigationBar];
    }
}

// 首页
- (void)createNavWithTitleImage:(NSString *)titleImage leftImage:(NSString *)leftImage rightImage:(NSString *)rightImage {
    
    if (self.theSimpleNavigationBar == nil) {
        self.theSimpleNavigationBar = [SimpleNavigationBar createWithTitle:nil titleImage:titleImage leftText:nil leftImage:leftImage rightText:nil rightImage:rightImage target:self action:@selector(navBarButtonAction:)];
        self.theSimpleNavigationBar.titleButton.frame = CGRectMake((kScreenWidth - 140) / 2, kHeightStatusBar + (kHeightCellNormal - 30) / 2, 140, 30);
        
        self.theSimpleNavigationBar.backgroundColor = [UIColor whiteColor];
        
        [self.theSimpleNavigationBar addBottomLine:NBFrameBottomLine color:kColorWeekWhite];
        
        [self.view addSubview:self.theSimpleNavigationBar];
    }
}

//首页+搜索
- (void)createNavWithTitleImage:(NSString *)titleImage leftImage:(NSString *)leftImage preRightImage:(NSString *)preRightImage rightImage:(NSString *)rightImage
{
    if (self.theSimpleNavigationBar == nil) {
        self.theSimpleNavigationBar = [SimpleNavigationBar createWithTitle:nil titleImage:titleImage leftText:nil leftImage:leftImage rightText:nil preRightText:nil preRightImage:preRightImage rightImage:rightImage target:self action:@selector(navBarButtonAction:)];
        
        self.theSimpleNavigationBar.titleButton.frame = CGRectMake((kScreenWidth - 140) / 2, kHeightStatusBar + (kHeightCellNormal - 30) / 2, 140, 30);
        
        self.theSimpleNavigationBar.backgroundColor = [UIColor whiteColor];
        
        [self.theSimpleNavigationBar addBottomLine:NBFrameBottomLine color:kColorWeekWhite];
        
        [self.view addSubview:self.theSimpleNavigationBar];
    }
}


#pragma mark - Actions Method
//右滑返回
- (void)backToParentVC:(UISwipeGestureRecognizer *)sender
{
    if(self.canSwipeBackToParentVC){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// navBar 回调
- (void)navBarButtonAction:(UIButton *)sender
{
    switch (sender.tag) {
        case NBButtonLeft:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case NBButtonRight:
        {
            NSLog(@"NBButtonRight");
        }
            break;
        case NBButtonRightEx:
        {
            NSLog(@"NBButtonRightEx");
        }
            break;
        case NBButtonTitle:
        {
            NSLog(@"NBButtonTitle");
        }
            break;
        case NBButtonCustom:
        {
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"NBButtonCustom");
        }
            break;
        default:
            break;
    }
    NAV_BACKBUTTON_DISABLE(sender);
}

@end

