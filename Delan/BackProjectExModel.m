//
//  BackProjectExModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BackProjectExModel.h"

@implementation BackProjectExModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.waitGetAll = dict[@"data"][@"info"][@"waitGetAll"];
        self.waitGetMoney = dict[@"data"][@"info"][@"waitGetMoney"];
        self.waitGetLX = dict[@"data"][@"info"][@"waitGetLX"];
        self.alreadyGetAll = dict[@"data"][@"info"][@"alreadyGetAll"];
        self.alreadyGetMoney = dict[@"data"][@"info"][@"alreadyGetMoney"];
        self.alreadyGetLX = dict[@"data"][@"info"][@"alreadyGetLX"];
    }
    return self;
}


+ (instancetype)BackProjectExModel:(NSDictionary *)dict {
    
    return [[BackProjectExModel alloc] initWithDict:dict];
}

@end
