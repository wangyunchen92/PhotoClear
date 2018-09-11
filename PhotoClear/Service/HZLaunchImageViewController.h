//
//  HZLaunchImageViewController.h
//  ColorfulFund
//
//  Created by Madis on 17/3/28.
//  Copyright © 2017年 zritc. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger, ActivityViewClickedTag) {
    kActivityViewClickedView = 1000,
    kActivityViewClickedButton,
    kActivityViewClickedNone,
};

@interface HZLaunchImageViewController : BaseViewController


- (id)initWithDefaultImage;
//1000:点击广告页面
//1001:点击跳过按钮
//1002:正常走完
@property (nonatomic, copy) void(^block_activityViewClicked)(ActivityViewClickedTag clickedTag);

@end

//首次启动时不显示启动页只显示引导页
