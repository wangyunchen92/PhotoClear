//
//  NSMutableDictionary+Utils.h
//  iOSCodeProject
//
//  Created by Fox on 14-7-19.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  可变字典扩展类别
 */
@interface NSMutableDictionary (Utils)

/**
 *  添加非空字符串
 *
 *  @param stringObject 字符串
 *  @param key  关键字
 */
- (void)addUnEmptyString:(NSString *)stringObject forKey:(NSString *)key;

@end
