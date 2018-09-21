//
//  MessageGroup.m
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MessageGroup.h"

@implementation MessageGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        _rules = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rules" : [MessageRule class]};
}

- (BOOL)isMatchedForRequest:(MessageRequest *)request {
    if (self.rules) {
        for (MessageRule *rule in self.rules) {
            if ([rule isMatchedForRequest:request]) {
                return NO;
            }
        }
    }
    return  YES;
}
@end
