//
//  AccountCenterModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountCenterModel.h"

@implementation AccountCenterModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.totalMoney = dict[@"totalMoney"];
        self.restMoney = dict[@"restMoney"];
    }
    return self;
}


+ (instancetype)AccountCenterModel:(NSDictionary *)dict {
    
    return [[AccountCenterModel alloc] initWithDict:dict];
}

@end
