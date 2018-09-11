//
//  BaseViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _subject_getDate = [[RACSubject alloc] init];
        _dataArray = [[NSMutableArray alloc] init];
        [self initSigin];
    }
    return self;
}

- (void)initSigin {

}

@end
