//
//  UserDefaultsTool.h
//  MJExtensionApplication
//
//  Created by Madis on 16/7/4.
//  Copyright © 2016年 Madis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsTool : NSObject

/**
 *  1.通过UserDefaultsTool进行偏好设置设值
 *
 *  @param v   保存的字符串：值
 *  @param key 键
 */
+(void)setString:(NSString*)v withKey:(NSString*)key;
/**
 *  2.获取UserDefaultsTool保存的字符串
 *
 *  @param key
 *
 *  @return 字符串b
 */
+(NSString*)getStringWithKey:(NSString*)key ;
/**
 * 3.获取UserDefaultsTool保存的字符串如果没有 取默认值d
 *
 *  @param key
 *  @param d  默认值
 *
 *  @return 字符串
 */
+(NSString*)getStringWithKey:(NSString*)key withDefault:(NSString*)d;

//======
/**
 *  设置bool类型
 *
 *  @param v   设置的类型
 *  @param key 设置的key
 */
+(void)setBool:(BOOL)v withKey:(NSString*)key;
+(BOOL)getBoolWithKey:(NSString*)key;
+(BOOL)getBoolWithKey:(NSString*)key withDefault:(BOOL)d;

//====
+(void)setInt:(int)v withKey:(NSString*)key;
+(int)getIntWithKey:(NSString*)key;
+(int)getIntWithKey:(NSString*)key withDefault:(int)d;

//====
+(BOOL)keyExists:(NSString*)key;
+(BOOL)keyUndefined:(NSString*)key;
+(BOOL)isKeyUndefinedThenDefine:(NSString*)what;

- (void)removeuserDefaultsWithKey:(NSString *)key;

@end
