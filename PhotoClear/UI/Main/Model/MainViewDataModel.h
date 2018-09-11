//
//  MainViewDataModel.h
//  PhotoClear
//
//  Created by Sj03 on 2018/8/7.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewDataModel : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, assign)NSInteger tag;

- (void)getModelForServer:(NSString *)title content:(NSString *)content image:(NSString *)image tag:(NSInteger )tag;
@end
