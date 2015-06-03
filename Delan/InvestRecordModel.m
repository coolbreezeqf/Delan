//
//  InvestRecordModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestRecordModel.h"

@implementation InvestRecordModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.productName = dict[@"productName"];
        self.endTime = dict[@"endTime"];
        self.investMoney = dict[@"investMoney"];
        self.investGet = dict[@"investGet"];
        self.investTime = dict[@"investTime"];
        self.investStatus = [dict[@"investStatus"] intValue];
        
    }
    return self;
}


+ (instancetype)InvestRecordModel:(NSDictionary *)dict {
    
    return [[InvestRecordModel alloc] initWithDict:dict];
}

@end
