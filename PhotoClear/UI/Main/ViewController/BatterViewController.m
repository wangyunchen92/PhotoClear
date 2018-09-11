//
//  BatterViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/8/8.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BatterViewController.h"

@interface BatterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *batterCanUser;
@property (weak, nonatomic) IBOutlet UILabel *topViewStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowBatterLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneStateLabel;
@end

@implementation BatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavWithTitle:@"电池管理" leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
    [self getBatterInformation];
}

- (void)getBatterInformation {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIDeviceBatteryStateDidChangeNotification
     object:nil queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *notification) {
         [self changeState];
     }];
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIDeviceBatteryLevelDidChangeNotification
     object:nil queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *notification) {
         [self changeState];
     }];
    [self changeState];
}

- (void)changeState {
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    self.nowBatterLabel.text = [NSString stringWithFormat:@"%.0f%%",deviceLevel *100];
    self.topViewStateLabel.text = [NSString stringWithFormat:@"%.0f",deviceLevel *100];
    if (deviceLevel <0.2) {
        self.phoneStateLabel.text = @"电量不足";
        self.phoneStateLabel.textColor = [UIColor orangeColor];
    } else if (deviceLevel > 0.2) {
        self.phoneStateLabel.text = @"电量充足";
        self.phoneStateLabel.textColor = RGB(9, 187, 7);
    }
    switch ([UIDevice currentDevice].batteryState) {
        case UIDeviceBatteryStateUnplugged:
            self.stateLabel.text = @"未充电";
            break;
        case UIDeviceBatteryStateCharging:
            self.stateLabel.text = @"正在充电";
            break;
        case UIDeviceBatteryStateFull:
            self.stateLabel.text = @"已充满";
            break;
        default:
            break;
    }
    
    NSInteger hour = 1440 * deviceLevel  /60;
    NSInteger min = 1440 * deviceLevel - hour * 60;
    
    self.batterCanUser.text = [NSString stringWithFormat:@"%d小时%d分钟",hour,min];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 Get the new view controller using [segue destinationViewController].
 Pass the selected object to the new view controller.
 }
 */

@end
