//
//  NSMutableURLRequest+CMUtils.m
//  CMNetworking
//
//  Created by Wang Xuyang on 12/5/12.
//  Copyright (c) 2012 Wang Xuyang. All rights reserved.
//

#import "NSMutableURLRequest+CMUtils.h"

@implementation NSMutableURLRequest (CMUtils)

- (void)setCookieWithString:(NSString *)cookie
{
    if (self) {
        [self addValue:cookie forHTTPHeaderField:@"Cookie"];
    }
}

@end
