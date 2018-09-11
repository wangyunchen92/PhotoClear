//
//  ReportStatisticsTool.h
//  ColorfulFund
//
//  Created by Madis on 16/10/8.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportStatisticsTool : NSObject

+ (void)reportStatisticSerialNumber:(NSString *)serialNumber jsonDataString:(NSString *)string;// 事件点击统计,数量统计.
+ (void)reportStatisticBeginEventID:(NSString *)eventID jsonDataString:(NSString *)string;// 开始进入
+ (void)reportStatisticEndEventID:(NSString *)eventID jsonDataString:(NSString *)string;// 结束页面


// 进入页面
+ (void)reportStatisticBeginLogPageView:(NSString *)pageView;
// 退出界面
+ (void)reportStatisticEndLogPageView:(NSString *)pageView;
@end
