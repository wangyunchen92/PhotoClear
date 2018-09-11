//
//  ClearGifViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/20.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ClearGifViewController.h"
#import "ClearDetailViewController.h"

@interface ClearGifViewController ()

@end

@implementation ClearGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNavWithTitle:@"手机清理" leftImage:@"" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
}

- (void)initData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ClearDetailViewController *cVC = [[ClearDetailViewController alloc] init];
        [self.navigationController pushViewController:cVC animated:YES];
    });
}

- (void)loadUIData {
    UIImageView *imageViwe = [[UIImageView alloc] initWithImage:IMAGE_NAME(@"优化")];
    [self.view addSubview:imageViwe];
    [imageViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(178);
        make.height.mas_equalTo(178);
    }];
    CABasicAnimation *rotanimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotanimation.toValue = @(2*M_PI);
//     rotanimation.removedOnCompletion = false;
    rotanimation.duration = 1;
    rotanimation.cumulative = YES;
    rotanimation.repeatCount = MAXFLOAT;
    
    [imageViwe.layer addAnimation:rotanimation forKey:nil];//开始动画
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif手机优化" ofType:@"gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    UIWebView *webView = [[UIWebView alloc] init];
//
//    webView.scalesPageToFit = YES;
//    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    webView.backgroundColor = [UIColor clearColor];
//    webView.opaque = NO;
//    [self.view addSubview:webView];
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.width.mas_equalTo(178);
//        make.height.mas_equalTo(178);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
