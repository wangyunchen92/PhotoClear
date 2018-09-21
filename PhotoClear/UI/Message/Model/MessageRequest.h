//
//  MessageRequest.h
//  PhotoClear
//
//  Created by Sj03 on 2018/9/14.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IdentityLookup/IdentityLookup.h>

@interface MessageRequest : NSObject

@property (nonatomic, readonly, nullable) NSString *sender;
@property (nonatomic, readonly, nullable) NSString *messageBody;

- (instancetype _Nonnull)initWithSystemQueryRequest:(ILMessageFilterQueryRequest *_Nonnull)request API_AVAILABLE(ios(11.0));

- (instancetype _Nonnull)initWithSender:(NSString *_Nullable)sender messageBody:(NSString *_Nullable)messageBody;
@end
