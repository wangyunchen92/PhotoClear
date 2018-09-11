//
//  MainCellView.h
//  PhotoClear
//
//  Created by Sj03 on 2018/8/2.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewDataModel.h"

@interface MainCellView : UIView
- (void)getViewDataForModel:(MainViewDataModel *)model;
@property (nonatomic, copy)void (^block_click)(NSInteger tag);

@end
