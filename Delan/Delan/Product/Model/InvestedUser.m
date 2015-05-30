//
//  InvestedUser.m
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestedUser.h"

@implementation InvestedUser

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.phoneNum = dict[@"phoneNum"];
        self.investMoney = [dict[@"investMoney"] intValue];
        self.investTime = dict[@"investTime"];
    }
    return self;
}


+ (instancetype)investedUserWithDict:(NSDictionary *)dict {
    
    return [[InvestedUser alloc] initWithDict:dict];
}

@end
