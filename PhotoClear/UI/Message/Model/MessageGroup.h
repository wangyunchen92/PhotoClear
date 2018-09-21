//
//  MessageGroup.h
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageRule.h"

@interface MessageGroup : NSObject
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, strong) NSMutableArray <MessageRule *> *rules;
- (BOOL)isMatchedForRequest:(MessageRequest *)request;
@end
