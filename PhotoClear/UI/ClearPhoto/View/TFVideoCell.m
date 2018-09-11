//
//  TFVideoCell.m
//  LocalVideo
//
//  Created by antvr on 16/8/2.
//  Copyright © 2016年 sunTengFei_family. All rights reserved.
//

#import "TFVideoCell.h"

@interface TFVideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *delImage;

@end

@implementation TFVideoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delImage.userInteractionEnabled = YES;
    
}

- (IBAction)delAction:(id)sender {
    if (self.block_del) {
        self.block_del(self.index);
    }
}

@end
