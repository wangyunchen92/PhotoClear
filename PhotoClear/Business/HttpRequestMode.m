//
//  HttpRequestMode.m
//  XLAFNetworking
//
//  Created by admin on 16/8/31.
//  Copyright © 2016年 3ti. All rights reserved.
//

#import "HttpRequestMode.h"

@implementation HttpRequestMode
- (CreateHttpRequestMode)SetName {
    return ^id(NSString *name) {
        if([name isKindOfClass:[NSString class]]) {
            _name = name;
        }
        return self;
    };
}

- (CreateHttpRequestMode)SetUrl {
    return ^id(NSString *url) {
        if([url isKindOfClass:[NSString class]]) {
            _url = url;
        }
        return self;
    };
}

- (CreateHttpRequestMode)SetParameters {
    return ^id(NSDictionary *Parameters) {
        if([Parameters isKindOfClass:[NSDictionary class]]) {
            _parameters = Parameters;
        }
        return self;
    };
}

- (CreateHttpRequestMode)SetIsGET {
    return ^id(NSNumber *isGET) {
        if([isGET isKindOfClass:[NSNumber class]]) {
            _isGET = [isGET boolValue];
        }
        return self;
    };
}

- (CreateHttpRequestMode)SetUploadModels {
    return ^id(NSArray<UploadModel *> *uploadModels) {
        if([uploadModels isKindOfClass:[NSArray class]]) {
            _uploadModels = uploadModels;
        }
        return self;
    };
}

@end
