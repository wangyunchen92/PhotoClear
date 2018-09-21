//
//  MessageRuleCell.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *MessageRuleCellReuseIdentifier = @"MessageRuleCellReuseIdentifier";

@class MessageRule;

@interface MessageRuleCell : UITableViewCell

- (void)renderCellWithCondition:(MessageRule *)condition;

@end
