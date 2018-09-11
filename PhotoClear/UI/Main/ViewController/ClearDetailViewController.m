//
//  ClearDetailViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/20.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ClearDetailViewController.h"
#import "NewTableViewController.h"

@interface ClearDetailViewController ()

@property (nonatomic, strong)NewTableViewController *NewVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopLayoutConstraint;

@end

@implementation ClearDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNavWithTitle:@"手机清理" leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
}
- (void)loadUIData {
    NewTableViewController *VC = [[NewTableViewController alloc] initWithType:@"all"];
    [self addChildViewController:VC];
    [self.view addSubview:VC.view];
    [VC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(196);
        make.height.equalTo(self.view.mas_height).offset(0);
    }];
    self.NewVC = VC;
    
    VC.block_scroller = ^(CGFloat floa) {
        if (floa > 0 && floa<196) {
            [UIView animateWithDuration:1 animations:^{
                self.viewTopLayoutConstraint.constant = 64 - floa;
                [self.NewVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(196-floa);
                }];
            }];
        }
    };
}


- (void)navBarButtonAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
