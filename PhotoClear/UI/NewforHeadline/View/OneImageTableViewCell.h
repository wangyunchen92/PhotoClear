//
//  OneImageTableViewCell.h
//  Constellation
//
//  Created by Sj03 on 2018/3/23.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface OneImageTableViewCell : UITableViewCell

- (void)getDateForServer:(NewsModel *)dic;
@end
