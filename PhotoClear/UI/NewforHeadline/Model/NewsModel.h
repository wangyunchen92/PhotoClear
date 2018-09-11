//
//  NewsModel.h
//  Constellation
//
//  Created by Sj03 on 2018/3/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (nonatomic, copy)NSString *titleString;
@property (nonatomic, copy)NSString *dateString;
@property (nonatomic, strong)NSMutableArray *iamgeArray;
@property (nonatomic, copy)NSString *idString;
@property (nonatomic, assign)NewType typeString;
@property (nonatomic, copy)NSString *urlString;
@property (nonatomic, assign)BOOL isread;
- (void)getDateForServer:(NSDictionary *)dic;
@end
