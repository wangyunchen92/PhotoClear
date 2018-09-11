//
//  VideoClearViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "VideoClearViewController.h"
#import "WKVideoManage.h"
#import "TFVideoCell.h"
#import "playerViewController.h"
#import <Photos/Photos.h>

@interface VideoClearViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) WKVideoManage *videoManage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation VideoClearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"视频清理" leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self loadVideoData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadVideoData {
    if (self.hud) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"扫描视频中";
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    
//    __weak typeof(self) weakSelf = self;
    
    self.videoManage = [WKVideoManage shareManager];
    
    [self.videoManage loadVideoWithProcess:^(NSInteger current, NSInteger total) {
        hud.progress = (CGFloat)current / total;
    } completionHandler:^(BOOL success, NSError *error) {
        [hud hideAnimated:YES];
        [self.tableView reloadData];
    }];
}


#pragma mark - 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [self.videoManage.dataInfo arrayForKey:@"array"];
    return arr.count ? arr.count : 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TFVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TFVideoCell" owner:nil options:nil].firstObject;
    }
    NSArray *cellarr = [self.videoManage.dataInfo arrayForKey:@"array"];
    NSDictionary *celldic = [cellarr objectAtIndex:indexPath.row];
    
    cell.videoNameLabel.text = [celldic stringForKey:@"name"];
    
    cell.timeLengthLabel.text = [celldic stringForKey:@"timeLength"];
    
    cell.thumImageView.image = [celldic objectForKey:@"image"];
    cell.index = indexPath;
    
    cell.block_del = ^(NSIndexPath *index) {
         NSArray *arr = [self.videoManage.dataInfo arrayForKey:@"array"];
        NSMutableArray *mutarr = [[NSMutableArray alloc] initWithArray:arr];
        NSDictionary *dic = [arr objectAtIndex:indexPath.row];
        PHAsset *asset = [dic objectForKey:@"asset"];
        NSArray *assetarr = [[NSArray alloc] initWithObjects:asset, nil];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest deleteAssets:assetarr];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [mutarr removeObject:dic];
                    [self.videoManage.dataInfo setObject:mutarr forKey:@"array"];
                    [self.tableView reloadData];
                });
            }
        }];
    };
    return cell;
}

//点击播放的处理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [self.videoManage.dataInfo arrayForKey:@"array"];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    PHAsset *asset = [dic objectForKey:@"asset"];
    [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            playerViewController *MD = [[playerViewController alloc]init];
            MD.playerItem = playerItem;
            [self.navigationController pushViewController:MD animated:YES];
        });
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
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
