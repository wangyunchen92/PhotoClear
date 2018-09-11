//
//  playerViewController.m
//  LocalVideo
//
//  Created by antvr on 16/8/3.
//  Copyright © 2016年 sunTengFei_family. All rights reserved.
//

#import "playerViewController.h"
#import "LXAVPlayer.h"

@interface playerViewController ()
@property(nonatomic,strong)LXAVPlayView *playerview;

@property(nonatomic,strong)UIView *playFatherView;
@end

@implementation playerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavWithTitle:@"视频播放" leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = CGRectMake(0, 100, kScreenWidth, 300);
    
    self.playFatherView =[[UIView alloc]initWithFrame:rect];
    
    [self.view addSubview:self.playFatherView];
    
    LXPlayModel *model =[[LXPlayModel alloc]init];
    model.playItem = self.playerItem;
    model.videoTitle = @"";
    model.fatherView = self.playFatherView;
    self.playerview = [[LXAVPlayView alloc]init];
    
    self.playerview.isLandScape = YES;
    
    self.playerview.isAutoReplay = NO;
    
    self.playerview.currentModel = model;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.playerview destroyPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
