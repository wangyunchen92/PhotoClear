//
//  NSDictionary+Utils.h
//  WLTProject
//
//  Created by frankfeng on 13-1-21.
//  Copyright (c) 2013年 luojing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utils)

- (NSString *)stringForKey:(id)key;
//- (CGFloat)floatForKey:(id)key;
- (NSDictionary *)dictForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
@end

@interface NSMutableDictionary (Utils)


@end
