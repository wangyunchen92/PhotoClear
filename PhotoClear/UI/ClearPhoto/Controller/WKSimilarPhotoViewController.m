//
//  WKSimilarPhotoViewController.m
//  WuKongClearPhotoDemo
//
//  Created by ZhangJingHao2345 on 2018/3/8.
//  Copyright © 2018年 ZhangJingHao2345. All rights reserved.
//

#import "WKSimilarPhotoViewController.h"
#import "WKSimilarPhotoCell.h"
#import "WKSimilarPhotoHeadView.h"
#import "WKPhotoInfoItem.h"
#import "WKClearPhotoManager.h"
#import "MBProgressHUD.h"
#import "ReViewPhotoView.h"
#import "bottomView.h"


#import "YCPhotoBrowserController.h"
#import "YCPhotoBrowserAnimator.h"

@interface WKSimilarPhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *seleArr;

@property (nonatomic, strong) bottomView *btView;

@property (nonatomic, strong)RACSubject *subject_seleArrChange;

@end

@implementation WKSimilarPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"清理相似照片";
    if (self.isScreenshots) {
        self.title = @"截屏图片";
    }
    [self createNavWithTitle:@"照片清理" leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.subject_seleArrChange = [[RACSubject alloc] init];
    [self configData];
    [self setupUI];
}

- (void)configData {
    [self.dataArr removeAllObjects];
    self.seleArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.similarArr) {
        NSString *keyStr = dict.allKeys.lastObject;
        NSArray *arr = dict.allValues.lastObject;
        NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *infoDict = arr[i];
            WKPhotoInfoItem *item = [[WKPhotoInfoItem alloc] initWithDict:infoDict];
            [mutArr addObject:item];
            
            if (self.isScreenshots) {
                // 截屏都选择
                item.isSelected = YES;
                [self.seleArr  addObject:item];
            } else {
                if (i != 0) {
                    item.isSelected = YES;
                    [self.seleArr  addObject:item];
                }
            }
        }
        NSDictionary *temDict = @{keyStr : mutArr};
        [self.dataArr addObject:temDict];
    }
    if (self.dataArr.count == 0) {
        UIImageView *imageview = [[UIImageView alloc] initWithImage:IMAGE_NAME(@"照片清理_无照片")];
        [self.view addSubview:imageview];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"暂无可清理的图片";
        label.textColor = RGB(152, 153, 154);
        [self.view addSubview:label];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-10);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(imageview.mas_bottom).offset(5);
        }];
    } else {
            [self.collectionView reloadData];
    }

}

- (void)noSeleAllData {
    [self.dataArr removeAllObjects];
    self.seleArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.similarArr) {
        NSString *keyStr = dict.allKeys.lastObject;
        NSArray *arr = dict.allValues.lastObject;
        NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *infoDict = arr[i];
            WKPhotoInfoItem *item = [[WKPhotoInfoItem alloc] initWithDict:infoDict];
            item.isSelected = NO;
            [mutArr addObject:item];
        }
        NSDictionary *temDict = @{keyStr : mutArr};
        [self.dataArr addObject:temDict];
    }
    [self.subject_seleArrChange sendNext:@YES];
    [self.collectionView reloadData];
}

- (void)seleAllData {
    [self.dataArr removeAllObjects];
    self.seleArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.similarArr) {
        NSString *keyStr = dict.allKeys.lastObject;
        NSArray *arr = dict.allValues.lastObject;
        NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *infoDict = arr[i];
            WKPhotoInfoItem *item = [[WKPhotoInfoItem alloc] initWithDict:infoDict];
            item.isSelected = YES;
            [mutArr addObject:item];
            [self.seleArr  addObject:item];
        }
        NSDictionary *temDict = @{keyStr : mutArr};
        [self.dataArr addObject:temDict];
    }
    [self.subject_seleArrChange sendNext:@YES];
    [self.collectionView reloadData];
}

- (void)setupUI {
    CGFloat btnH = 50;
    CGFloat btnY = self.view.frame.size.height - btnH;
    CGFloat btnW = self.view.frame.size.width;
    bottomView *botview = [[bottomView alloc] initWithFrame:CGRectMake(0, btnY, btnW, btnH)];
    [self.view addSubview:botview];
    self.btView = botview;
    @weakify(self);
    self.btView.block_allChonse = ^(BOOL issle) {
        @strongify(self);
        if (issle) {
            [self seleAllData];
        } else {
            [self noSeleAllData];
        }
    };
    self.btView.block_dele = ^{
        @strongify(self);
        [self clickDeleteBtn];
    };
    
    [self.subject_seleArrChange subscribeNext:^(id x) {
        [self.btView.deleButton setTitle:[NSString stringWithFormat:@"删除(%ld张)",self.seleArr.count] forState:UIControlStateNormal];
    }];
    [self.subject_seleArrChange sendNext:@YES];

//    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, btnY, btnW, btnH)];
//    [deleteBtn setTitle:@"删除相似照片" forState:UIControlStateNormal];
//    deleteBtn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:deleteBtn];
//    [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickDeleteBtn {
    
    NSMutableArray *assetArr = [NSMutableArray array];
    NSMutableArray *temDataArr = [NSMutableArray array];
    
    for (NSDictionary *dict in self.dataArr) {
        NSArray *arr = dict.allValues.lastObject;
        NSMutableArray *mutArr = [NSMutableArray array];
        for (WKPhotoInfoItem *item in arr) {
            if (item.isSelected) {
                [assetArr addObject:item.asset];
            } else {
                [mutArr addObject:item];
            }
        }
        
        if ( (self.isScreenshots && mutArr.count>0) || (!self.isScreenshots && mutArr.count > 1) ) {
            NSDictionary *temDict = @{dict.allKeys.lastObject : mutArr};
            [temDataArr addObject:temDict];
        }
    }
    
    if (assetArr.count) {
        [WKClearPhotoManager shareManager].notificationStatus = WKPhotoNotificationStatusClose;
        [WKClearPhotoManager deleteAssets:assetArr
                        completionHandler:^(BOOL success, NSError *error) {
                            if (success) {
                                [self deleteSuccessWithTemDataArr:temDataArr];
                            }
                        }];
    }
}

- (void)deleteSuccessWithTemDataArr:(NSMutableArray *)temDataArr {
    self.dataArr = temDataArr;
    [self.collectionView reloadData];
    
    [WKClearPhotoManager tipWithMessage:@"删除成功"];
    [WKClearPhotoManager shareManager].notificationStatus = WKPhotoNotificationStatusNeed;

}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *dict = self.dataArr[section];
    NSArray *arr = dict.allValues.lastObject;
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WKSimilarPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WKSimilarPhotoCell_id"
                                              forIndexPath:indexPath];
    NSDictionary *dict = self.dataArr[indexPath.section];
    NSArray *arr = dict.allValues.lastObject;
    [cell bindWithModel:arr[indexPath.row]];
    cell.backgroundColor = [UIColor yellowColor];
    cell.block_sele = ^(BOOL issele) {
        if (issele) {
            [self.seleArr addObject:arr[indexPath.row]];
            [self.subject_seleArrChange sendNext:@YES];
        } else {
            if ([self.seleArr containsObject:arr[indexPath.row]]) {
                [self.seleArr removeObject:arr[indexPath.row]];
                [self.subject_seleArrChange sendNext:@YES];
                self.btView.allButton.selected = NO;
            }
        }
        NSLog(@"%ld",self.seleArr.count);
    };
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        WKSimilarPhotoHeadView *headerV =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WKSimilarPhotoHeadView_id" forIndexPath:indexPath];
        NSDictionary *dict = self.dataArr[indexPath.section];
        [headerV bindWithModel:dict];
        return headerV;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{//设置段头view大小
    return CGSizeMake(0, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArr[indexPath.section];
    NSArray *arr = dict.allValues.lastObject;
    WKPhotoInfoItem *model = arr[indexPath.row];
    
//    // 1. 创建动画配置类
//    YCPhotoBrowserAnimator *browserAnimator = [[YCPhotoBrowserAnimator alloc] initWithPresentedDelegate:self];
//
//    // 2. 创建图片控制器类(有两种创建方式，本地图和网络图)
//    // ① 网络图片
//    // urlReplacing为缩略图url和高清图url的转换:比如传入@{@“small”：@“big”}
//    // 即可将传入的url（带small）自动转成高清图url（带big）
//    YCPhotoBrowserController *vc = [YCPhotoBrowserController instanceWithShowImagesURLs:nil urlReplacing:nil];
//    // ② 本地图片（传入UIImage）
//    // + (instancetype)instanceWithShowImages:(NSArray<UIImage *> *)showImages{
//
//
//    // 设置点击的下标，没设置则从第一张开始
//    vc.indexPath = indexPath;
//    // 设置动画，没设置则没动画
//    vc.browserAnimator = browserAnimator;
//    ///还可以设置指示视图位置，类型，长按的回调。。。
//
//    // 4.弹出图片控制器
//    [self presentViewController:vc animated:YES completion:nil];
//
    [WKClearPhotoManager getOriginImageWithAsset:model.asset completionHandler:^(UIImage *result, NSDictionary *info) {

        ReViewPhotoView *review = [[ReViewPhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) Photo: result];
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionReveal;
        transition.duration = 0.5;
        [review.layer addAnimation:transition forKey:nil];
        [self.navigationController.view addSubview:review];
        review.longpressblock =^(UIImage *blockimage) {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"删除图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *savephotoAction = [UIAlertAction actionWithTitle:@"删除图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSArray *arrAss = [[NSArray alloc] initWithObjects:model.asset, nil];
                [WKClearPhotoManager deleteAssets:arrAss
                                completionHandler:^(BOOL success, NSError *error) {
                                    if (success) {
                                        [self.dataArr removeObject:self.dataArr[indexPath.section]];
                                        [self.collectionView reloadData];
                                        [review removeFromSuperview];
                                        [WKClearPhotoManager tipWithMessage:@"恭喜，删除成功！"];
                                    }
                                }];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVc addAction:savephotoAction];
            [alertVc addAction:cancelAction];
            [self.navigationController presentViewController:alertVc animated:YES completion:^{
                
            }];
        };
    }];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        CGFloat itemCount = 4;
        CGFloat distance = 8;
        CGFloat width = self.view.frame.size.width;
        CGFloat itemWH = (width - distance * (itemCount + 1)) / itemCount - 1;
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        layout.sectionInset = UIEdgeInsetsMake(distance, distance, distance, distance);
        layout.minimumLineSpacing = distance;
        layout.minimumInteritemSpacing = distance;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)
                                             collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[WKSimilarPhotoCell class]
            forCellWithReuseIdentifier:@"WKSimilarPhotoCell_id"];
        [_collectionView registerClass:[WKSimilarPhotoHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"WKSimilarPhotoHeadView_id"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
        
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.delaysContentTouches = NO;
        if (@available(iOS 11,*)) {
            if ([UIScreen mainScreen].bounds.size.height == 812) {
                _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                CGFloat h1 = [UIApplication sharedApplication].statusBarFrame.size.height;
                CGFloat h2 = self.navigationController.navigationBar.bounds.size.height;
                _collectionView.contentInset = UIEdgeInsetsMake(h1 + h2, 0, 0, 0);
                _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(h1 + h2, 0, 0, 0);
            }
        }
        UIEdgeInsets inset = _collectionView.contentInset;
        _collectionView.contentInset = UIEdgeInsetsMake(inset.top, inset.left, 50, inset.right);
        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
