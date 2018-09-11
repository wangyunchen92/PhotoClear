//
//  NewTableViewController.h
//  Constellation
//
//  Created by Sj03 on 2018/3/23.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTableViewController : UITableViewController

@property (nonatomic, assign)BOOL canScroll;
@property (nonatomic, assign)BOOL needScrollForScrollerView;
- (instancetype)initWithType:(NSString *)type;
@property (nonatomic, copy)void (^block_scroller)(CGFloat floa);

@end
