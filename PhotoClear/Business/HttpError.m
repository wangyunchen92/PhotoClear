//
//  HttpError.m
//  XLAFNetworking
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 along. All rights reserved.
//

#import "HttpError.h"

@implementation HttpError

#pragma mark 错误处理
/**
 *  处理错误
 *
 *  @param error 错误对象
 */
- (void)handleHttpError:(NSError *)error {
    
    if(!error){
        return;
    }
    
    NSDictionary *errorInfo = [error userInfo];
    
    _localizedDescription = [errorInfo objectForKey:@"NSLocalizedDescription"];

    _failingURLString = [errorInfo objectForKey:@"NSErrorFailingURLStringKey"];

    NSError *err = [errorInfo objectForKey:@"NSUnderlyingError"];
  

//    NSDictionary *dicCode = @{
//        @"400":@"(错误请求)服务器不理解请求的语法。",
//        @"401":@"(未授权)请求要求身份验证。对于需要登录的网页，服务器可能返回此响应。",
//        @"403":@"(禁止)服务器拒绝请求。",
//        @"40@":@"(未找到)服务器找不到请求的网页。",
//        @"405":@"(方法禁用)禁用请求中指定的方法。",
//        @"406":@"(不接受)无法使用请求的内容特性响应请求的网页。",
//        @"407":@"(需要代理授权)此状态代码与 401(未授权）类似，但指定请求者应当授权使用代理。",
//        @"408":@"(请求超时）  服务器等候请求时发生超时。",
//        @"409":@"(冲突）  服务器在完成请求时发生冲突。服务器必须在响应中包含有关冲突的信息。",
//        @"410":@"(已删除）  如果请求的资源已永久删除，服务器就会返回此响应。",
//        @"411":@"(需要有效长度） 服务器不接受不含有效内容长度标头字段的请求。",
//        @"412":@"(未满足前提条件） 服务器未满足请求者在请求中设置的其中一个前提条件。",
//        @"413":@"(请求实体过大） 服务器无法处理请求，因为请求实体过大，超出服务器的处理能力。",
//        @"414":@"(请求的 URI 过长） 请求的 URI(通常为网址）过长，服务器无法处理。",
//        @"415":@"(不支持的媒体类型） 请求的格式不受请求页面的支持。",
//        @"416":@"(请求范围不符合要求） 如果页面无法提供请求的范围，则服务器会返回此状态代码。",
//        @"417":@"(未满足期望值） 服务器未满足”期望”请求标头字段的要求。",
//        @"422":@"请求格式正确，但是由于含有语义错误，无法响应。",
//        @"423":@"当前资源被锁定。",
//        @"424":@"由于之前的某个请求发生的错误，导致当前请求失败。",
//        @"425":@"在WebDav Advanced Collections 草案中定义，但是未出现在《WebDAV 顺序集协议》中",
//        @"426":@"客户端应当切换到TLS/1.0。",
//        @"449":@"由微软扩展，代表请求应当在执行完适当的操作后进行重试。",
//        @"500":@"（服务器内部错误）  服务器遇到错误，无法完成请求。",
//        @"501":@"（尚未实施） 服务器不具备完成请求的功能。 例如，服务器无法识别请求方法时可能会返回此代码。",
//        @"502":@"（错误网关） 服务器作为网关或代理，从上游服务器收到无效响应。",
//        @"503":@"（服务不可用） 服务器目前无法使用（由于超载或停机维护）。 通常，这只是暂时状态。",
//        @"504":@"（网关超时）  服务器作为网关或代理，但是没有及时从上游服务器收到请求。",
//        @"505":@"（HTTP 版本不受支持） 服务器不支持请求中所用的 HTTP 协议版本。",
//        @"506":@"服务器存在内部配置错误：被请求的协商变元资源被配置为在透明内容协商中使用自己，因此在一个协商处理中不是一个合适的重点。",
//        @"507":@"服务器无法存储完成请求所必须的内容。这个状况被认为是临时的。",
//        @"509":@"服务器达到带宽限制。这不是一个官方的状态码，但是仍被广泛使用。",
//        @"510":@"获取资源所需要的策略并没有没满足。",
//        @"600":@"源站没有返回响应头部，只返回实体内容"
//    };

    NSString * errorMsg = nil;
    if (err.code == 0) {
        errorMsg = @"未能连接到服务器";
    }else if (err.code == 200) {
        // 请求成功
    } else if (err.code == 404) {
        errorMsg = @"请求错误";
    } else if (err.code >= 500) {
        errorMsg = @"服务器异常";
    }else if (err.code == -1001) {
        errorMsg = @"网络连接超时，请重试";
    }else if (err.code == -1004) {
        errorMsg = @"未能连接到服务器";
    }else if (err.code == -1005) {
        errorMsg = @"网络连接已中断";
    }
    
    _errorCode = [NSString stringWithFormat:@"%ld",(long)err.code];
    _errorMsg = errorMsg;
}

#pragma mark setProperty
- (void)setResponseName:(NSString *)responseName {
    if(![responseName isEqualToString:@""] && responseName) {
        _responseName = responseName;
    }else {
        _responseName = @"无";
    }
}

- (void)setFailingURLString:(NSString *)failingURLString {
    if(![failingURLString isEqualToString:@""] && failingURLString) {
        _failingURLString = failingURLString;
    }else {
        _failingURLString = @"无";
    }
}

- (void)setLocalizedDescription:(NSString *)localizedDescription {
    if(![localizedDescription isEqualToString:@""] && localizedDescription) {
        _localizedDescription = localizedDescription;
    }else {
        _localizedDescription = @"无";
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

#pragma description
-(NSString *)description {
    NSMutableString *descripString = [NSMutableString stringWithFormat:@""];
    [descripString appendString:@"\n========================Response Info===========================\n"];
    [descripString appendFormat:@"Response Name:  %@\n",_responseName];
    [descripString appendFormat:@"error URL:  %@\n",_failingURLString];
    [descripString appendFormat:@"error Content:  %@\n",_localizedDescription];
    [descripString appendFormat:@"error Code:  %@\n",_errorCode];
    [descripString appendFormat:@"error message:  %@\n",_errorMsg];
    [descripString appendString:@"===============================================================\n"];
    return descripString;
}
@end
