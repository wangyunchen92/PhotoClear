//
//  ThreeImageTableViewCell.h
//  Constellation
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface ThreeImageTableViewCell : UITableViewCell
- (void)getDateForServer:(NewsModel *)model;
@end
