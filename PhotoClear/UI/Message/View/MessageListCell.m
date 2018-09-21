//
//  MessageListCell.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MessageListCell.h"


@implementation MessageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)renderCellWithGroup:(MessageGroup *)group {
    self.textLabel.text = group.alias;
    self.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString((@"%ld conditions"), nil), (long)group.rules.count];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.textLabel.text = @"";
    self.detailTextLabel.text = @"";
}

@end
