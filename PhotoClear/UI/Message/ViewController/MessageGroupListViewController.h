//
//  MessageGroupListViewController.h
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MessageGroupListType) {
    MessageGroupListTypeWhiteList = 0,
    MessageGroupListTypeBlackList,
};

@class MessageGroup;

@interface MessageGroupListViewController : BaseViewController

@property (nonatomic, assign) MessageGroupListType type;
@property (nonatomic, strong, readonly) NSMutableArray<MessageGroup *> *groupList;

- (instancetype)initWithListType:(MessageGroupListType)type;

@end
