//
//  HttpResponse.m
//  XLAFNetworking
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 along. All rights reserved.
//

#import "HttpResponse.h"
#import "LoginViewController.h"
//#import "YMUpdateView.h"


@interface HttpResponse () 
@end

@implementation HttpResponse

#pragma mark 响应返回数据处理

/**
 *  响应返回数据处理
 *
 *  @param ObjectData 解析数据
 */
- (void)loadResopnseWithObjectData:(NSDictionary *)objectData {
        
    _objectData = objectData;
    
    //数据解析
    
    _isSuccess = NO;
    
    if(objectData == nil) {
        _errorMsg = DATA_FORMAT_ERROR;
        return;
    }
    
    NSString *code = [self checkString:objectData[@"code"]];
    NSString *message = [self checkString:objectData[@"msg"]];
   // DLOG(@"最原始解析出来的jsonData == %@",objectData);
    id object = objectData[@"data"];
    //code = @"301";
    //token异常
//    if ([code isEqualToString:CODE_TOKEN_ABNORMAL]) {
//        [[UserInfo shareInstance] removeAllDate];
//        _isSuccess = NO;
//        LoginViewController *loginVC = [[LoginViewController alloc]init];
//        [[BackgroundViewController share] showLoginViewController:loginVC animated:NO completion:^{
//            
//        }];
//    }
    //强制更新
//    if ([code isEqualToString:CODE_UPDATE]) {
//        YMUpdateView *updateView = [[YMUpdateView alloc] initWithTitle:nil imgStr:@"发现新版本" message:[NSString stringWithFormat:@"为了给您提供更优质的服务，旧版app已停止服务。请更新至最新版本。"] sureBtn:@"立即更新版本" cancleBtn:nil];
//        //__weak YMUpdateView* weakUpdateView = updateView;
//        updateView.resultIndex = ^(NSInteger index){
//            //回调---处理一系列动作
//            if (![ToolUtil isNull:objectData]) {
//                if ([[objectData objectForKey:@"data"] isKindOfClass:[NSString class]]) {
//
//                    NSString* urlStr = [objectData objectForKey:@"data"];
//                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//                    }
//                }else{
//                   // [weakUpdateView removeFromSuperview];
//                    NSLog(@"版本升级链接有误！");
//                }
//            }else{
//                //[weakUpdateView removeFromSuperview];
//                NSLog(@"版本升级链接有误！");
//            }
//        };
//        [updateView showXLAlertView];
//        _isSuccess = NO;
//        _errorMsg = @"强制更新";
//        return;
//    }
    //请求成功
    if ([code isEqualToString:CODE_SUCCESS]) {
        _isSuccess = YES;
    }else{
        _errorCode = code;
        _isSuccess = NO;
    }
    
    if (_isSuccess == NO && message == nil ) {
        _errorMsg = DATA_FORMAT_ERROR;
        return;
    }
    
    if (_isSuccess == YES && object == nil) {
        _errorMsg = DATA_FORMAT_ERROR;
        return;
    }
    
    if(_isSuccess == NO && message) {
        _errorMsg = message;
        return;
    }
    
    NSDictionary *result = object;
    
    if ([result isKindOfClass:[NSDictionary class]]) {
        _isSuccess = YES;
        _result = result;
    }
    else if ([result isKindOfClass:[NSArray class]]){
        _isSuccess = YES;
        _result = [NSDictionary dictionaryWithObject:result forKey:@"object"];
    }else if(result != nil){
        _result = [NSDictionary dictionaryWithObject:result forKey:@"object"];
    }
    else{
        _isSuccess = NO;
        //_result = [NSDictionary dictionaryWithObject:result forKey:@"object"];
        _errorMsg = DATA_FORMAT_ERROR;
    }
}

- (NSString *)checkString:(id)str {
    if([str isKindOfClass:[NSString class]]) {
        return str;
    } else {
        if ([str isKindOfClass:[NSNull class]]) {
            return @"";
        } else {
            return [str stringValue];
        }
    }
}

#pragma mark setProperty
- (void)setResponseName:(NSString *)responseName {
    if(![responseName isEqualToString:@""] && responseName) {
        _responseName = responseName;
    }else {
        _responseName = @"";
    }
}

- (void)setErrorCode:(NSString *)errorCode {
    if(![errorCode isEqualToString:@""] && errorCode) {
        _errorCode = errorCode;
    }else {
        _errorCode = @"无";
    }
}

- (void)setErrorMsg:(NSString *)errorMsg {
    if(![errorMsg isEqualToString:@""] && errorMsg) {
        _errorMsg = errorMsg;
    }else {
        _errorMsg = @"无";
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.responseName = [aDecoder decodeObjectForKey:@"name"];
        self.errorCode = [aDecoder decodeObjectForKey:@"errorCode"];
        self.errorMsg = [aDecoder decodeObjectForKey:@"errorMsg"];
        self.objectData = [aDecoder decodeObjectForKey:@"objectData"];
        self.result = [aDecoder decodeObjectForKey:@"result"];
        self.httpError = [aDecoder decodeObjectForKey:@"httpError"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.responseName forKey:@"name"];
    [aCoder encodeObject:self.errorCode forKey:@"errorCode"];
    [aCoder encodeObject:self.errorMsg forKey:@"errorMsg"];
    [aCoder encodeObject:self.objectData forKey:@"objectData"];
    [aCoder encodeObject:self.result forKey:@"result"];
    [aCoder encodeObject:self.httpError forKey:@"httpError"];
}

#pragma mark description
-(NSString *)description{
    NSMutableString *descripString = [NSMutableString stringWithFormat:@""];
    [descripString appendString:@"\n========================Response Info===========================\n"];
    [descripString appendFormat:@"Response Name:%@\n",_responseName];
    [descripString appendFormat:@"Response Content(%lu 条数据):\n%@\n",_result.count,_result];
    if(_result == nil && _isSuccess == NO) {
        [descripString appendFormat:@"Response Error:\n%@\n",_errorMsg];
    }
    [descripString appendString:@"===============================================================\n"];
    return descripString;
}
@end
