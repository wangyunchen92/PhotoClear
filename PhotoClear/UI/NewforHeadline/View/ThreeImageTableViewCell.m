//
//  ThreeImageTableViewCell.m
//  Constellation
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ThreeImageTableViewCell.h"
#import "NewsModel.h"
@interface ThreeImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewArray;

@end

@implementation ThreeImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)getDateForServer:(NewsModel *)model {
    self.titleLabel.text = model.titleString;
    self.dateLabel.text = model.dateString;
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj sd_setImageWithURL:[NSURL URLWithString:[model.iamgeArray objectAtIndex:idx]] placeholderImage:IMAGE_NAME(@"timg")];
    }];
    
    if (model.isread) {
        self.titleLabel.textColor = RGB(153, 153, 153);
    } else {
        self.titleLabel.textColor = RGB(0, 0, 0);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
