//
//  UploadModel.m
//  XLAFNetworking
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 along. All rights reserved.
//

#import "UploadModel.h"

@implementation UploadModel

/**
 *  初始化一个上传文件模型并复制(对象方法)
 *
 *  @param filePath 文件路径
 *  @param name     参数名称
 *  @param fileName 文件名字
 *  @param mimeType 文件类型
 *
 *  @return obj
 */
- (instancetype)initWithUploadModelFileData:(id)fileData Name:(NSString *)name FileName:(NSString *)fileName MimeType:(NSString *)mimeType {
    if(self = [super init]) {
        self.fileData = [self checkData:fileData];
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}

/**
 *  初始化一个上传文件模型并复制(实例方法)
 *
 *  @param filePath 文件路径
 *  @param name     参数名称
 *  @param fileName 文件名字
 *  @param mimeType 文件类型
 *
 *  @return obj
 */
+ (instancetype)UploadModelWithFileData:(id)fileData Name:(NSString *)name FileName:(NSString *)fileName MimeType:(NSString *)mimeType {
    return [[self alloc]initWithUploadModelFileData:fileData Name:name FileName:fileName MimeType:mimeType];
}

/**
 *  处理文件数据
 *
 *  @param fileData 文件数据对象
 *
 *  @return 返回data数据
 */
- (NSData *)checkData:(id)fileData {
    if(fileData != nil) {
        if([fileData isKindOfClass:[NSString class]]) {
            return [NSData dataWithContentsOfFile:fileData];
        }else if ([fileData isKindOfClass:[NSURL class]]) {
            return [NSData dataWithContentsOfURL:fileData];
        }else if ([fileData isKindOfClass:[NSData class]]) {
            return fileData;
        }else {
            return [[NSData alloc]init];
        }
    }
    return [[NSData alloc]init];
}

- (CreateUploadModel)SetFileData {
    return ^id(id data) {
        self.fileData = data;
        return self;
    };
}

- (CreateUploadModel)SetName {
    return ^id(NSString *name) {
        self.name = name;
        return self;
    };
}

- (CreateUploadModel)SetFileName {
    return ^id(NSString *fileName) {
        self.fileName = fileName;
        return self;
    };
}

- (CreateUploadModel)SetMimeType {
    return ^id(NSString *mimeType) {
        self.mimeType = mimeType;
        return self;
    };
}
@end
