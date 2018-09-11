//
//  HttpFileLoadProgress.h
//  XLAFNetworking
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 单位
 */
typedef NS_ENUM(NSInteger,UnitSize) {
    UntiSizeIsByte = 0,
    UntiSizeIsKByte,
    UntiSizeIsMByte,
    UntiSizeIsGByte
};

@interface HttpFileLoadProgress : NSObject

/**
 *  加载值 默认单位b
 */
@property (nonatomic,assign) float loadProgress;

/**
 *  总大小 默认单位b
 */
@property (nonatomic,assign) int64_t maxSize;

/**
 *  加载百分比
 */
@property (nonatomic,assign) double loadFractionCompleted;

/**
 *  初始化
 *
 *  @param unitSize 单位
 *
 *  @return self
 */
- (instancetype)initWithUnitSize:(UnitSize)unitSize;

@end
