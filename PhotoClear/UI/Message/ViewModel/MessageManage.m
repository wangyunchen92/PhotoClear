//
//  MessageManage.m
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MessageManage.h"
#import "YYModel.h"


@implementation MessageManage

static MessageManage *manage ;

+ (instancetype )shareManage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *extdefaults = [[NSUserDefaults alloc] initWithSuiteName:MessageAppGroupName];
        NSString *ruleString = [extdefaults objectForKey:MessageRuleKey];
        manage = [MessageManage yy_modelWithJSON:ruleString];
        if (!manage) {
            manage = [[MessageManage alloc] init];
        }
    });
    return manage;
}

+ (void)regenerateShareInstance {
    NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MessageAppGroupName];
    NSString *ruleString = [extDefaults objectForKey:MessageRuleKey];
    MessageManage *newInstance = [MessageManage yy_modelWithJSON:ruleString];
    if (newInstance) {
        manage = newInstance;
    }
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"whiteGroupList" : [MessageGroup class],
             @"blackGroupList" : [MessageGroup class]
             };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _blackGroupList = [[NSMutableArray alloc] init];
        _whiteGroupList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)isUnwantedMessageForSystemQueryRequest:(ILMessageFilterQueryRequest *)systemRequest {
    
    MessageRequest *request = [[MessageRequest alloc] initWithSystemQueryRequest:systemRequest];
    
    if (self.blackGroupList) {
        for (MessageGroup *group in self.blackGroupList) {
            if ([group isMatchedForRequest:request]) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)save {
    NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MessageAppGroupName];
    NSString *ruleString = [extDefaults objectForKey:MessageRuleKey];
    ruleString = [self yy_modelToJSONString];
    if (ruleString) {
        [extDefaults setObject:ruleString forKey:MessageRuleKey];
    }
    
    return ruleString != nil;
}


- (BOOL)backupRuleToIcloud {
    NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MessageAppGroupName];
    NSString *ruleString = [extDefaults objectForKey:MessageRuleKey];
    if (ruleString) {
        NSUbiquitousKeyValueStore *icloudStore = [NSUbiquitousKeyValueStore defaultStore];
        [icloudStore setString:ruleString forKey:MessageRuleKey];
        return YES;
    }
    return NO;
}

- (BOOL)syncRuleFromIcloud {
    NSUbiquitousKeyValueStore *icloudStore = [NSUbiquitousKeyValueStore defaultStore];
    NSString *ruleString = [icloudStore objectForKey:MessageRuleKey];
    if (ruleString) {
        NSUserDefaults *extDefaults = [[NSUserDefaults alloc] initWithSuiteName:MessageAppGroupName];
        [extDefaults setObject:ruleString forKey:MessageRuleKey];
        return YES;
    }
    return NO;
}

@end
