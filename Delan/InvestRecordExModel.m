//
//  InvestRecordExModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestRecordExModel.h"

@implementation InvestRecordExModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.get = dict[@"get"];
        self.waitGetMoney = dict[@"waitGetMoney"];
        self.waitGetGood = dict[@"waitGetGood"];
        self.totalInvest = dict[@"totalInvest"];
        self.rest = dict[@"rest"];
        self.waitGetAll = dict[@"waitGetAll"];
        self.waitGetLX = dict[@"waitGetLX"];
        self.alreadyGetAll = dict[@"alreadyGetAll"];
        self.alreadyGetMoney = dict[@"alreadyGetMoney"];
        self.alreadyGetLX = dict[@"alreadyGetLX"];
    }
    return self;
}


+ (instancetype)InvestRecordExModel:(NSDictionary *)dict {
    
    return [[InvestRecordExModel alloc] initWithDict:dict];
}

@end
