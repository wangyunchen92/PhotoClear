
//
//  NewsModel.m
//  Constellation
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NewsModel.h"
#import "AppDelegate.h"

@implementation NewsModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _iamgeArray = [[NSMutableArray alloc] init];
        _dateString = @"";
        _titleString = @"";
    }
    return self;
}

- (void)getDateForServer:(NSDictionary *)dic {
    self.idString = [dic stringForKey:@"id"];
    self.titleString = [dic stringForKey:@"title"];
    self.urlString = [dic stringForKey:@"news_url"];
    self.dateString = [dic stringForKey:@"publish_time"];
    
    if ([[dic stringForKey:@"show_type"] isEqualToString:@"4"]) {
        self.typeString = ThreeImage_NewType;

        [self.iamgeArray addObject:[self httpreplacingHttps:[dic stringForKey:@"thumbnail_pic_s1"]]];
        [self.iamgeArray addObject:[self httpreplacingHttps:[dic stringForKey:@"thumbnail_pic_s2"]]];
        [self.iamgeArray addObject:[self httpreplacingHttps:[dic stringForKey:@"thumbnail_pic_s3"]]];
    } else if ([[dic stringForKey:@"show_type"] isEqualToString:@"3"]) {
        self.typeString = OneImage_NewType;
        [self.iamgeArray addObject:[self httpreplacingHttps:[dic stringForKey:@"thumbnail_pic_s1"]]];
//        NSArray *arr = [dic arrayForKey:@"pics"];
//        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self.iamgeArray addObject:[self httpreplacingHttps:obj]];
//        }];
    }
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     self.isread = [delegate.readNewsArray containsObject:self.idString];
}

- (NSString *)httpreplacingHttps:(NSString *)str {
    NSString *result = [str stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    return result;
}

@end
