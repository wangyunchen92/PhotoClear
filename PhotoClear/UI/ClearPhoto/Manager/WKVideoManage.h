//
//  WKVideoManage.h
//  PhotoClear
//
//  Created by Sj03 on 2018/8/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface WKVideoManage : NSObject

+ (WKVideoManage *)shareManager;

@property (nonatomic, strong)NSMutableDictionary *dataInfo;

- (void)loadVideoWithProcess:(void (^)(NSInteger current, NSInteger total))process
           completionHandler:(void (^)(BOOL success, NSError *error))completion;
@end
