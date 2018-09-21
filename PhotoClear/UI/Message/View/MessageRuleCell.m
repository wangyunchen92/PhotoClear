//
//  MessageRuleCell.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MessageRuleCell.h"
#import "MessageRule.h"

static CGFloat MJConditionCellTargetLabelFontSize = 17.f;
static CGFloat MJConditionCellTypeLabelFontSize = 17.f;
static CGFloat MJConditionCellKeywordLabelFontSize = 17.f;

static CGFloat MJConditionCellLabelLeftPadding = 16.f;
static CGFloat MJConditionCellLabelSpace = 8.f;
static CGFloat MJConditionCellLabelRadius = 3.f;

@interface MessageRuleCell ()

@property (nonatomic, strong) UILabel *targeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *keywordLabel;

@end

@implementation MessageRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self makeConstranits];
    }
    return self;
}

- (void)initUI {
    self.targeLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:MJConditionCellTargetLabelFontSize];
        label.textColor = [UIColor whiteColor];
        label.layer.masksToBounds = true;
        label.layer.cornerRadius = MJConditionCellLabelRadius;
        label;
    });
    [self.contentView addSubview:self.targeLabel];
    
    self.typeLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:MJConditionCellTypeLabelFontSize];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = RGB(255, 204, 153);
        label.layer.masksToBounds = true;
        label.layer.cornerRadius = MJConditionCellLabelRadius;
        label;
    });
    [self.contentView addSubview:self.typeLabel];
    
    self.keywordLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:MJConditionCellKeywordLabelFontSize];
        label;
    });
    [self.contentView addSubview:self.keywordLabel];
}

- (void)makeConstranits {
    [self.targeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MJConditionCellLabelLeftPadding);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.targeLabel.mas_right).offset(MJConditionCellLabelSpace);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.keywordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(MJConditionCellLabelSpace);
        make.centerY.equalTo(self.contentView);
        make.right.lessThanOrEqualTo(self.contentView);
    }];
    [self.keywordLabel setContentCompressionResistancePriority:(UILayoutPriorityDefaultLow) forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)renderCellWithCondition:(MessageRule *)condition {
    switch (condition.ruleTarget) {
        case MERuleTargetSender:
            self.targeLabel.text = @"发送者";
            self.targeLabel.backgroundColor = RGB(102, 204, 102);
            break;
        case MERuleTargetConternt:
            self.targeLabel.text = @"内容";
            self.targeLabel.backgroundColor = RGB(51, 153, 204);
            break;
        default:
            self.targeLabel.text = @"无效目标";
            break;
    }
    
    switch (condition.ruleType) {
        case MERuleTypeHasPrefix:
            self.typeLabel.text = @"含有前缀";
            break;
        case MERuleTypeHasSuffix:
            self.typeLabel.text = @"含有后缀";
            break;
        case MERuleTypeContains:
            self.typeLabel.text = @"包含";
            break;
        case MERuleTypeNoContains:
            self.typeLabel.text = @"不包含";
            break;
        case MERuleTypeContainsRegex:
            self.typeLabel.text = @"匹配正则";
            break;
        default:
            break;
    }
    
    self.keywordLabel.text = condition.keyword;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.targeLabel.text = @"";
    self.typeLabel.text = @"";
    self.keywordLabel.text = @"";
}
@end
