//
//  ToolUtil+PublicParam.m
//  ColorfulFund
//
//  Created by Madis on 17/4/25.
//  Copyright © 2017年 zritc. All rights reserved.
//

#import "ToolUtil+PublicParam.h"
@implementation ToolUtil (PublicParam)

+ (NSDictionary *)publicParam
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    return @{@"version":version};
}


@end
