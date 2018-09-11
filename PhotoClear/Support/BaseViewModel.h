//
//  BaseViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)RACSubject *subject_getDate;
@property (nonatomic, copy)void (^block_reloadDate)(void);
- (void)initSigin;
@end
