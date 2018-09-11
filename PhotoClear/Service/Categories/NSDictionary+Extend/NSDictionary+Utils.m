//
//  NSDictionary+Utils.m
//  WLTProject
//
//  Created by frankfeng on 13-1-21.
//  Copyright (c) 2013年 luojing. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

- (NSString *)stringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if (obj) {
        if ([obj isKindOfClass:[NSString class]])
            return (NSString *)obj;
        else if ([obj isKindOfClass:[NSNumber class]])
            return [(NSNumber *)obj stringValue];
        else if ([obj isKindOfClass:[NSNull class]])
            return @"";
    }
    return @"";
}

//- (CGFloat)floatForKey:(id)key
//{
//    NSString * value = [self stringForKey:key];
//    if (value.length > 0)
//        return [value floatValue];
//    return 0;
//}

- (NSDictionary *)dictForKey:(id)key
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }
    return nil;
}

- (NSArray *)arrayForKey:(id)key
{
    id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }
    return nil;
}
- (BOOL)boolForKey:(id)key{
     NSString * value = [self stringForKey:key];
    if(value.length>0){
        return [value boolValue];
    }
    return NO;
}

- (NSInteger)integerForKey:(id)key{
     NSString * value = [self stringForKey:key];
    if(value.length>0){
        return [value integerValue];
    }
    return 0;
}

@end

@implementation NSMutableDictionary (Utils)

@end
