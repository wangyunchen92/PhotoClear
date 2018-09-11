//
//  NSDate+CustomDate.m
//  PANewToapAPP
//
//  Created by Tyson on 14-10-13.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import "NSDate+CustomDate.h"

@implementation NSDate (CustomDate)

+ (NSString *) resetDate:(NSString *)originDate {
    if (originDate.length <= 0) {
        return @"N";
    }
    //验证格式是否@"19xx-xx-xx"
    NSString *regexStr = @"([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))";
    if ([self verifyStringByRegex:regexStr VCardString:originDate]) {
        NSArray *array = [originDate componentsSeparatedByString:@"-"];
        NSString *yearStr = array[0];
        NSString *monthStr = @"01";
        NSString *dayStr = @"01";
        
        if (array.count > 1) {
            monthStr = array[1];
        }
        if (array.count > 2) {
            dayStr = array[2];
        }
        
        if ([monthStr integerValue] < 1 || [monthStr integerValue] > 12) {
            monthStr = @"01";
        }
        if ([monthStr integerValue] > 0 && [monthStr integerValue] < 10) {
            monthStr = [NSString stringWithFormat:@"0%ld",(long)[monthStr integerValue]];
        }
        
        if ([dayStr integerValue] < 1 || [dayStr integerValue] > 31) {
            dayStr = @"01";
        }
        if ([dayStr integerValue] > 0 && [dayStr integerValue] < 10) {
            dayStr = [NSString stringWithFormat:@"0%ld",(long)[dayStr integerValue]];
        }
        
        originDate = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
        return originDate;
    } else {
        NSString *birthday = originDate;
        NSArray *array = [birthday componentsSeparatedByString:@"年"];
        NSString *yearStr = array[0];
        
        if (array.count <= 1) {
            return @"N";
        }
        birthday = array[1];
        
        array = [birthday componentsSeparatedByString:@"月"];
        NSString *monthStr = array[0];
        if (array.count <= 1) {
            return @"N";
        }
        birthday = array[1];
        
        array = [birthday componentsSeparatedByString:@"日"];
        NSString *dayStr = array[0];
        
        if ([monthStr integerValue] < 1 || [monthStr integerValue] > 12) {
            monthStr = @"01";
        }
        if ([monthStr integerValue] > 0 && [monthStr integerValue] < 10) {
            monthStr = [NSString stringWithFormat:@"0%ld",(long)[monthStr integerValue]];
        }
        
        if ([dayStr integerValue] < 1 || [dayStr integerValue] > 31) {
            dayStr = @"01";
        }
        if ([dayStr integerValue] > 0 && [dayStr integerValue] < 10) {
            dayStr = [NSString stringWithFormat:@"0%ld",(long)[dayStr integerValue]];
        }
        birthday = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
        
        return birthday;
    }
}

+ (BOOL)verifyStringByRegex:(NSString *)regexStr VCardString:(NSString *)vcardString {
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:vcardString options:0 range:NSMakeRange(0, [vcardString length])];
        if (firstMatch)
            return YES;
    }
    return NO;
}

@end
