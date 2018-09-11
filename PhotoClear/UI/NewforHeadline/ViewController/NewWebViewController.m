//
//  NewWebViewController.m
//  Constellation
//
//  Created by Sj03 on 2018/3/27.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NewWebViewController.h"
#import "YMWebProgressLayer.h"

@interface NewWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)YMWebProgressLayer *progressLayer; ///< 网页加载进度条

@end

@implementation NewWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavWithTitle:@"" leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    self.webView.backgroundColor = [UIColor clearColor];

    self.webView.delegate = self;
    self.webView.userInteractionEnabled = YES;
    self.webView.scalesPageToFit = YES;
    //请求ulr
    [RACObserve(self, urlString) subscribeNext:^(id x) {
        if ([self.urlString containsString:@"http://"]) {
            self.urlString = [self.urlString stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: [NSURL URLWithString:self.urlString]];
        request.timeoutInterval = 10;
        dispatch_main_async(^(){
            [self.webView loadRequest:request];
        })
        
    }];
}


// navBar 回调
- (void)navBarButtonAction:(UIButton *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(YMWebProgressLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [YMWebProgressLayer new];
        _progressLayer.frame = CGRectMake(0, 62, kScreenWidth, 2);
        _progressLayer.hidden = NO;
        [self.theSimpleNavigationBar.layer addSublayer:_progressLayer];
        // [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    }
    _progressLayer.hidden = NO;
    return _progressLayer;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.webView removeFromSuperview];
    self.webView = nil;
}

- (void)dealloc {
    [self.progressLayer closeTimer];
    [self.progressLayer removeFromSuperlayer];
    self.progressLayer = nil;
    self.webView = nil;
    NSLog(@"i am dealloc");
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"开始加载数据 request == %@",request);
    [self.progressLayer startLoad];
    NSString *url = [[request URL] absoluteString];
    NSString *transString = [NSString stringWithString:[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //self.hub = [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [self.progressLayer startLoad];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[self.hub removeFromSuperview];
    [self.progressLayer finishedLoad];
    [self.theSimpleNavigationBar.titleButton setTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"] forState:UIControlStateNormal];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.progressLayer finishedLoad];
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
