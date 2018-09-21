//
//  CallViewController.m
//  PhotoClear
//
//  Created by Sj03 on 2018/9/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "CallViewController.h"
#import "CallManager.h"
#import "Model.h"

@interface CallViewController ()

@property (nonatomic, strong) NSMutableArray <Model *>* dataSource;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;

@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNavWithTitle:self.title leftImage:@"Whiteback" rightImage:nil];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDataSource:(id)sender {
    
    self.dataSource = [[CallManager shareManager] readFile];
    NSString * name = self.nameText.text;
    NSString * number = self.phoneText.text;
    Model * model = [[Model alloc] init];
    model.name = name;
    model.number = number;
    [self.dataSource addObject:model];
    
    if (@available(iOS 10, *)) {
//        for (Model * model in self.dataSource) {
            // 循环遍历数据进行号码添加
            // 目前只对中国大陆号码做正则,如果有发烧友对国际编写有思想课修改内部私有接口正则修改
        if ([[CallManager shareManager] addPhoneNumber:model.number name:model.name]) {
            BOOL reluat = [[CallManager shareManager] reload:^(NSError *error) {
                
                NSString * message = nil;
                if (error) {
                    message = @"失败";
                } else {
                    message = @"成功";
                }
                UIAlertController * alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                
                [alerVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alerVC animated:YES completion:nil];
            }];
            
            NSString * string = reluat ? @"保存数据成功" : @"保存数据失败";
            
            NSLog(@"%@",string);
        }
//        }
        
        // 写入到库中, 接口返回值 yes 成功 no失败.回调block做验证,如果error有值 那么呼叫功能可能不存在
    }
}
- (IBAction)retrieve:(id)sender {
    if (@available(iOS 10.0, *)) {
        __weak typeof(self) weakself = self;
        // 检测group id 及权限
        [[CallManager shareManager] getEnableStatus:^(CXCallDirectoryEnabledStatus enabledStatus, NSError *error) {
            if (error) {
                [weakself alertWithMessage:@"来电提示功能 获取权限发生错误 请联系开发人员" tag:0];
                return;
            }
            if (enabledStatus == CXCallDirectoryEnabledStatusUnknown) {
                [weakself alertWithMessage:@"来电提示功能 获取权限-未知状态" tag:0];
            } else if (enabledStatus == CXCallDirectoryEnabledStatusDisabled) {
                [weakself alertWithMessage:@"是否开启来电显示权限功能" tag:1];
            } else if (enabledStatus == CXCallDirectoryEnabledStatusEnabled) {
                NSLog(@"来电权限已开启");
            }
        }];
    }
}

- (void)alertWithMessage:(NSString *)message tag:(int)tag {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    if (tag == 1) {
        UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root"] options:@{} completionHandler:nil];
            }
        }];
        [alert addAction:confirmAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
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
