//
//  MessageManage.h
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageGroup.h"

static NSString *MessageAppGroupName = @"group.PhotoClearGroup";
static NSString *MessageRuleKey = @"MJExtentsionRuleKey";

@interface MessageManage : NSObject

@property (nonatomic, strong) NSMutableArray<MessageGroup *> *whiteGroupList;

@property (nonatomic, strong) NSMutableArray <MessageGroup *> *blackGroupList;

+ (instancetype)shareManage;
+ (void)regenerateShareInstance;

- (BOOL)isUnwantedMessageForSystemQueryRequest:(ILMessageFilterQueryRequest *)systemRequest;

- (BOOL)save;

- (BOOL)backupRuleToIcloud;
- (BOOL)syncRuleFromIcloud;

@end
