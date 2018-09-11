//
//  bottomView.h
//  PhotoClear
//
//  Created by Sj03 on 2018/8/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bottomView : UIView

@property (nonatomic, copy)void (^block_allChonse)(BOOL issle);
@property (nonatomic, copy)void (^block_dele)(void);
@property (weak, nonatomic) IBOutlet UIButton *deleButton;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@end
