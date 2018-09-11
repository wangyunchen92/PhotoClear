//
//  UploadModel.h
//  XLAFNetworking
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UploadModel;

#define CreateUploadModel(fileData,name,fileName,mimeType) [UploadModel new].SetFileData(fileData).SetName(name).SetFileName(fileName).SetMimeType(mimeType)

typedef UploadModel *(^CreateUploadModel)(id UploadModelParameters);

@interface UploadModel : NSObject
/**
 *  文件数据
 */
@property (nonatomic,strong,readwrite) id fileData;
/**
 *  参数名称
 */
@property (nonatomic,strong,readwrite) NSString *name;
/**
 *  文件名字
 */
@property (nonatomic,strong,readwrite) NSString *fileName;
/**
 *  文件类型
 */
@property (nonatomic,strong,readwrite) NSString *mimeType;

/**
 *  初始化一个上传文件模型并复制(对象方法)
 *
 *  @param fileData 文件数据
 *  @param name     参数名称
 *  @param fileName 文件名字
 *  @param mimeType 文件类型
 *
 *  @return obj
 */
- (instancetype)initWithUploadModelFileData:(id)fileData Name:(NSString *)name FileName:(NSString *)fileName MimeType:(NSString *)mimeType;

/**
 *  初始化一个上传文件模型并复制(实例方法)
 *
 *  @param fileData 文件数据
 *  @param name     参数名称
 *  @param fileName 文件名字
 *  @param mimeType 文件类型
 *
 *  @return obj
 */
+ (instancetype)UploadModelWithFileData:(id)fileData Name:(NSString *)name FileName:(NSString *)fileName MimeType:(NSString *)mimeType;

/**
 * 设置参数
 */
- (CreateUploadModel)SetFileData;
- (CreateUploadModel)SetName;
- (CreateUploadModel)SetFileName;
- (CreateUploadModel)SetMimeType;

@end
