//
//  MessageGroupListViewController.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MessageGroupListViewController.h"
#import "MessageListCell.h"
#import "MessageGroupViewController.h"
#import "MessageManage.h"

@interface MessageGroupListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageGroupListViewController

- (instancetype)initWithListType:(MessageGroupListType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSMutableArray<MessageGroup *> *)groupList {
    switch (self.type) {
        case MessageGroupListTypeWhiteList:
            return [MessageManage shareManage].whiteGroupList;
            break;
        case MessageGroupListTypeBlackList:
            return [MessageManage shareManage].blackGroupList;
            break;
        default:
            return [MessageManage shareManage].blackGroupList;
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewConditionGroup)];
    

    
    [self.tableView registerClass:MessageListCell.class forCellReuseIdentifier:MJGroupCellReuseIdentifier];
    switch (self.type) {
        case MessageGroupListTypeWhiteList:
            self.title = @"白名单";
            break;
        case MessageGroupListTypeBlackList:
            self.title = @"黑名单";
            break;
    }
    
    [self createNavWithTitle:self.title leftImage:@"Whiteback" rightImage:@"Whiteback"];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Action

- (void)navBarButtonAction:(UIButton *)sender {
    
    if (sender.tag == NBButtonLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (sender.tag == NBButtonRight) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新建条件组" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *groupAlias = alert.textFields[0].text;
            MessageGroup *newGroup = [MessageGroup new];
            newGroup.alias = groupAlias;
            [self.groupList addObject:newGroup];
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.groupList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
            [[MessageManage shareManage] save];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                handler:nil]];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"条件组别(可选)";
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:MJGroupCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.groupList.count) {
        [cell renderCellWithGroup:self.groupList[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.groupList.count) {
        MessageGroup *group = self.groupList[indexPath.row];
        MessageGroupViewController *groupViewController = [[MessageGroupViewController alloc] initWithConditionGroup:group];
        [self.navigationController pushViewController:groupViewController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.groupList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[MessageManage shareManage] save];
    }
}

@end
