//
//  ToolUtil.m
//  Midas
//
//  Created by BillyWang on 15/11/6.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import "ToolUtil.h"
#import <CommonCrypto/CommonCryptor.h>
#import <WebKit/WebKit.h>
#import <CocoaLumberjack/DDLogMacros.h>
#import <sys/param.h>
#import <sys/mount.h>


@implementation ToolUtil


+ (BOOL)isValidPhoneNumber:(NSString *)phone regextestString:(NSString *)regex
{
    if (!phone || phone.length != 11) {
        return NO;
    }
    if (!regex.length) {
        regex = @"^[1][34578]\\d{9}$";
    }
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextestmobile evaluateWithObject:phone];
}

+ (BOOL)isValidePhoneNumberLatest:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 校验手机号格式是否合法，手机号11位，1开头
+ (BOOL)isValidPhoneNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,181,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[23478])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,176,185,186
     */
    NSString * CU = @"^1(3[0-2]|45|5[56]|76|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,153,170,177,180,181,189
     */
    NSString * CT = @"^1((33|53|70|77|8[019])[0-9])\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)){
        return YES;
    }
    else{
        return NO;
    }
}
//判断字符串是否是整型
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否为纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }
    return YES;
}

+ (BOOL)stringIsChinese:(NSString *)chineseString{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:chineseString];
}

+ (BOOL)stringIncludeChinese:(NSString *)string{
    for(int i=0; i< [string length];i++)
    {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

//汉字为两个长度，字母，数字为一个长度
+ (NSInteger)getLengthMixedString:(NSString *)string{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [string dataUsingEncoding:enc];
    return [da length];
}

// 校验密码是否合法 6-12位字符串
+ (BOOL)isValidPassword:(NSString *)string
{
    BOOL isOk = NO;
    
    if (string && (string.length >= 6 && string.length <= 12)) {
        isOk = YES;
    }
    
    return isOk;
}

// 校验验证码是否合法 4位字符串
+ (BOOL)isValidCode:(NSString *)string
{
    BOOL isOk = NO;
    
    if (string && string.length == 4) {
        isOk = YES;
    }
    
    return isOk;
}

// 校验会议主题是否合法 30个汉字以内
+ (BOOL)isValidLiveTitle:(NSString *)string
{
    BOOL isOk = NO;
    
    if (string && string.length <= 30) {//[ToolUtil getStringLength:string] <= 3) {
        isOk = YES;
    }
    
    return isOk;
}

/**
 *  改变字符串的行间距
 *
 *  @param string     传入原始字符串
 *  @param lineSpace  传入要设置的行间距
 *
 *  @return 返回改变后的可变字符串(.attributedText = )
 */
+ (NSMutableAttributedString *)changeString:(NSString *)string lineSpace:(CGFloat )lineSpace
{
    if (!string) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    return attributedString;
}

/**
 *  改变字符串中某些字符的颜色和字体
 *
 *  @param string 传入原始字符串
 *  @param color  传入要改变的字符串的颜色
 *  @param font   传入要改变的字符串的字体
 *  @param range  传入要改变的字符串的位置
 *
 *  @return 返回改变后的可变字符串(.attributedText = )
 */
+ (NSMutableAttributedString *)changeString:(NSString *)string strColor:(UIColor *)color andFont:(UIFont *)font strRange:(NSRange)range
{
    if (!string) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:range];
    //    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:range];
    //    [attributeString addAttribute:NSFontAttributeName value:font range:range];
    return attributeString;
}

/**
 *  改变字符串中某些字符的颜色
 *
 *  @param string 传入原始字符串
 *  @param color  传入要改变的字符串的颜色
 *  @param range  传入要改变的字符串的位置
 *
 *  @return 返回改变后的可变字符串(.attributedText = )
 */
+ (NSMutableAttributedString *)changeString:(NSString *)string strColor:(UIColor *)color strRange:(NSRange)range
{
    if (!string) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributeString;
}
/**
 *  改变字符串中某些字符的字体
 *
 *  @param string 传入原始字符串
 *  @param font   传入要改变的字符串的字体
 *  @param range  传入要改变的字符串的位置
 *
 *  @return 返回改变后的可变字符串(.attributedText = )
 */
+ (NSMutableAttributedString *)changeString:(NSString *)string strFont:(UIFont *)font strRange:(NSRange)range
{
    if (!string) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttribute:NSFontAttributeName value:font range:range];
    return attributeString;
}


// 中英文混排汉字 长度
+ (NSInteger)getStringLength:(NSString *)string
{
    int strlength = 0;
    char *p = (char *)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

// 格式化时间 srcFormat-原类型 destFormat-目标类型
+ (NSString *)formatDate:(NSString *)dateTime srcFormat:(NSString *)srcFormat destFormat:(NSString *)destFormat
{
    if (dateTime == nil) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:srcFormat];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    NSDate *curDataTime = [formatter dateFromString:dateTime];
    
    [formatter setDateFormat:destFormat];
    NSString *formatDate = [formatter stringFromDate:curDataTime];
    
    return formatDate;
}

+ (NSDate *)dateFormNowZero {
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    return dateNow;
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    if (date == nil) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

/**
 *  根据传入格式,转换时间格式
 *
 *  @param timeInterval    时间戳(服务器时间)
 *  @param formatterString 要转换的时间格式
 *
 *  @return 转换后的时间格式
 */
+ (NSString *)getDateYMDFromTimerInterval:(NSString *)timeInterval withDateFormat:(NSString *)formatterString
{
    //服务器时间戳与APP时间戳不一致
    NSDate *rightDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval floatValue]/1000];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterString];
    NSString * dateStr = [dateFormatter stringFromDate:rightDate];
    return dateStr;
}

//获取2个日期间的时间间隔，返回多少秒
+ (NSTimeInterval)getTimeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if(fromDate && toDate)
        return [toDate timeIntervalSinceDate:fromDate];
    else
        return 0;
}

+ (NSTimeInterval)getTimeIntervalFromString:(NSString *)fromDate toString:(NSString *)toDate
{
    if([self dateFromString:fromDate] || [self dateFromString:toDate])
        return 0;
    return [self getTimeIntervalFromDate:[self dateFromString:fromDate] toDate:[self dateFromString:toDate]];
}


+(NSInteger )getMonthsFromDateTimeInterval:(NSTimeInterval)fromDateTimeInterval toDateTimeInterval:(NSTimeInterval)toDateTimeInterval
{
    NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:fromDateTimeInterval];
    NSDate *toDate = [NSDate dateWithTimeIntervalSince1970:toDateTimeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *fromDateString = [dateFormatter stringFromDate:fromDate];
    NSArray *fromDateArray = [fromDateString componentsSeparatedByString:@"-"];
    NSString *toDateString = [dateFormatter stringFromDate:toDate];
    NSArray *toDateArray = [toDateString componentsSeparatedByString:@"-"];
    
    NSInteger yearsInterval = [[toDateArray firstObject] integerValue] - [[fromDateArray firstObject] integerValue];
    NSInteger monthsInterval = [[toDateArray lastObject] integerValue] - [[fromDateArray lastObject] integerValue];
    
    NSInteger months = yearsInterval *12+monthsInterval;
    NSLog(@"month=%ld",(long)months);
    return months;
}

+(NSInteger )getMonthsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:toDate options:0];
    NSInteger months = [components month];
//    NSInteger days = [components day];//年[components year]
    NSLog(@"month=%ld",(long)months);
//    NSLog(@"days=%ld",(long)days);
    return months;
}

+(NSInteger )getDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:toDate options:0];
    NSInteger days = [components day];
    //    NSInteger days = [components day];//年[components year]
    NSLog(@"month=%ld",(long)days);
    //    NSLog(@"days=%ld",(long)days);
    return days;
}

+ (CGFloat)heightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
    CGFloat height = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    if (text && text.length > 0) {
        
        height = [text boundingRectWithSize:CGSizeMake(width, 0)
                                    options:\
                  NSStringDrawingTruncatesLastVisibleLine |
                  NSStringDrawingUsesLineFragmentOrigin |
                  NSStringDrawingUsesFontLeading
                                 attributes:attribute
                                    context:nil].size.height;
    }
    return height;
}


+ (CGFloat)widthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font
{
    CGFloat width = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    if (text && text.length > 0) {
        
        width = [text boundingRectWithSize:CGSizeMake(0, height)
                                   options:\
                 NSStringDrawingTruncatesLastVisibleLine |
                 NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading
                                attributes:attribute
                                   context:nil].size.width;
    }
    return width;
}

// 返回评论时间
+ (NSString *)formatCommunityTime:(NSString *)string
{
    if (string == nil || string.length == 0) {
        return string;
    }
//    string = [NSString stringWithFormat:@"%ld",[string integerValue]];  // 此处不用转换， 就算转换 也要用，longlongvalue，否则iphone5等低端机 会精度损失
    NSString *ret = nil;
    // 入参为 毫秒数
    NSTimeInterval temp = [string doubleValue] / 1000;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval today0 = [ToolUtil zeroOfDate];
    
    double diff = now - temp ;
    
    if (diff <= 5) {
        // 刚刚更新 - 5秒内
        ret = @"刚刚更新";
    } else if (diff <= 59) {
        // %n秒前   - 59秒内
        ret = [NSString stringWithFormat:@"%.0f秒前", diff];
    } else if (diff <= 59 * 60) {
        // %n分钟前  - 59分内
        ret = [NSString stringWithFormat:@"%.0f分钟前", diff / 60];
    } else {
        // 今天 hh:mm  - 1小时后，今天以内   :    mm-dd hh:mm  - 今天之前
        NSString *formater = temp > today0 ? @"今天 HH:mm" : @"MM-dd HH:mm";
        ret = [ToolUtil stringFromDate:[NSDate dateWithTimeIntervalSince1970:temp] format:formater];
    }
    
    return ret;
}
#pragma mark - format

+ (NSDictionary *)formatURLParamsWithURLString:(NSString *)urlString
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([ToolUtil isUrl:urlString]) {
        NSURLComponents *URLComponents = [NSURLComponents componentsWithString:urlString];
        NSArray *URLqueryItems = URLComponents.queryItems;
        if (URLComponents && URLqueryItems.count >0) {
            for (NSURLQueryItem *item in URLqueryItems) {
                [mutableDict setObject:item.value forKey:item.name];
            }
        }
    }
    return mutableDict;
}

+ (NSDictionary *)formatDataArrayString:(NSString *)dataArrayString
                   WithElementSeparator:(NSString *)elementSeparator
                   AndKeyValueSeparator:(NSString *)keyValueSeparator
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithCapacity:0];
    if([dataArrayString containsString:elementSeparator] || [elementSeparator isEqualToString:@""]){
        NSArray *dataArray = [dataArrayString componentsSeparatedByString:elementSeparator];
        if(dataArray && dataArray.count >0){
            for (NSString *keyValueString in dataArray) {
                NSArray *keyValueArray = [keyValueString componentsSeparatedByString:keyValueSeparator];
                if(keyValueArray && keyValueArray.count >=2){
                    NSString *keyString = [keyValueArray firstObject];
                    NSString *valueString = [keyValueArray lastObject];
                    if(keyString && valueString){
                        [mutableDict setObject:valueString forKey:keyString];
                    }
                }
            }
        }
    }
    return mutableDict;
}

+ (NSString *)formatArticlePostTime:(NSString *)postTime
{
    NSString *ret = @"";
    if (postTime == nil || postTime.length == 0) {
        return ret;
    }
    // 入参为 毫秒数
    NSTimeInterval temp = [postTime doubleValue] / 1000;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval today0 = [ToolUtil zeroOfDate];
    NSTimeInterval yesterday0 = today0-24*60*60;

    double diff = now - temp;
    if(temp > today0){
        //今天的
        if(diff < 60){
            // 1分钟前
            ret = @"刚刚";
        }else if(diff < 60*60){
            // %n分钟前
            ret = [NSString stringWithFormat:@"%.0f分钟前", diff / 60];
        }else{
            // %n小时前(1.51小时,向下取整,5856)
            ret = [NSString stringWithFormat:@"%.0f小时前", floor(diff / (60*60))];
        }
    }else if (yesterday0 < temp){
        //发布时间落在昨天的某个时刻,显示昨天
        ret = @"昨天";
    }else{
        // 显示“MM月DD日”
        NSString *formater = @"MM月dd日";
        ret = [ToolUtil stringFromDate:[NSDate dateWithTimeIntervalSince1970:temp] format:formater];
    }
    return ret;
}
// 返回发帖时添加视频时间
+ (NSString *)formatVideoTime:(NSString *)string
{
    if (string == nil || string.length == 0) {
        return string;
    }
    string = [NSString stringWithFormat:@"%ld",(long)[string integerValue]];
    NSString *ret = nil;
    // 入参为 毫秒数
    NSTimeInterval temp = [string doubleValue] / 1000;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    double diff = now - temp ;
    
    if (diff > 60 * 60 * 24 * 2) {
        // 刚刚更新 - 5秒内
        NSString *formater = @"MM-dd";
        ret = [ToolUtil stringFromDate:[NSDate dateWithTimeIntervalSince1970:temp] format:formater];
    } else if (diff < 60 * 60 * 24) {
        // %n秒前   - 59秒内
        NSString *formater = @"HH:mm";
        ret = [ToolUtil stringFromDate:[NSDate dateWithTimeIntervalSince1970:temp] format:formater];
    } else {
        
        ret = @"昨天";
    }
    
    return ret;
}


// 当天0点数据
+ (NSTimeInterval)zeroOfDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return ts;
}

// 去掉Phone中的   - ()等
+ (NSString *)trimPhone:(NSString *)string
{
    NSString *temp = string;
    
    temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"-" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"(" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return temp;
}

+(BOOL)isValidURLString:(NSString *)string
{
    return string && string.length >0;
}

+(BOOL)isStringNotEmpty:(NSString *)string
{
    return string && ![string isEqualToString:@""];
}

// 自适应文字
+ (CGSize)sizeWithData:(NSString *)text font:(UIFont *)font
{
    CGSize size = CGSizeMake(kScreenWidth, kScreenHeight);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size;
}

// 检测去除空格 回车
+ (BOOL)checkText:(NSString *)string
{
    NSString *realSre = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (realSre3.length == 0) {
        return NO;
    } else {
        return YES;
    }
}

// 格式化响应数据
+ (NSString *)formatResponseString:(NSString *)string {
    NSString *str = string;
    if (str) {
        str = [str stringByReplacingOccurrencesOfString:@",{\"\":\"\"}" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"{\"\":\"\"}," withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"{\"\":\"\"}" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@",\"\":\"\"" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\"\":\"\"," withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\"\":\"\"" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@",{}" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"{}," withString:@""];
    }
    return str;
}

// 格式化网络json数据，去除所有的/r/n(回车换行)
+ (NSData *)formatResponseData:(NSData *)responseObject
{
    NSString *responseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    // 后台确认去除前段转义字符的过滤功能。
//    responseString = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return [responseString dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSData *)formatResponseStringValid:(NSString *)responseString
{
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return [responseString dataUsingEncoding:NSUTF8StringEncoding];
}

// 设置行间距
+ (NSMutableAttributedString *)setLineHei:(NSString *)height width:(CGFloat)width text:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:[height integerValue]];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    
    return attributedString;
}

// 判断字符串首尾是否为空格
+ (BOOL)firstOrEnd:(NSString *)string
{
    NSString *firstStr=[string substringWithRange:NSMakeRange(0, 1)];
    NSInteger length = [string length];
    NSString *endStr = [string substringWithRange:NSMakeRange(length - 1, 1)];
    
    if ([firstStr isEqualToString:@" "] || [endStr isEqualToString:@" "]) {
        return YES;
    } else {
        return NO;
    }
}

// 本地缓存
+ (void)save:(NSDictionary *)dics fileName:(NSString *)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString* plistPath = [docDir stringByAppendingPathComponent:fileName];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:plistPath contents:nil attributes:nil];
//    NSLog(@"%@", plistPath);
    [dics writeToFile:plistPath atomically:YES];
}

// 删除本地缓存
+ (void)deleteFileAtPath:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *MapLayerDataPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath];
    if (bRet) {
        //
        NSError *err;
        [fileMgr removeItemAtPath:MapLayerDataPath error:&err];
    }
    
}


// 读取本地缓存
+ (NSMutableDictionary *)read:(NSString *)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString* plistPath = [docDir stringByAppendingPathComponent:fileName];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return tempDic;
}

+(BOOL)isUrl:(NSString *)url
{
    if(!url){
        return NO;
    }
    NSString * URLpattern = @"^(http|https|colorfulfound|colorfulfund)://";
    
    NSError *error = NULL;
    NSRegularExpression *URLregex = [NSRegularExpression regularExpressionWithPattern:URLpattern
                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                error: &error];
    
    NSUInteger numberOfMatches = [URLregex numberOfMatchesInString:url
                                                           options:0
                                                             range:NSMakeRange(0, [url length])];
    if (numberOfMatches == 0) {
        return NO;
    }
    
    NSURL *URL = [NSURL URLWithString:url];
    if(!URL){
        return NO;
    }
    
    return YES;
}

//加法
+(NSString *)decimalString:(NSString *)firstString plusString:(NSString *)secondString
{
    //保留小数点后2位,NSRoundBankers四舍五入
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *firstDecimalNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *secondDecimalNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultDecimalNumber = [firstDecimalNumber decimalNumberByAdding:secondDecimalNumber withBehavior:decimalNumberHandler];

    NSString *resultDecimalString = [resultDecimalNumber stringValue];
    if ([resultDecimalString rangeOfString:@"."].location == NSNotFound) {
        return [NSString stringWithFormat:@"%@.00",resultDecimalString];
    }
    NSArray *array = [resultDecimalString componentsSeparatedByString:@"."];
    NSString *lastString = [array lastObject];
    //".x"
    if(lastString.length ==1){
        return [NSString stringWithFormat:@"%@0",resultDecimalString];
    }
    
    return resultDecimalString;
}

//减法
+(NSString *)decimalString:(NSString *)firstString subtractString:(NSString *)secondString
{
    //保留小数点后2位,NSRoundBankers四舍五入
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *firstDecimalNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *secondDecimalNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultDecimalNumber = [firstDecimalNumber decimalNumberBySubtracting:secondDecimalNumber withBehavior:decimalNumberHandler];

    NSString *resultDecimalString = [resultDecimalNumber stringValue];
    if ([resultDecimalString rangeOfString:@"."].location == NSNotFound) {
        return [NSString stringWithFormat:@"%@.00",resultDecimalString];
    }
    NSArray *array = [resultDecimalString componentsSeparatedByString:@"."];
    NSString *lastString = [array lastObject];
    //".x"
    if(lastString.length ==1){
        return [NSString stringWithFormat:@"%@0",resultDecimalString];
    }
    
    return resultDecimalString;
}

//乘法
+(NSString *)decimalString:(NSString *)firstString multiplyString:(NSString *)secondString
{
    //保留小数点后2位,NSRoundBankers四舍五入
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *firstDecimalNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *secondDecimalNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultDecimalNumber = [firstDecimalNumber decimalNumberByMultiplyingBy:secondDecimalNumber withBehavior:decimalNumberHandler];

    NSString *resultDecimalString = [resultDecimalNumber stringValue];
    if ([resultDecimalString rangeOfString:@"."].location == NSNotFound) {
        return [NSString stringWithFormat:@"%@.00",resultDecimalString];
    }
    NSArray *array = [resultDecimalString componentsSeparatedByString:@"."];
    NSString *lastString = [array lastObject];
    //".x"
    if(lastString.length ==1){
        return [NSString stringWithFormat:@"%@0",resultDecimalString];
    }
    
    return resultDecimalString;
}

//除法
+(NSString *)decimalString:(NSString *)firstString divideString:(NSString *)secondString
{
    //保留小数点后2位,NSRoundBankers四舍五入
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *firstDecimalNumber = [NSDecimalNumber decimalNumberWithString:firstString];
    NSDecimalNumber *secondDecimalNumber = [NSDecimalNumber decimalNumberWithString:secondString];
    NSDecimalNumber *resultDecimalNumber = [firstDecimalNumber decimalNumberByDividingBy:secondDecimalNumber withBehavior:decimalNumberHandler];
    
    NSString *resultDecimalString = [resultDecimalNumber stringValue];
    if ([resultDecimalString rangeOfString:@"."].location == NSNotFound) {
        return [NSString stringWithFormat:@"%@.00",resultDecimalString];
    }
    NSArray *array = [resultDecimalString componentsSeparatedByString:@"."];
    NSString *lastString = [array lastObject];
    //".x"
    if(lastString.length ==1){
        return [NSString stringWithFormat:@"%@0",resultDecimalString];
    }
    
    return resultDecimalString;
}

+(NSString *)minDecimalStringFrom:(NSArray *)stringArray
{
    NSString *temp = @"0";
    if (stringArray && stringArray.count >0){
        // 遍历比较
        temp = stringArray[0];
        for (NSString *str in stringArray) {
            NSComparisonResult result = [[NSDecimalNumber decimalNumberWithString:temp] compare:[NSDecimalNumber decimalNumberWithString:str]];
            if (result > NSOrderedSame) {
                temp = str;
            }
        }
    }
    return temp;
}

+(NSString *)maxDecimalStringFrom:(NSArray *)stringArray
{
    NSString *temp = @"0";
    if (stringArray && stringArray.count >0){
        // 遍历比较
        temp = stringArray[0];
        for (NSString *str in stringArray) {
            NSComparisonResult result = [[NSDecimalNumber decimalNumberWithString:temp] compare:[NSDecimalNumber decimalNumberWithString:str]];
            if (result < NSOrderedSame) {
                temp = str;
            }
        }
    }
    return temp;
}

+(NSString *) formatStringToDieTausendstel:(NSString *)doubleString
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:[doubleString doubleValue]]];
    if ([newAmount rangeOfString:@"."].location == NSNotFound) {
        return [NSString stringWithFormat:@"%@.00",newAmount];
    }
    NSArray *array = [newAmount componentsSeparatedByString:@"."];
    NSString *lastString = [array lastObject];
    //".x"
    if(lastString.length ==1){
        return [NSString stringWithFormat:@"%@0",newAmount];
    }
    return newAmount;
}

+(NSString *) formatStringToThousand:(NSString *)doubleString
{
    NSString *formatString  = [self decimalString:doubleString plusString:@"0"];
    if([doubleString doubleValue] >10000.0f){
        formatString = [NSString stringWithFormat:@"%.2f万",[doubleString doubleValue]/10000.0f];
        return formatString;
    }
    return [NSString stringWithFormat:@"%.2f",[formatString doubleValue]];
}

+(NSString *) formatDecimalStringToPercentage:(NSString *)decimalString
{
    return [NSString stringWithFormat:@"%.2f%%",[decimalString doubleValue] *100];
}

#pragma mark - DES_Mothed
/******************************************************************************
 函数描述 : 文本数据进行DES加密
 ******************************************************************************/
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCBlockSizeDES,
                                          NULL,
                                          [textData bytes]  , dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES加密成功");
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        
//        ciphertext = [self stringWithHexBytes2:data];
        
    }else{
        NSLog(@"DES加密失败");
    }
    
    free(buffer);
    return ciphertext;
}

//textData
+(NSString *)decryptUseDESWithTextData:(NSData *)textData key:(NSString *)key
{
    NSString *cleartext = nil;
    //    [self parseHexToByteArray:plainText];
    NSUInteger dataLength = [textData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          NULL,
                                          [textData bytes]  , dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES解密成功");
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        cleartext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"DES解密失败");
    }
    
    free(buffer);
    return cleartext;
}

/******************************************************************************
 函数描述 : 文本数据进行DES解密
 ******************************************************************************/
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *cleartext = nil;
    NSData *textData = [self parseHexToByteArray:plainText];
    NSUInteger dataLength = [textData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          NULL,
                                          [textData bytes]  , dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES解密成功");
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        cleartext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"DES解密失败");
    }
    
    free(buffer);
    return cleartext;
}

//nsdata转成16进制字符串
+ (NSString*)stringWithHexBytes2:(NSData *)sender {
    static const char hexdigits[] = "0123456789ABCDEF";
    const size_t numBytes = [sender length];
    const unsigned char* bytes = [sender bytes];
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    
    for (int i = 0; i<numBytes; ++i) {
        const unsigned char c = *bytes++;
        *hex++ = hexdigits[(c >> 4) & 0xF];
        *hex++ = hexdigits[(c ) & 0xF];
    }
    
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    
    free(strbuf);
    return hexBytes;
}


/*
 将16进制数据转化成NSData 数组
 */
+(NSData*) parseHexToByteArray:(NSString*) hexString
{
    int j=0;
    Byte bytes[hexString.length];
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
    return newData;
}

+(NSString *) parseByte2HexString:(Byte *) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    return hexStr;
}

+(NSString *) parseByteArray2HexString:(Byte[]) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    return [hexStr uppercaseString];
}


/*const Byte iv[] = {1,2,3,4,5,6,7,8};
+(NSString *) encryptUseDES11:(NSString *)plainText key:(NSString *)key
{
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    size_t numBytesEncrypted = 0;
//    
//    
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          [key UTF8String], kCCKeySizeDES,
//                                          NULL,
//                                          [textData bytes]  , dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
  
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCBlockSizeDES,
                                          NULL,
                                          [textData bytes]  , dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
//    NSString *ciphertext = nil;
//    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [textData length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    unsigned char buffer[102400];
//    memset(buffer, 0, sizeof(char));
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding,
//                                          [key UTF8String], kCCKeySizeDES,
//                                          NULL,
//                                          [textData bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return ciphertext;
}

+(NSString *)decryptUseDES11:(NSString *)cipherText key:(NSString *)key
{
    NSString *plaintext = nil;
    NSData *cipherdata = [cipherText dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}*/

////判断字符串中是否包含emoji表情
//+ (BOOL)stringContainsEmoji:(NSString *)string{
//    
//    __block BOOL returnValue = NO;
//    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
//     
//                               options:NSStringEnumerationByComposedCharacterSequences
//     
//                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//                                
//                                const unichar hs = [substring characterAtIndex:0];
//                                
//                                if (0xd800 <= hs && hs <= 0xdbff) {
//                                    
//                                    if (substring.length > 1) {
//                                        
//                                        const unichar ls = [substring characterAtIndex:1];
//                                        
//                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//                                        
//                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
//                                            
//                                            returnValue = YES;
//                                            
//                                        }
//                                        
//                                    }
//                                    
//                                } else if (substring.length > 1) {
//                                    
//                                    const unichar ls = [substring characterAtIndex:1];
//                                    
//                                    if (ls == 0x20e3) {
//                                        
//                                        returnValue = YES;
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                } else {
//                                    
//                                    if (0x2100 <= hs && hs <= 0x27ff) {
//                                        
//                                        returnValue = YES;
//                                        
//                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
//                                        
//                                        returnValue = YES;
//                                        
//                                    } else if (0x2934 <= hs && hs <= 0x2935) {
//                                        
//                                        returnValue = YES;
//                                        
//                                    } else if (0x3297 <= hs && hs <= 0x3299) {
//                                        
//                                        returnValue = YES;
//                                        
//                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
//                                        
//                                        returnValue = YES;
//                                        
//                                    }else if (hs == 0x200d){
//                                        
//                                        returnValue = YES;
//                                        
//                                    }
//                                    
//                                }
//                                
//                            }];
//    return returnValue;
//    
//}

+(NSString *)URLEncodedString:(NSString *)input
{
    NSString *encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return encodedString;
}

+(NSString *)URLDecodedString:(NSString *)input
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)input, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

+ (BOOL)JudgeTheIllegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *illegalCharacterPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![illegalCharacterPredicate evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


+ (void)clearWebViewCache {
    if (kIOSVersions >= 9.0) {
        // 9.0之后才有的
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

+ (NSMutableAttributedString *)changeAnnualizedIncomeLabelDisplayStyle:(NSString *)value {
    NSString *poTotalAssets = [ToolUtil formatStringToDieTausendstel:value];
    NSString *investInfo  = [NSString stringWithFormat:@"%@",poTotalAssets];
    //    @"基金总值: ¥12,000.00";
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:investInfo attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:30.0f]} range:NSMakeRange(0, investInfo.length)];
    return attributeStr;
}

+ (NSString *)imagetrans:(NSInteger )tag {
    NSString *str;
    switch (tag) {
        case 1:
            str = @"水瓶座";
            break;
        case 2:
            str = @"双鱼座";
            break;
        case 3:
            str = @"白羊座";
            break;
        case 4:
            str = @"金牛座";
            break;
        case 5:
            str = @"双子座";
            break;
        case 6:
            str = @"巨蟹座";
            break;
        case 7:
            str = @"狮子座";
            break;
        case 8:
            str = @"处女座";
            break;
        case 9:
            str = @"天秤座";
            break;
        case 10:
            str = @"天蝎座";
            break;
        case 11:
            str = @"射手座";
            break;
        case 12:
            str = @"摩羯座";
            break;
        default:
            break;
    }
    return str;
}

+ (BOOL)isfristDateLogin {
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    dateformate.dateFormat = @"yyyy-MM-dd";
    if (![[UserDefaultsTool getStringWithKey:LoginDate] isEqualToString:@""] ) {
        NSString *datestring = [UserDefaultsTool getStringWithKey:LoginDate];
        
        NSDate *date1 = [dateformate dateFromString:datestring];
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSTimeInterval seconds = [zone secondsFromGMTForDate:date];
        NSDate *nowDate = [date dateByAddingTimeInterval:seconds];
        
        NSString *nowstring = [dateformate stringFromDate:nowDate];
        if (![self isSameDay:date1 date2:nowDate]) {
            [UserDefaultsTool setString:nowstring withKey:LoginDate];
            [UserDefaultsTool setBool:YES withKey:isFirstLogin];

            return YES;
        }else {
            [UserDefaultsTool setBool:NO withKey:isFirstLogin];
            return NO;
        }
    } else {
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSTimeInterval seconds = [zone secondsFromGMTForDate:date];
        NSDate *nowDate = [date dateByAddingTimeInterval:seconds];
        NSString *nowstring = [dateformate stringFromDate:nowDate];
        [UserDefaultsTool setString:nowstring withKey:LoginDate];
        [UserDefaultsTool setBool:YES withKey:isFirstLogin];

        return YES;
    }
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


+ (NSDictionary *)getDivceSizeAndUserSize {

    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    //总空间
    float   space     =   [[fattributes objectForKey:NSFileSystemSize] floatValue];
    //所剩空间
    float   freespace =   [[fattributes objectForKey:NSFileSystemFreeSize] floatValue];
    
    
    float free_m  =  freespace / 1024 / 1024 / 1024;
    float space_m =  space / 1024 / 1024 / 1024;
    float proportion = (space_m - free_m) / space_m;

    
    NSString * userStr = [NSString stringWithFormat:@"%0.2f",(space_m - free_m)];

    NSString * allStr = [NSString stringWithFormat:@"%0.2f",space_m];
    NSString * proportionStr = [NSString stringWithFormat:@"%.0f",proportion*100];
    

    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userStr,@"userSize",allStr,@"allSize",proportionStr,@"canuser", nil];

    return dic;
}
+ (void)getSimallImage:(PHAsset *)asset com:(void (^)(UIImage* smallimage))smallImage {
    // 获取缩率图
    
    PHImageRequestOptions *imageOpt = [[PHImageRequestOptions alloc] init];
    // resizeMode 属性控制图像的剪裁
    imageOpt.resizeMode = PHImageRequestOptionsResizeModeNone;
    // deliveryMode 则用于控制请求的图片质量
    imageOpt.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    PHImageManager *mgr = [PHImageManager defaultManager];
    __block UIImage *image;
    
    [mgr requestImageForAsset:asset
                   targetSize:CGSizeMake(125, 125)
                  contentMode:PHImageContentModeDefault
                      options:imageOpt
                resultHandler:^(UIImage *result, NSDictionary *info) {
                    smallImage(image);
                }];
}


@end
