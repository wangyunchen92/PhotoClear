//
//  HttpFileLoadProgress.m
//  XLAFNetworking
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 along. All rights reserved.
//

#import "HttpFileLoadProgress.h"

@interface HttpFileLoadProgress ()
/**
 *  单位大小
 */
@property (nonatomic,assign,readwrite) UnitSize unitSize;
/**
 *  加载大小 单位kb
 */
@property (nonatomic,assign,readonly) float loadProgressKb;
/**
 *  加载大小 单位Mb
 */
@property (nonatomic,assign,readonly) float loadProgressMb;
/**
 *  加载大小 单位Gb
 */
@property (nonatomic,assign,readonly) float loadProgressGb;

/**
 *  加载大小 单位kb
 */
@property (nonatomic,assign,readonly) double maxSizeKb;
/**
 *  加载大小 单位Mb
 */
@property (nonatomic,assign,readonly) double maxSizeMb;
/**
 *  加载大小 单位Gb
 */
@property (nonatomic,assign,readonly) double maxSizeGb;
@end

@implementation HttpFileLoadProgress

#pragma mark 初始化
/**
 *  初始化
 *
 *  @param unitSize 单位
 *
 *  @return self
 */
- (instancetype)initWithUnitSize:(UnitSize)unitSize {
    if(self = [super init]) {
        if(unitSize) {
            _unitSize = unitSize;
        }else {
            _unitSize = UntiSizeIsByte;
        }
    }
    return self;
}

#pragma mark set方法
- (void)setMaxSize:(int64_t)maxSize {
    _maxSize = maxSize;
    
    _maxSizeKb = maxSize / 1024.0;
    
    _maxSizeMb = _maxSizeKb / 1024.0;
    
    _maxSizeGb = _maxSizeMb / 1024.0;
}

- (void)setLoadProgress:(float)loadProgress {
    _loadProgress = loadProgress;
    
    _loadProgressKb = loadProgress / 1024.0;
    
    _loadProgressMb = _loadProgressKb / 1024.0;
    
    _loadProgressGb = _loadProgressMb / 1024.0;    
}

#pragma mark description
-(NSString *)description {
    
    switch (_unitSize) {
        case 0: {
            return [NSString stringWithFormat:@"正在传输%.0lf B 总大小：%.0lld B 进度：%.2lf%%",_loadProgress,_maxSize,_loadFractionCompleted];
        }
            break;
        case 1: {
            return [NSString stringWithFormat:@"正在传输%.0lf KB 总大小：%.0lf KB 进度：%.2lf%%",_loadProgressKb,_maxSizeKb,_loadFractionCompleted];
        }
            break;
        case 2: {
            return [NSString stringWithFormat:@"正在传输%.0lf MB 总大小：%.0lf MB 进度：%.2lf%%",_loadProgressMb,_maxSizeMb,_loadFractionCompleted];
        }
            break;
        case 3: {
            return [NSString stringWithFormat:@"正在传输%.0lf GB 总大小：%.0lf GB 进度：%.2lf%%",_loadProgressGb,_maxSizeGb,_loadFractionCompleted];
        }
            break;
        default:
            break;
    }
    
    return nil;
}

@end
