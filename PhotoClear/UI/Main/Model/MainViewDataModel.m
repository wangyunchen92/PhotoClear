//
//  MainViewDataModel.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/7.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainViewDataModel.h"

@implementation MainViewDataModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _title = @"";
        _content = @"";
        _image = @"";
        _tag = 0;
    }
    return self;
}

- (void)getModelForServer:(NSString *)title content:(NSString *)content image:(NSString *)image  tag:(NSInteger )tag{
    self.image = image;
    self.title = title;
    self.content = content;
    self.tag = tag;
}

@end
