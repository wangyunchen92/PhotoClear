//
//  MessageRequest.m
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MessageRequest.h"

@implementation MessageRequest
- (instancetype)initWithSystemQueryRequest:(ILMessageFilterQueryRequest *)request {
    self = [super init];
    if (self) {
        _sender = request.sender;
        _messageBody = request.messageBody;
    }
    return self;
}

- (instancetype _Nonnull)initWithSender:(NSString *_Nullable)sender messageBody:(NSString *_Nullable)messageBody {
    self = [super init];
    if (self) {
        _sender = sender;
        _messageBody = messageBody;
    }
    return self;
}
@end
