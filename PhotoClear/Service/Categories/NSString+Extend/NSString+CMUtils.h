//
//  NSString+CMUtils.h
//  wlt
//
//  Created by Wang Xuyang on 12/21/12.
//  Copyright (c) 2012 Pingan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (CMUtils)

+ (BOOL)isBlank:(NSString *)str;
+ (BOOL)isEmpty:(NSString *)str;
+ (NSString *)emptyOrString:(NSString *)str;
+ (NSString *)emptyOrStringAndTrim:(NSString *)str;
+ (NSString *)defaultValue:(NSString *)defaultStr OrString:(NSString *)str;

- (NSString *)base64String;

- (NSString *)md5String;

- (NSString *)urlEncodedString;
- (NSString *)urlDecodedString;

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options;

@end
