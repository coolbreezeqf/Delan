//
//  BackProjectModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BackProjectModel.h"

@implementation BackProjectModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.productName = dict[@"productName"];
        self.endTime = dict[@"endTime"];
        self.shouldGetMoney = dict[@"investMoney"];
        self.shouldGetLX = dict[@"investGet"];
        self.times = dict[@"investTime"];
        self.backTime = dict[@"investStatus"];
        self.backStatus = [dict[@"backStatus"] intValue];
    }
    return self;
}


+ (instancetype)BackProjectModel:(NSDictionary *)dict {
    
    return [[BackProjectModel alloc] initWithDict:dict];
}

@end
