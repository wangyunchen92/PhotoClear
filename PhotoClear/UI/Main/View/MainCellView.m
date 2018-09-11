//
//  MainCellView.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/2.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainCellView.h"

@interface MainCellView ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, assign) NSInteger tag;


@end


@implementation MainCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    [UIUtil addshadows:self.view];
}

- (IBAction)viewTapClick:(id)sender {
    if (self.block_click) {
        self.block_click(self.tag);
    }
}
- (IBAction)buttonClick:(id)sender {
    if (self.block_click) {
        self.block_click(self.tag);
    }
}

- (void)getViewDataForModel:(MainViewDataModel *)model {
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.imageView.image = IMAGE_NAME(model.image);
    self.tag = model.tag;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
