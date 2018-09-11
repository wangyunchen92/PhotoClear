//
//  WKVideoManage.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "WKVideoManage.h"


@interface WKVideoManage ()

@property (nonatomic, copy) void (^completionHandler)(BOOL success, NSError *error);
@property (nonatomic, copy) void (^processHandler)(NSInteger current, NSInteger total);

@property (nonatomic, strong) PHFetchResult *assetArr;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) NSUInteger saveSpace;

@property (nonatomic, strong) PHImageRequestOptions *imageOpt;


@end

@implementation WKVideoManage

+ (WKVideoManage *)shareManager {
    static WKVideoManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[WKVideoManage alloc] init];
    });
    return manage;
    
}

// 重置数据
- (void)resetTagData {
    [self.dataArr removeAllObjects];
    self.saveSpace = 0;
}

#pragma mark - GetImage

- (void)loadVideoWithProcess:(void (^)(NSInteger current, NSInteger total))process
           completionHandler:(void (^)(BOOL success, NSError *error))completion {
    [self resetTagData];
    self.dataInfo = [[NSMutableDictionary alloc] init];
    self.processHandler = process;
    self.completionHandler = completion;
    
    // 获取当前App的相册授权状态
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    // 判断授权状态
    if (authorizationStatus == PHAuthorizationStatusAuthorized) {
        // 如果已经授权, 获取图片
        [self getAllAsset];
    }
    // 如果没决定, 弹出指示框, 让用户选择
    else if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            // 如果用户选择授权, 则获取图片
            if (status == PHAuthorizationStatusAuthorized) {
                [self getAllAsset];
            }
        }];
    } else {
        [self noticeAlert];
    }
}

// 获取相簿中的PHAsset对象
- (void)getAllAsset {
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:options];
    self.assetArr = result;
    
    [self requestImageWithIndex:0];
}

// 获取图片
- (void)requestImageWithIndex:(NSInteger)index {
    self.processHandler(index, self.assetArr.count);
    
    if (index >= self.assetArr.count) {
        [self loadCompletion];
        self.completionHandler(YES, nil);
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    // 筛选本地图片，过滤视频、iCloud图片
    PHAsset *asset = self.assetArr[index];
    if (asset.mediaType != PHAssetMediaTypeVideo || asset.sourceType != PHAssetSourceTypeUserLibrary) {
        [self requestImageWithIndex:index+1];
        return;
    } else {
        [weakSelf saveData:asset andindex:index];
    }

    
}

-  (void)saveData:(PHAsset *)asset andindex:(NSInteger )index {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable ast, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {

        AVURLAsset* urlAsset = (AVURLAsset*)ast;

        NSNumber *size;
        [urlAsset.URL getResourceValue:&size forKey:NSURLFileSizeKey error:nil];
        self.saveSpace = self.saveSpace + [size floatValue];
        //        NSLog(@"size is %f",[size floatValue]/(1024.0*1024.0));
//
        // 获取缩率图
            __weak typeof(self) weakSelf = self;
        PHImageManager *mgr = [PHImageManager defaultManager];
        [mgr requestImageForAsset:asset targetSize:CGSizeMake(125, 125) contentMode:PHImageContentModeAspectFill options:self.imageOpt resultHandler:^(UIImage *result, NSDictionary *info) {
            
            NSString *videoName = [asset valueForKey:@"filename"];
            //获取视频的缩略图
            UIImage *image = result;
            //视频时长
            NSString *timeLength = [self getVideoDurtion:[self getcalduration:asset]];
            
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:asset,@"asset",videoName,@"name",image,@"image",timeLength,@"timeLength", nil];
            [self.dataArr addObject:dic];
            
            [weakSelf requestImageWithIndex:index+1];
        }];
        
    }];


}


#pragma mark -  加载完成
- (void)loadCompletion {
    [self.dataInfo setObject:self.dataArr forKey:@"array"];
    [self.dataInfo setObject:@(self.saveSpace) forKey:@"saveSpace"];
//    self.dataInfo =  @{@"array":self.dataArr, @"saveSpace" : @(self.saveSpace)};
}




// 开启权限提示
- (void)noticeAlert {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"此功能需要相册授权"
                                        message:@"请您在设置系统中打开授权开关"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *left = [UIAlertAction actionWithTitle:@"取消"
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil];
    UIAlertAction *right = [UIAlertAction actionWithTitle:@"前往设置"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                      [[UIApplication sharedApplication] openURL:url];
                                                  }];
    [alert addAction:left];
    [alert addAction:right];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)getcalduration:(PHAsset *)asset{
    
    NSInteger dur;
    
    NSInteger time = asset.duration;
    
    double time2 = (double)(asset.duration - time);
    
    if (time2 < 0.5) {
        dur = asset.duration;
    }else{
        dur = asset.duration + 1;
    }
    
    return dur;
    
}


-(NSString *)getVideoDurtion:(NSInteger)duration{
    
    NSInteger h = (NSInteger)duration/3600; //总小时
    
    NSInteger mT = (NSInteger)duration%3600; //总分钟
    
    NSInteger m = mT/60; //最终分钟
    
    
    NSInteger s = mT%60; //最终秒数
    
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)h,(long)m,(long)s];
    
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (PHImageRequestOptions *)imageOpt {
    if (!_imageOpt) {
        _imageOpt = [[PHImageRequestOptions alloc] init];
        // resizeMode 属性控制图像的剪裁
        _imageOpt.resizeMode = PHImageRequestOptionsResizeModeNone;
        // deliveryMode 则用于控制请求的图片质量
        _imageOpt.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    }
    return _imageOpt;
}



@end
