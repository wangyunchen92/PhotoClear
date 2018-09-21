//
//  MessageRuleChoseViewController.h
//  MessageJudge
//
//  Created by GeXiao on 12/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <XLForm/XLForm.h>

@class MessageRule;

@interface MessageRuleChoseViewController : XLFormViewController

@property (nonatomic, strong, readonly) MessageRule *condition;

- (instancetype)initWithCondition:(MessageRule *)condition;

@end
