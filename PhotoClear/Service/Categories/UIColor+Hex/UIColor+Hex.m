//
//  UIColor+Hex.m
//  PingAnLife
//
//  Created by Zyfrog on 13-8-21.
//  Copyright (c) 2013年 PingAn. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor *)colorWithHex:(NSInteger)hex
{
    return [UIColor colorWithHex:hex
                           alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex & 0XFF0000) >> 16) / 255.0
                           green:((hex & 0X00FF00) >> 8)  / 255.0
                            blue:(hex & 0X0000FF)         / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert{
    if ([stringToConvert hasPrefix:@"#"]) {
		stringToConvert = [stringToConvert substringFromIndex:1];
	}
	
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	
	if (![scanner scanHexInt:&hexNum]) {
		return nil;
	}
	
	return [UIColor colorWithHex:hexNum alpha:1];
}
@end
