//
//  UserDefaultsTool.m
//  MJExtensionApplication
//
//  Created by Madis on 16/7/4.
//  Copyright © 2016年 Madis. All rights reserved.
//

#import "UserDefaultsTool.h"

@implementation UserDefaultsTool

+(NSString*)getStringWithKey:(NSString*)key {
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(!string){
        string = @"";
    }
    return string;
}

+(NSString*)getStringWithKey:(NSString*)key withDefault:(NSString*)d {
    if([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil) {
        return d;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void)setString:(NSString*)v withKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:v forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)getBoolWithKey:(NSString*)key {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
}

+(BOOL)getBoolWithKey:(NSString*)key withDefault:(BOOL)d {
    if([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil) {
        return d;
    }
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
}

+(void)setBool:(BOOL)v withKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:v ? @"1" : @"0" forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getIntWithKey:(NSString*)key {
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+(int)getIntWithKey:(NSString*)key withDefault:(int)d {
    if([[NSUserDefaults standardUserDefaults] objectForKey:key] == nil) {
        return d;
    }
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+(void)setInt:(int)v withKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setInteger:v forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)keyExists:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key] != nil;
}

+(BOOL)keyUndefined:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key] == nil;
}

+(BOOL)isKeyUndefinedThenDefine:(NSString*)key {
    BOOL isKeyUndefined = [UserDefaultsTool keyUndefined:key];
    if(isKeyUndefined) {
        [UserDefaultsTool setString:key withKey:key];
    }
    return isKeyUndefined;
}

- (void)removeuserDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
