//
//  MainNewHealineViewController.m
//  Constellation
//
//  Created by Sj03 on 2018/3/23.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainNewHealineViewController.h"
#import "NewHeadlineViewController.h"

@interface MainNewHealineViewController ()
@property (nonatomic, strong)NewHeadlineViewController *boardView;
@end

@implementation MainNewHealineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boardView = [[NewHeadlineViewController alloc] init];
    self.boardView.menuViewStyle = WMMenuViewStyleLine;
//    self.boardView.isShadow = YES;
    self.boardView.titleColorSelected = [UIColor blueColor];
    self.boardView.automaticallyCalculatesItemWidths = YES;
    self.boardView.preloadPolicy = WMPageControllerPreloadPolicyHeight;
    self.boardView.cachePolicy = WMPageControllerCachePolicyHigh;
    
    [self.view addSubview:self.boardView.view];
    [self.boardView.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(64);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [self addChildViewController:_boardView];
    // Do any additional setup after loading the view from its nib.
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
