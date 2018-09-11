//
//  PictureClearListViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PictureClearListViewController.h"

#import "WKClearPhotoManager.h"
#import "MBProgressHUD.h"
#import "WKSimilarPhotoViewController.h"
#import "WKThinPhotoViewController.h"
#import "AppDelegate.h"

@interface PictureClearListViewController ()<WKClearPhotoManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secendView;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIButton *firstViewButton;
@property (weak, nonatomic) IBOutlet UIButton *secendViewButton;
@property (weak, nonatomic) IBOutlet UIButton *threeViewButton;
@property (weak, nonatomic) IBOutlet UILabel *firstViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *secendViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeViewLabel;


@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) WKClearPhotoManager *photoMgr;
@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation PictureClearListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNavWithTitle:@"照片清理" leftImage:@"Whiteback" rightText:@"刷新"];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self.theSimpleNavigationBar.rightButton setTitleColor:[UIColor whiteColor] forState:0];
    [UIUtil addshadows:self.firstView];
    [UIUtil addshadows:self.secendView];
    [UIUtil addshadows:self.threeView];
    [self loadPhotoData];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.photoMgr.notificationStatus == WKPhotoNotificationStatusNeed) {
        [self loadPhotoData];
        self.photoMgr.notificationStatus = WKPhotoNotificationStatusDefualt;
    }
}

- (void)loadPhotoData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadNeedClearPhoto];
    });
    
    if (self.photoMgr) {
        [self configData];
    }

}

- (void)loadNeedClearPhoto {
    
    if (self.hud) {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];

    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"扫描照片中";
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    
    __weak typeof(self) weakSelf = self;
    [self.photoMgr loadPhotoWithProcess:^(NSInteger current, NSInteger total) {
        hud.progress = (CGFloat)current / total;
    } completionHandler:^(BOOL success, NSError *error) {
        [hud hideAnimated:YES];
        [weakSelf configData];
    }];
}

- (void)configData {
    self.hud = nil;
    
    WKClearPhotoItem *item1 =
    [[WKClearPhotoItem alloc] initWithType:WKClearPhotoTypeSimilar
                                  dataDict:self.photoMgr.similarInfo];
    WKClearPhotoItem *item2 =
    [[WKClearPhotoItem alloc] initWithType:WKClearPhotoTypeScreenshots
                                  dataDict:self.photoMgr.screenshotsInfo];
    WKClearPhotoItem *item3 =
    [[WKClearPhotoItem alloc] initWithType:WKClearPhotoTypeThinPhoto
                                  dataDict:self.photoMgr.thinPhotoInfo];
    self.dataArr = @[item1, item2, item3];
    
    CGFloat headW = self.view.frame.size.width;
    CGFloat headH = 150;
    UILabel *headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headW, headH)];
    headLab.text = [NSString stringWithFormat:@"优化后可节约空间 %.2fMB", self.photoMgr.totalSaveSpace / 1024.0/1024.0];
    headLab.textAlignment = NSTextAlignmentCenter;
    
    {
        NSString *firstString = [NSString stringWithFormat:@"%@ 可省 %@", item1.detail, item1.saveStr];
        self.firstViewLabel.text = firstString;
    }
    {
        NSString *firstString = [NSString stringWithFormat:@"%@ 可省 %@", item2.detail, item2.saveStr];
        self.secendViewLabel.text = firstString;
    }
    {
        NSString *firstString = [NSString stringWithFormat:@"%@ 可省 %@", item3.detail, item3.saveStr];
        self.threeViewLabel.text = firstString;
    }
}

// 相册变动代理方法
- (void)clearPhotoLibraryDidChange {
    [self loadPhotoData];
}



- (IBAction)firstViewClick:(id)sender {
    WKSimilarPhotoViewController *vc = [WKSimilarPhotoViewController new];
    vc.similarArr = self.photoMgr.sameDateArr;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)secendViewTap:(id)sender {
    WKSimilarPhotoViewController *vc = [WKSimilarPhotoViewController new];
    vc.similarArr = self.photoMgr.screenshotsArr;
    vc.isScreenshots = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)threeViewTap:(id)sender {
    WKThinPhotoViewController *vc = [WKThinPhotoViewController new];
    vc.thinPhotoArr = self.photoMgr.thinPhotoArr;
    vc.thinPhotoItem = self.dataArr.lastObject;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WKClearPhotoManager *)photoMgr {
    if (!_photoMgr) {
        _photoMgr = [WKClearPhotoManager shareManager];
        _photoMgr.delegate = self;
    }
    return _photoMgr;
}

-  (void)navBarButtonAction:(UIButton *)sender {
    switch (sender.tag) {
        case NBButtonLeft:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case NBButtonRight:
        {
            [self loadNeedClearPhoto];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
