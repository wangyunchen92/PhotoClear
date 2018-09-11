//
//  NewHeadlineViewController.m
//  Constellation
//
//  Created by Sj03 on 2018/3/23.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NewHeadlineViewController.h"
#import "NewTableViewController.h"
#import "NewHealineTitleViewModel.h"

@interface NewHeadlineViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong)NewHealineTitleViewModel *viewModel;
@property (nonatomic, strong)NSString *stringPag;

@end

@implementation NewHeadlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stringPag = @"1";
    self.viewModel = [[NewHealineTitleViewModel alloc] init];
    [self.viewModel.subject_getDate sendNext:self.stringPag];
    @weakify(self);
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self reloadData];
    };

}


- (void)viewWillAppear:(BOOL)animated {

}

// 顶部有几个Icon
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.viewModel.dataArray.count ? self.viewModel.dataArray.count : 0;
}

// 顶部Icon的Title
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {

    return self.viewModel.dataArray.count ? self.viewModel.dataArray[index] : @"头条";
}

// 每个Icon 对应产生的View
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    NewTableViewController *VC = [[NewTableViewController alloc] initWithType:[self.viewModel.allKeyArray objectAtIndex: index]];
//    UIViewController *VC = [[UIViewController alloc] init];
    return VC;

}


- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 40;
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
//    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, 0, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += self.redView.frame.size.height;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
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
