//
//  NSString+CMUtils.m
//  wlt
//
//  Created by Wang Xuyang on 12/21/12.
//  Copyright (c) 2012 Pingan. All rights reserved.
//

#import "NSString+CMUtils.h"

@implementation NSString (CMUtils)

+ (BOOL)isBlank:(NSString *)str
{
    if (!str
        || [str isKindOfClass:[NSNull class]]
        || [str isEqualToString:@""]
        || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isEmpty:(NSString *)str
{
    if (!str
        || [str isKindOfClass:[NSNull class]]
        || [str isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)emptyOrString:(NSString *)str
{
    return [NSString isEmpty:str] ? @"" : str;
}

+ (NSString *)emptyOrStringAndTrim:(NSString *)str
{
    return [NSString isEmpty:str] ? @"" : [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)defaultValue:(NSString *)defaultStr OrString:(NSString *)str
{
    defaultStr = [NSString isEmpty:defaultStr] ? @"" : defaultStr; // default为nil就赋值为空串
    return [NSString isEmpty:str] ? defaultStr : str;
}

- (NSString *)base64String
{
    NSData *data = [NSData dataWithBytes:[self UTF8String] length:[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    NSString *retString = [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
    return retString;
}

- (NSString *)md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*)urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = (NSString *)CFBridgingRelease(encodedCFString);
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString*)urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (CFStringRef) self,
                                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                                          kCFStringEncodingUTF8);
    
    NSString *decodedString = (NSString*)CFBridgingRelease(decodedCFString);
    
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}

@end
