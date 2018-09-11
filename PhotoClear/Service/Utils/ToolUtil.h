//
//  ToolUtil.h
//  Midas
//
//  Created by BillyWang on 15/11/6.
//  Copyright © 2015年 zrt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ToolUtil : NSObject

// 根据正则表达式判定
+ (BOOL)isValidPhoneNumber:(NSString *)phone regextestString:(NSString *)regex;

// 手机格式判定最新正则表达式
+ (BOOL)isValidePhoneNumberLatest:(NSString *)mobileNum;

// 校验手机号格式是否合法，手机号11位，1开头
+ (BOOL)isValidPhoneNumber:(NSString *)string;

//判断字符串是否是整型
+ (BOOL)isPureInt:(NSString*)string;

//判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string;

//判断是否为纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string;

//判断字符串是否为纯汉字
+ (BOOL)stringIsChinese:(NSString *)chineseString;

//判断字符串是否含有汉字
+ (BOOL)stringIncludeChinese:(NSString *)string;

// 校验密码是否合法 6-12位字符串
+ (BOOL)isValidPassword:(NSString *)string;

// 校验验证码是否合法 4位字符串
+ (BOOL)isValidCode:(NSString *)string;

// 校验会议主题是否合法 30个汉字以内
+ (BOOL)isValidLiveTitle:(NSString *)string;
// 判断字符串长度 汉字为2 数字，字母为1
+ (NSInteger)getLengthMixedString:(NSString *)string;


+ (NSMutableAttributedString *)changeString:(NSString *)string lineSpace:(CGFloat )lineSpace;
+ (NSMutableAttributedString *)changeString:(NSString *)string strColor:(UIColor *)color andFont:(UIFont *)font strRange:(NSRange)range;
+ (NSMutableAttributedString *)changeString:(NSString *)string strColor:(UIColor *)color strRange:(NSRange)range;
+ (NSMutableAttributedString *)changeString:(NSString *)string strFont:(UIFont *)font strRange:(NSRange)range;
// 中英文混排汉字 长度
+ (NSInteger)getStringLength:(NSString *)string;

// 格式化时间 srcFormat-原类型 destFormat-目标类型
+ (NSString *)formatDate:(NSString *)dateTime srcFormat:(NSString *)srcFormat destFormat:(NSString *)destFormat;

// NSDate相关
+ (NSDate *)dateFormNowZero;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)getDateYMDFromTimerInterval:(NSString *)timeInterval withDateFormat:(NSString *)formatterString;

+ (NSTimeInterval)getTimeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSTimeInterval)getTimeIntervalFromString:(NSString *)fromDate toString:(NSString *)toDate;


//获取两个时间点之间的月数
+(NSInteger )getMonthsFromDateTimeInterval:(NSTimeInterval )fromDateTimeInterval toDateTimeInterval:(NSTimeInterval )toDateTimeInterval;

+(NSInteger )getMonthsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+(NSInteger )getDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

// 计算高度  根据文字和字体
+ (CGFloat)heightWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font;
// 计算宽度  根据文字和字体
+ (CGFloat)widthWithHeight:(CGFloat)height text:(NSString *)text font:(UIFont *)font;

#pragma mark - format

/**
 格式化url的参数

 @param urlString url地址
 @return url地址中的参数
 */
+ (NSDictionary *)formatURLParamsWithURLString:(NSString *)urlString;

/**
 格式化多个参数字符串为字典

 @param dataArrayString 格式化的参数
 @param elementSeparator 多个参数之间的分隔符,建议为"&"
 @param keyValueSeparator 一个键值之间的分隔符,建议为"="
 @return 返回键值字典,键值要和服务器约定好
 */
+ (NSDictionary *)formatDataArrayString:(NSString *)dataArrayString
                   WithElementSeparator:(NSString *)elementSeparator
                   AndKeyValueSeparator:(NSString *)keyValueSeparator;


//格式化发帖时间
+ (NSString *)formatArticlePostTime:(NSString *)postTime;

// 返回发帖时添加视频时间
+ (NSString *)formatVideoTime:(NSString *)string;

// 返回评论时间
+ (NSString *)formatCommunityTime:(NSString *)string;

// 当天0点数据
+ (NSTimeInterval)zeroOfDate;

// 去掉Phone中的   - ()等
+ (NSString *)trimPhone:(NSString *)string;

//判断字符串是否可用
+(BOOL)isValidURLString:(NSString *)string;

//判断字符串是否为空
+(BOOL)isStringNotEmpty:(NSString *)string;

// 自适应文字
+ (CGSize)sizeWithData:(NSString *)text font:(UIFont *)font;

// 检测去除空格 回车
+ (BOOL)checkText:(NSString *)string;

// 格式化响应数据
+ (NSString *)formatResponseString:(NSString *)string;
// 格式化网络json数据，去除所有的/r/n(回车换行)
+ (NSData *)formatResponseData:(NSData *)responseData;
// 格式化网络json数据，去除所有的/r/n(回车换行)
+ (NSData *)formatResponseStringValid:(NSString *)responseString;

// 设置行间距
+ (NSMutableAttributedString *)setLineHei:(NSString *)height width:(CGFloat)width text:(NSString *)text;

// 判断字符串首尾是否为空格
+ (BOOL)firstOrEnd:(NSString *)string;

// 本地缓存
+ (void)save:(NSDictionary *)dics fileName:(NSString *)fileName;

// 删除本地缓存
+ (void)deleteFileAtPath:(NSString *)fileName;

// 读取本地缓存
+ (NSMutableDictionary *)read:(NSString *)fileName;

// 判断banner是非符合规定
+(BOOL)isUrl:(NSString *)url;

#pragma mark - 数字精度处理
//加法
+(NSString *)decimalString:(NSString *)firstString plusString:(NSString *)secondString;
//减法
+(NSString *)decimalString:(NSString *)firstString subtractString:(NSString *)secondString;
//乘法
+(NSString *)decimalString:(NSString *)firstString multiplyString:(NSString *)secondString;
//除法
+(NSString *)decimalString:(NSString *)firstString divideString:(NSString *)secondString;
//取出字符数组中最小值
+(NSString *)minDecimalStringFrom:(NSArray *)stringArray;
//取出字符数组中最大值
+(NSString *)maxDecimalStringFrom:(NSArray *)stringArray;
//加千分位
+(NSString *) formatStringToDieTausendstel:(NSString *)doubleString;

//大于万的显示:XX万
+(NSString *) formatStringToThousand:(NSString *)doubleString;

//格式化小数到百分比
+(NSString *) formatDecimalStringToPercentage:(NSString *)decimalString;

#pragma mark - des加密

// 把一个byte数据转换为字符串
+(NSString *) parseByte2HexString:(Byte *) bytes;
// 把一个byte数组转换为字符串
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

// nsData 转16进制
+ (NSString*)stringWithHexBytes2:(NSData *)sender;

/****** 加密 ******/
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
/****** 解密 ******/
+(NSString *)decryptUseDESWithTextData:(NSData *)textData key:(NSString *)key;
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;

//+(NSString *) encryptUseDES11:(NSString *)plainText key:(NSString *)key;
//+(NSString *)decryptUseDES11:(NSString *)cipherText key:(NSString *)key;

+(NSString *)URLEncodedString:(NSString *)input;

+(NSString *)URLDecodedString:(NSString *)input;

//判断是否含有特殊字符(除字母,数字,汉字外的所有字符,删除,回车也是非法字符)
+ (BOOL)JudgeTheIllegalCharacter:(NSString *)content;
//emoji表情输入判断
+ (BOOL)stringContainsEmoji:(NSString *)string;
// 根据数字判断星座
+ (NSString *)imagetrans:(NSInteger )tag;



+ (NSDictionary *)getDivceSizeAndUserSize;

#pragma mark - webView清理缓存
+ (void)clearWebViewCache;

#pragma -mark - 格式化AttributedString,多彩宝页面，我的资产页面的总资产
+ (NSMutableAttributedString *)changeAnnualizedIncomeLabelDisplayStyle:(NSString *)value;

+ (void)getSimallImage:(PHAsset *)asset com:(void (^)(UIImage* smallimage))smallImage;
@end
