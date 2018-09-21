//
//  MessageListCell.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageGroup.h"

static NSString *MJGroupCellReuseIdentifier = @"MJGroupCellReuseIdentifier";

@interface MessageListCell : UITableViewCell

- (void)renderCellWithGroup:(MessageGroup *)group;

@end
