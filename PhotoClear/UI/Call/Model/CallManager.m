//
//  CallManage.m
//  PhotoClearCall
//
//  Created by Sj03 on 2018/9/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "CallManager.h"
#import "Model.h"

@interface CallManager ()
@property (nonatomic , strong) NSString *externsionIdentifier;

@property (nonatomic, strong) NSString *groupIdentifier;
/** 存储待写入电话号码与标识，key：号码，value：标识 **/
@property (nonatomic, strong) NSMutableArray <Model *> *dataList;
/** 带国家码的手机号 **/
@property (nonatomic, strong)NSPredicate *phoneNumberWithNationCodePredicate;
/** 不带国家码的手机号 **/
@property (nonatomic, strong) NSPredicate *phoneNumberWithoutNationCodePredicate;
/** 默认座机号 */
@property (nonatomic, strong) NSPredicate *telephoneNumeberWithoutCodePredicate;

@end


@implementation CallManager

static CallManager * manager;

+ (instancetype)shareManager {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)extensionIdentifier:(NSString *)externsionIdentifier applicationGroupIdentifier:(NSString *)groupIdentifier {
    self.externsionIdentifier = externsionIdentifier;
    self.groupIdentifier = groupIdentifier;
}

- (void)getEnableStatus:(void (^)(CXCallDirectoryEnabledStatus, NSError *))completion {
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager getEnabledStatusForExtensionWithIdentifier:self.externsionIdentifier completionHandler:^(CXCallDirectoryEnabledStatus enabledStatus, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(enabledStatus,error);
            }
        });
    }];
}

- (BOOL)addPhoneNumber:(NSString *)phoneNumber name:(NSString *)name {
    if (!phoneNumber || ![phoneNumber isKindOfClass:[NSString class]] || !name|| ![name isKindOfClass:[NSString class]]|| name.length == 0) {
        return NO;
    }
    
    NSString *handledPhoneNumber = [self handlePhoneNumber:phoneNumber];
    __block BOOL isreturn = YES;
    if (handledPhoneNumber) {
        [self.dataList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(Model * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx >=100) {
                isreturn = YES;
                *stop = YES;
            } else {
                if (obj.number == handledPhoneNumber) {
                    isreturn = NO;
                    *stop = YES;
                }
            }
        }];
        
    } else {
        handledPhoneNumber = [self handleTelePhoneNumber:phoneNumber];
        [self.dataList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(Model * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx >=100) {
                isreturn = YES;
                *stop = YES;
            } else {
                if (obj.number == handledPhoneNumber) {
                    isreturn = NO;
                    *stop = YES;
                }
            }
        }];
    }
    if (isreturn == YES) {
        Model *model = [[Model alloc] init];
        model.number =handledPhoneNumber;
        model.name = name;
        [self.dataList addObject:model];
    }
    
    return isreturn;
}

- (BOOL)reload:(void (^)(NSError * _Nullable))completion {
    if (self.dataList.count == 0) {
        return NO;
    }
    if (![self writeDataToAppGroupFile]) {
        return NO;
    }
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager reloadExtensionWithIdentifier:self.externsionIdentifier completionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                if (error.code != 0) {
                    completion(error);
                } else {
                    completion(nil);
                }
            }
        });
    }];
    return YES;
}


#pragma mark -
#pragma mark -Inner Method

- (void)clearPhoneNumber {
    [self.dataList removeAllObjects];
}

/**
 处理手机号码
 自动加上国家码，如果号码不合规返回nil
 */
- (NSString *)handlePhoneNumber:(NSString *)phoneNumber {
    if ([self.phoneNumberWithNationCodePredicate evaluateWithObject:phoneNumber]) {
        return phoneNumber;
    }
    
    if ([self.phoneNumberWithoutNationCodePredicate evaluateWithObject:phoneNumber]) {
        return [NSString stringWithFormat:@"86%@", phoneNumber];
    }
    
    return nil;
}


- (NSString *)handleTelePhoneNumber:(NSString *)telephone {
    telephone = [telephone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([self.telephoneNumeberWithoutCodePredicate evaluateWithObject:telephone]) {
        NSString *string2 = @"00";
        NSRange range1 = [telephone rangeOfString:string2];
        NSInteger location1 = range1.location;
        if (location1 == 0) {
            return nil;
        }
        
        NSString * tel = nil;
        NSString * string = @"0";
        NSRange range = [telephone rangeOfString:string];
        NSUInteger location = range.location;
        if (location == 0) {
            tel = [telephone substringFromIndex:1];
        }
        return [NSString stringWithFormat:@"86%@",tel];
    }
    return nil;
}

/**
 对dataList中的记录进行升序排序，然后转换为string
 */
- (NSString *)dataToString {
//        NSMutableArray *phoneArray = [NSMutableArray arrayWithArray:[self.dataList allKeys]];
    
//    NSMutableArray *phoneArray = [NSMutableArray array];
//    for (NSString * key in self.dataList) {
//        NSNumber * num = [NSNumber numberWithInteger:[key integerValue]];
//        [phoneArray addObject:num];
//    }
    
//    [phoneArray sortUsingSelector:@selector(compare:)];
    
    NSMutableString *dataStr = [[NSMutableString alloc] init];
    
    [self.dataList enumerateObjectsUsingBlock:^(Model * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *dicStr = [NSString stringWithFormat:@"{\"%@\":\"%@\"}\n", obj.name, obj.number];
        [dataStr appendString:dicStr];
    }];
    
//    for (NSNumber *phone in phoneArray) {
//        NSString *label = self.dataList[phone.stringValue];
//        NSString *dicStr = [NSString stringWithFormat:@"{\"%@\":\"%@\"}\n", phone, label];
//        [dataStr appendString:dicStr];
//    }
    
    return [dataStr copy];
}


- (BOOL)writeDataToAppGroupFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:self.groupIdentifier];
    containerURL = [containerURL URLByAppendingPathComponent:@"CallDirectoryData"];
    NSString * filePath = containerURL.path;
    
    if (!filePath || ![filePath isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    if([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    if (![fileManager createFileAtPath:filePath contents:nil attributes:nil]) {
        return NO;
    }
    NSLog(@"CallDirectoryDataPath - %@",filePath);
    BOOL result = [[self dataToString] writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    [self clearPhoneNumber];
    return result;
}

#pragma mark -Getter
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (NSPredicate *)phoneNumberWithNationCodePredicate {
    if (!_phoneNumberWithNationCodePredicate) {
        NSString *mobileWithNationCodeRegex = @"^861[0-9]{10}$";
        _phoneNumberWithNationCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileWithNationCodeRegex];
    }
    return _phoneNumberWithNationCodePredicate;
}

- (NSPredicate *)phoneNumberWithoutNationCodePredicate {
    if (!_phoneNumberWithoutNationCodePredicate) {
        NSString *mobileWithoutNationCodeRegex = @"^1[0-9]{10}$";
        _phoneNumberWithoutNationCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileWithoutNationCodeRegex];
    }
    return _phoneNumberWithoutNationCodePredicate;
}

- (NSPredicate *)telephoneNumeberWithoutCodePredicate {
    if (!_telephoneNumeberWithoutCodePredicate) {
        NSString * telephoneCodeRegex = @"^[0][1-9]\\d{1,2}\\d{7,8}$";
        _telephoneNumeberWithoutCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephoneCodeRegex];
    }
    
    return _telephoneNumeberWithoutCodePredicate;
}

- (BOOL)isPureNumandCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) {
        return NO;
    }
    return YES;
}


- (NSMutableArray <Model *>*)readFile {
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:AppGroupIdentifier];
    //TODO: 必须填写文件名
    containerURL = [containerURL URLByAppendingPathComponent:@"CallDirectoryData"];
    FILE *file = fopen([containerURL.path UTF8String], "r");
    char buffer[1024];
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    // 一行一行的读，避免爆内存
    while (fgets(buffer, 1024, file) != NULL) {
        @autoreleasepool {
            NSString *result = [NSString stringWithUTF8String:buffer];
            NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
            NSLog(@"%@",dic);
            if(!err && dic && [dic isKindOfClass:[NSDictionary class]]) {
                NSString *number = dic.allKeys[0];
                NSString *name = dic[number];
                if (number && [number isKindOfClass:[NSString class]] &&
                    name && [name isKindOfClass:[NSString class]]) {
                    Model *model = [[Model alloc] init];
                    model.name = name;
                    model.number = number;
                    [mutArr addObject:model];
                }
            }
            
            dic = nil;
            result = nil;
            jsonData = nil;
            err = nil;
        }
    }
    fclose(file);
    return mutArr;
}


@end
