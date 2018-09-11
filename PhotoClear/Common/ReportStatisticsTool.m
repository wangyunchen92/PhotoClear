//
//  ReportStatisticsTool.m
//  ColorfulFund
//
//  Created by Madis on 16/10/8.
//  Copyright © 2016年 zritc. All rights reserved.
//

#import "ReportStatisticsTool.h"

@implementation ReportStatisticsTool

+ (void)reportStatisticSerialNumber:(NSString *)serialNumber jsonDataString:(NSString *)string {
    // 自定义事件的数据默认是下次启动时发送
    [MobClick event:serialNumber label:string];
}

+ (void)reportStatisticBeginEventID:(NSString *)eventID jsonDataString:(NSString *)string {
    [MobClick beginEvent:eventID];
}

+ (void)reportStatisticEndEventID:(NSString *)eventID jsonDataString:(NSString *)string {
    [MobClick endEvent:eventID];
}

+ (void)reportStatisticBeginLogPageView:(NSString *)pageView {
    [MobClick beginLogPageView:pageView];
}

+ (void)reportStatisticEndLogPageView:(NSString *)pageView {
    [MobClick endLogPageView:pageView];
}
@end
