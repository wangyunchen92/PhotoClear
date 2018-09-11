//
//  MainViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/7/31.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainViewController.h"
#import "HWWaveView.h"
#import "MainCellView.h"
#import "MainViewDataModel.h"

#import "ClearGifViewController.h"
#import "BatterViewController.h"
#import "PictureClearListViewController.h"
#import "VideoClearViewController.h"
#import "AboutUsViewController.h"

#import "CallViewController.h"

#import "AppDelegate.h"
#import "UICountingLabel.h"

@interface MainViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutletCollection(MainCellView ) NSArray *viewArray;
@property (weak, nonatomic) IBOutlet UILabel *userSize;
@property (weak, nonatomic) IBOutlet UILabel *allSize;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (nonatomic, strong)CALayer *adminLayer;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, strong)NSTimer* timer;
@property (nonatomic, strong)HWWaveView *waveView;
@property (nonatomic, strong)UICountingLabel *numlabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"手机管家" leftImage:nil rightImage:@"setting"];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    [self admain];
    
    NSDictionary *dic = [ToolUtil getDivceSizeAndUserSize];
    
    self.userSize.text = [NSString stringWithFormat:@"%@GB",[dic objectForKey:@"userSize"]];
    
    self.allSize.text = [NSString stringWithFormat:@"%@GB",[dic objectForKey:@"allSize"]];
    
    NSLog(@"%ld",([[dic objectForKey:@"allSize"] intValue] / [[dic objectForKey:@"userSize"] integerValue]));
    self.num = [[dic objectForKey:@"canuser"] intValue];
//     Do any additional setup after loading the view from its nib.
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self pauseAnimation];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self resumeAnimation];
//        });
//    });
}

- (void)loadUIData {
//    MainViewDataModel *model1 = [[MainViewDataModel alloc] init];
//    [model1 getModelForServer:@"手机优化" content:@"一键加速让手机快如闪电" image:@"手机优化" tag:0];
    
    MainViewDataModel *model2 = [[MainViewDataModel alloc] init];
    [model2 getModelForServer:@"相片清理" content:@"每天清理照片，节约更多手机内存" image:@"照片清理" tag:1];
    
    MainViewDataModel *model3 = [[MainViewDataModel alloc] init];
    [model3 getModelForServer:@"电池管理" content:@"经常关注电池信息，让手机更健康" image:@"电池管理" tag:2];
    
    MainViewDataModel *model4 = [[MainViewDataModel alloc] init];
    [model4 getModelForServer:@"视频清理" content:@"清理多余视频，手机运行更快" image:@"视频清理" tag:3];
    
    NSArray *modelArr = [[NSArray alloc] initWithObjects:model2,model3,model4, nil];
    
    [self.viewArray enumerateObjectsUsingBlock:^(MainCellView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj getViewDataForModel:[modelArr objectAtIndex:idx]];
        obj.block_click = ^(NSInteger tag) {
            [self pushNextVC:tag];
        };
    }];
    
    NSString *str = [UserDefaultsTool getStringWithKey:@"setAppTime"];
    NSDate *date1 = [NSDate date];
    NSDateFormatter *dateformate = [[NSDateFormatter alloc] init];
    dateformate.dateFormat = @"yyyy-MM-dd";
    NSDate *date2 = [dateformate dateFromString:str];
    
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",([ToolUtil getDaysFromDate:date2 toDate:date1] + 1)];
}

- (void)viewWillAppear:(BOOL)animated {
    self.waveView.progress = 0.0;
//    if (!(delegate.mainNum == self.num)) {
//        [self resumeAnimation];
//        self.num = delegate.mainNum ;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [self.numlabel countFrom:0 to:self.num withDuration:(self.num -self.waveView.progress*100)/20 ];
//    }
}

-(void)timerAction {
    self.waveView.progress += 0.01;
    if ((self.waveView.progress *100) >= self.num) {
        [self remTime];
        [self pauseAnimation];
    }
}

- (void)remTime {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)pushNextVC :(NSInteger )tag {
    BaseViewController *vc;
    if (tag == 0) {
        vc = [[ClearGifViewController alloc] init];
    }
    if (tag == 1) {
        vc = [[CallViewController alloc] init];
    }
    if (tag == 2) {
        vc = [[BatterViewController alloc] init];
    }
    if (tag == 3) {
        vc = [[VideoClearViewController alloc] init];
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self remTime];
}

- (void)admain{
    //波浪
    HWWaveView *waveView = [[HWWaveView alloc] initWithFrame:CGRectMake(kScreenWidth/2-80, 43, 160, 160)];
    
    [self.scrollerView addSubview:waveView];
    self.waveView = waveView;
    
    UICountingLabel *label = [[UICountingLabel alloc] init];
    [waveView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(waveView);
        make.centerX.equalTo(waveView.mas_centerX).offset(-10);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    [waveView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(5);
        make.centerY.mas_equalTo(waveView);
    }];
    
    lab.text = @"%";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:32];
    
    label.text = [NSString stringWithFormat:@"%ld",self.num];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:32];
    self.numlabel = label;
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor whiteColor].CGColor; //圆环底色
    layer.frame = CGRectMake(0, 24, kScreenWidth, 200);
    
//    //创建一个圆环
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kScreenWidth/2, 100) radius:82 startAngle:M_PI*0.25 endAngle:M_PI clockwise:YES];
//    
//    //圆环遮罩
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.lineWidth = 5;
//    shapeLayer.strokeStart = 0;
//    shapeLayer.strokeEnd = 0.8;
//    shapeLayer.lineCap = @"round";
//    shapeLayer.lineDashPhase = 0.8;
//    shapeLayer.path = bezierPath.CGPath;
//    
//    //颜色渐变
//    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)RGB(18, 132, 254).CGColor,[UIColor whiteColor].CGColor, nil];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.shadowPath = bezierPath.CGPath;
//    gradientLayer.frame = CGRectMake(kScreenWidth/2-86, 100-80, 164, 164);
//    gradientLayer.startPoint = CGPointMake(1, 0);
//    gradientLayer.endPoint = CGPointMake(0, 0);
//    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
////    [gradientLayer setMask:layer];
//    [layer addSublayer:gradientLayer]; //设置颜色渐变
//    [layer setMask:shapeLayer]; //设置圆环遮罩
//    
////    //颜色渐变
////    NSMutableArray *colors2 = [NSMutableArray arrayWithObjects:(id)RGB(18, 132, 254).CGColor,[UIColor whiteColor].CGColor, nil];
////    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
////    gradientLayer2.shadowPath = bezierPath.CGPath;
////    gradientLayer2.frame = CGRectMake(kScreenWidth/2, 180, 160, 80);
////    gradientLayer2.startPoint = CGPointMake(0,1);
////    gradientLayer2.endPoint = CGPointMake(1, 1);
////    [gradientLayer2 setColors:[NSArray arrayWithArray:colors2]];
////    //    [gradientLayer setMask:layer];
////    [layer addSublayer:gradientLayer2]; //设置颜色渐变
//    
//    [self.scrollerView.layer addSublayer:layer];
//
//    CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
//    rotationAnimation2.toValue = [NSNumber numberWithFloat:2.0*M_PI];
//    rotationAnimation2.fillMode = kCAFillModeForwards;
////    rotationAnimation2.fillMode = @"forwards";
//    rotationAnimation2.repeatCount = MAXFLOAT;
////    rotationAnimation2.beginTime = 0.8; //延时执行，注释掉动画会同时进行
//    rotationAnimation2.duration = 1;
//    rotationAnimation2.removedOnCompletion = NO;
//    [layer addAnimation:rotationAnimation2 forKey:@"groupAnnimation"];
//    self.adminLayer = layer;
}

//暂停动画
- (void)pauseAnimation {
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [self.adminLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    self.adminLayer.timeOffset = pauseTime;
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    self.adminLayer.speed = 0;
}

//恢复动画
- (void)resumeAnimation {
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = self.adminLayer.timeOffset;
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    [self.adminLayer setTimeOffset:0];
    [self.adminLayer setBeginTime:begin];
    self.adminLayer.speed = 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
        scrollView.contentOffset = offset;
    }
}

- (void)navBarButtonAction:(UIButton *)sender {
    if (sender.tag == NBButtonRight) {
        AboutUsViewController *abVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:abVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
