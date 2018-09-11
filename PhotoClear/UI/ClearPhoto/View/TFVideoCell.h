//
//  TFVideoCell.h
//  LocalVideo
//
//  Created by antvr on 16/8/2.
//  Copyright © 2016年 sunTengFei_family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumImageView;
@property (nonatomic, assign)NSIndexPath *index;
@property (nonatomic, copy)void (^block_del)(NSIndexPath *index);
@end
