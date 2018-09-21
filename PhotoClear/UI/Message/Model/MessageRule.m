//
//  MessageRule.m
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MessageRule.h"

@implementation MessageRule

- (BOOL)isMatchedForRequest:(MessageRequest *)request {
    NSString *target;
    switch (self.ruleTarget) {
        case MERuleTargetSender:
            target = request.sender;
            break;
        case MERuleTargetConternt:
            target = request.messageBody;
            break;
        default:
            target = request.messageBody;
            break;
    }
    if (target.length < 1) {
        return NO;
    }
    BOOL result = NO;
    switch (self.ruleType) {
        case MERuleTypeHasPrefix:
            result = [target hasPrefix:self.keyword];
            break;
        case MERuleTypeHasSuffix:
            result = [target hasSuffix:self.keyword];
            break;
        case MERuleTypeContains:
            result = [target containsString:self.keyword];
            break;
        case MERuleTypeNoContains:
            result = ![target containsString:self.keyword];
            break;
        case MERuleTypeContainsRegex:
            result = [target rangeOfString:self.keyword options:NSRegularExpressionSearch].location != NSNotFound;
            break;
        default:
            break;
    }
    return result;
}

@end
