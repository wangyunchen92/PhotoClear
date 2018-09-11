
//
//  MainNewHealineViewModel.m
//  Constellation
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NewHealineTitleViewModel.h"
@interface NewHealineTitleViewModel ()

@end

@implementation NewHealineTitleViewModel
- (instancetype)init {
    self = [super init];
    if (self) {

        _allKeyArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)initSigin {
    [self.subject_getDate subscribeNext:^(id x) {


        HttpRequestMode* model = [[HttpRequestMode alloc] init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        model.parameters = params;

        model.url = GetNewsNav;
        model.name = @"新闻列表表头";

        [[HttpClient sharedInstance]requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            NSArray *arr= [response.result arrayForKey:@"object"];
            [self.allKeyArray removeAllObjects];
            [self.dataArray removeAllObjects];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                [self.allKeyArray addObject:[dic stringForKey:@"key"]];
                [self.dataArray addObject:[dic stringForKey:@"name"]];
            }];
//            [self.allKeyArray addObject:@"index"];
//            [self.allKeyArray addObject:@"baiyang"];
//            [self.allKeyArray addObject:@"jinniu"];
//            [self.allKeyArray addObject:@"shuangzi"];
//            [self.allKeyArray addObject:@"juxie"];
//            [self.allKeyArray addObject:@"shizi"];
//            [self.allKeyArray addObject:@"chunv"];
//            [self.allKeyArray addObject:@"tiancheng"];
//            [self.allKeyArray addObject:@"tianxie"];
//            [self.allKeyArray addObject:@"sheshou"];
//            [self.allKeyArray addObject:@"mojie"];
//            [self.allKeyArray addObject:@"shuiping"];
//            [self.allKeyArray addObject:@"shuangyu"];
//            
//            [self.dataArray addObject:@"首页"];
//            [self.dataArray addObject:@"白羊座"];
//            [self.dataArray addObject:@"金牛座"];
//            [self.dataArray addObject:@"双子座"];
//            [self.dataArray addObject:@"巨蟹座"];
//            [self.dataArray addObject:@"狮子座"];
//            [self.dataArray addObject:@"处女座"];
//            [self.dataArray addObject:@"天秤座"];
//            [self.dataArray addObject:@"天蝎座"];
//            [self.dataArray addObject:@"射手座"];
//            [self.dataArray addObject:@"摩羯座"];
//            [self.dataArray addObject:@"水瓶座"];
//            [self.dataArray addObject:@"双鱼座"];

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
