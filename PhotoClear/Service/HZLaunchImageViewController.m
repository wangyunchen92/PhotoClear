//
//  HZLaunchImageViewController.m
//  ColorfulFund
//
//  Created by Madis on 17/3/28.
//  Copyright © 2017年 zritc. All rights reserved.
//

#import "HZLaunchImageViewController.h"

static const NSInteger secondsCountDown = 3;

@interface HZLaunchImageViewController ()
{
    NSTimer *_countDownTimer;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@property (assign, nonatomic) NSInteger currentSecondsCountDown; //倒计时总时长
@property (assign, nonatomic) BOOL showDefaultImage;

@end

@implementation HZLaunchImageViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.showDefaultImage = NO;
    }
    return self;
}

- (id)initWithDefaultImage
{
    self = [super init];
    if (self) {
        self.showDefaultImage = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.skipButton.hidden = YES;
    self.skipButton.layer.borderWidth = 1;
    self.skipButton.layer.borderColor = RGB(204,204,204).CGColor;
    if(!self.showDefaultImage){
        // 首次启动时不显示启动页只显示引导页
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        [_countDownTimer fire];
        self.skipButton.layer.cornerRadius = self.skipButton.height/2.0f;
        self.skipButton.clipsToBounds = YES;

        [self.launchImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.skipButton.hidden = NO;
        }];
        //增加imageView点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activiTap:)];
        self.launchImageView.userInteractionEnabled = YES;
        [self.launchImageView addGestureRecognizer:tap];
    }else{
        self.launchImageView.image = [UIImage imageNamed:@"闪屏"];
    }
}

- (void)onTimer {
    if (self.currentSecondsCountDown < secondsCountDown) {
        self.skipButton.titleLabel.text = [NSString stringWithFormat:@"跳过 %lds",secondsCountDown-self.currentSecondsCountDown];
        [self.skipButton setTitle:[NSString stringWithFormat:@"跳过 %lds",secondsCountDown-self.currentSecondsCountDown] forState:UIControlStateNormal];
        self.currentSecondsCountDown ++;
    }else{
        [self closeAddImgAnimation:kActivityViewClickedNone];
    }
}

//点击广告页效果
- (void)activiTap:(UITapGestureRecognizer*)recognizer{
    MSLog(@"点击广告页界面");
    // TODO: 当前无需求点击跳转到广告容器 2017年05月02日
    [self closeAddImgAnimation:kActivityViewClickedView];
}

- (IBAction)skipButtonClicked:(id)sender{
    MSLog(@"点击跳过按钮");
    [self closeAddImgAnimation:kActivityViewClickedButton];
}

//- (void)startcloseAnimation{
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.duration = 0.5;
//    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
//    opacityAnimation.removedOnCompletion = NO;
//    opacityAnimation.fillMode = kCAFillModeForwards;
//    
//    [self.launchImageView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
//    [NSTimer scheduledTimerWithTimeInterval:opacityAnimation.duration
//                                     target:self
//                                   selector:@selector(closeAddImgAnimation)
//                                   userInfo:nil
//                                    repeats:NO];
//}

-(void)closeAddImgAnimation:(ActivityViewClickedTag )clickedTag
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    if (self.block_activityViewClicked) {
        self.block_activityViewClicked(clickedTag);
        [self removeFromParentViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
