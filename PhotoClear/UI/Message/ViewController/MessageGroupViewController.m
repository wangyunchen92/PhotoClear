//
//  MessageGroupViewController.m
//  MessageJudge
//
//  Created by GeXiao on 11/06/2017.
//  Copyright © 2017 GeXiao. All rights reserved.
//

#import "MessageGroupViewController.h"
#import "MessageGroup.h"
#import "MessageRuleCell.h"
#import "MessageRuleChoseViewController.h"
#import "MessageManage.h"

@interface MessageGroupViewController ()

@property (nonatomic, strong) MessageGroup *conditionGroup;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageGroupViewController

- (instancetype)initWithConditionGroup:(MessageGroup *)group {
    if (self) {
        _conditionGroup = group;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = self.conditionGroup.alias;

    [self.tableView registerClass:MessageRuleCell.class forCellReuseIdentifier:MessageRuleCellReuseIdentifier];
    
    [self createNavWithTitle:self.title leftImage:@"Whiteback" rightImage:@"Whiteback"];
    self.theSimpleNavigationBar.backgroundColor = RGB(18,132,254);
    [self.theSimpleNavigationBar.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theSimpleNavigationBar.bottomLineView.backgroundColor = [UIColor clearColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Action
- (void)navBarButtonAction:(UIButton *)sender {
    if (sender.tag == NBButtonLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (sender.tag == NBButtonRight) {
        MessageRule *newCondition = [[MessageRule alloc] init];
        newCondition.ruleTarget = MERuleTargetConternt;
        newCondition.ruleType = MERuleTypeContains;
        [self.conditionGroup.rules addObject:newCondition];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.conditionGroup.rules.count-1 inSection:0];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        [self tableView:self.tableView didSelectRowAtIndexPath:newIndexPath];
        [[MessageManage shareManage] save] ;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conditionGroup.rules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageRuleCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.conditionGroup.rules.count) {
        [cell renderCellWithCondition:self.conditionGroup.rules[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.conditionGroup.rules.count) {
        MessageRule *condition = self.conditionGroup.rules[indexPath.row];
        MessageRuleChoseViewController *controller = [[MessageRuleChoseViewController alloc] initWithCondition:condition];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.conditionGroup.rules removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[MessageManage shareManage] save];
    }
}

@end
