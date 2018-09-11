//
//  NewTableViewController.m
//  Constellation
//
//  Created by Sj03 on 2018/3/23.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NewTableViewController.h"
#import "OneImageTableViewCell.h"
#import "ThreeImageTableViewCell.h"
#import "NewHeadlineViewModel.h"
#import "NewsModel.h"
#import "NewWebViewController.h"
#import "AppDelegate.h"
#import <MJRefresh/MJRefresh.h>


@interface NewTableViewController ()<UIApplicationDelegate>
@property (nonatomic, strong)NewHeadlineViewModel *viewModel;
@end

@implementation NewTableViewController
- (instancetype)initWithType:(NSString *)type {
    self = [super init];
    if (self) {
        self.viewModel = [[NewHeadlineViewModel alloc] init];
        self.viewModel.typeString = type;
        self.needScrollForScrollerView = YES;

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel.subject_getDate sendNext:@YES];
    @weakify(self)
    self.viewModel.block_reloadDate = ^{
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    };
    self.tableView.estimatedRowHeight =44.0f;
    self.tableView.rowHeight =UITableViewAutomaticDimension;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OneImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OneImageTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ThreeImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ThreeImageTableViewCell class])];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.viewModel.pagString =[NSString stringWithFormat:@"%ld",[self.viewModel.pagString integerValue] + 1];
        self.viewModel.isadd = NO;
        [self.viewModel.subject_getDate sendNext:@YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.viewModel.pagString =[NSString stringWithFormat:@"%ld",[self.viewModel.pagString integerValue] + 1];
        self.viewModel.isadd = YES;
        [self.viewModel.subject_getDate sendNext:@YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    if (model.typeString == OneImage_NewType) {
        OneImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OneImageTableViewCell class]) forIndexPath:indexPath];
        [cell getDateForServer:model];
        return cell;
    } else if (model.typeString == ThreeImage_NewType) {
        ThreeImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThreeImageTableViewCell class]) forIndexPath:indexPath];
        [cell getDateForServer:model];
        return cell;
    }

    // Configure the cell...
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.block_scroller) {
        self.block_scroller(scrollView.contentOffset.y);
    }
    
    if (self.needScrollForScrollerView) {
        return;
    }
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    
    self.tableView.showsVerticalScrollIndicator = self.canScroll?YES:NO;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    NewWebViewController *WebVC = [[NewWebViewController alloc] init];
    WebVC.urlString = model.urlString;
    // 暂存用户读过的新闻
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.readNewsArray addObject:model.idString];
    model.isread = YES;
    [self.viewModel.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    NSArray *arr = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    [self.navigationController pushViewController:WebVC animated:YES];
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
