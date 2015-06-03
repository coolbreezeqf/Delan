//
//  InvestDetailModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestDetailModel.h"

@implementation InvestDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.id= dict[@"id"];
        self.money = dict[@"money"];
        self.rest = dict[@"rest"];
        self.time = dict[@"time"];
        self.status = dict[@"status"];
    }
    return self;
}


+ (instancetype)InvestDetailModel:(NSDictionary *)dict {
    
    return [[InvestDetailModel alloc] initWithDict:dict];
}

@end
