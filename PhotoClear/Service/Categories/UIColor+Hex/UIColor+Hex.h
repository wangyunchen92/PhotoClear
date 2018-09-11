//
//  UIColor+Hex.h
//  PingAnLife
//
//  Created by Zyfrog on 13-8-21.
//  Copyright (c) 2013年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 *	通过16进制获取color
 *
 *	@param	hex	16进制RGB
 *
 *	@return	uicolor
 */
+ (UIColor *)colorWithHex:(NSInteger)hex;

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
