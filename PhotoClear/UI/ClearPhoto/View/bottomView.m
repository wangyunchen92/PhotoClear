//
//  bottomView.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "bottomView.h"

@interface bottomView ()
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation bottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        [self addSubview:self.view];
        self.view.frame = self.bounds;
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowOffset = CGSizeMake(0, 1);
        self.view.layer.shadowOpacity = 0.4;
        self.allButton.selected = NO;
        [self.allButton setImage:IMAGE_NAME(@"照片清理_未选中") forState:UIControlStateNormal];
        [self.allButton setImage:IMAGE_NAME(@"照片清理_选中") forState:UIControlStateSelected];

    }
    
    return self;
}

- (IBAction)allButtonClick:(id)sender {
    self.allButton.selected = !self.allButton.selected;
    if (self.allButton.selected) {
        if (self.block_allChonse) {
            self.block_allChonse(YES);
        }
    } else {
        if (self.block_allChonse) {
            self.block_allChonse(NO);
        }
    }
}

- (IBAction)deleButtonClick:(id)sender {
    if (self.block_dele) {
        self.block_dele();
    }
}

@end
