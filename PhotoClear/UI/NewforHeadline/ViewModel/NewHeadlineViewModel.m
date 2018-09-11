//
//  NewHeadlineViewModel.m
//  Constellation
//
//  Created by Sj03 on 2018/3/23.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NewHeadlineViewModel.h"
#import "NewsModel.h"

@interface NewHeadlineViewModel()

@end
@implementation NewHeadlineViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isadd = YES;
        self.pagString = @"1";
    }
    return self;
}

- (void)initSigin {
    [self.subject_getDate subscribeNext:^(id x) {
        HttpRequestMode* model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params addUnEmptyString:self.typeString forKey:@"type"];
        [params addUnEmptyString:self.pagString forKey:@"p"];
        model.parameters = params;
        model.url = GetNews;
        model.name = @"新闻列表";
        [[HttpClient sharedInstance]requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            NSArray *arr = [response.result arrayForKey:@"object"];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // type other 为广告
                if ([obj[@"type"] isEqualToString:@"other"]) {
                    return;
                }
                NewsModel *model = [[NewsModel alloc] init];
                [model getDateForServer:obj];
                if (self.isadd) {
                    [self.dataArray addObject:model];
                } else {
                    [self.dataArray insertObject:model atIndex:0];
                }
            }];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
        } RequsetStart:^{
            
        } ResponseEnd:^{
            
        }];
    }];
    
}

@end
