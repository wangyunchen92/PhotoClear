//
//  MessageRule.h
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageRequest.h"

typedef NS_ENUM(NSInteger, MERuleTarget) {
    MERuleTargetSender = 0,
    MERuleTargetConternt
};

typedef NS_ENUM(NSInteger, MERuleType) {
    MERuleTypeHasPrefix = 0, // 前缀
    MERuleTypeHasSuffix, // 后缀
    MERuleTypeContains, // 包含
    MERuleTypeNoContains,// 不包含
    MERuleTypeContainsRegex, // 正则表达
};

@interface MessageRule : NSObject

@property (nonatomic, assign)MERuleTarget ruleTarget;
@property (nonatomic, assign)MERuleType ruleType;
@property (nonatomic, copy) NSString *keyword;

- (BOOL)isMatchedForRequest:(MessageRequest *)request;

@end
