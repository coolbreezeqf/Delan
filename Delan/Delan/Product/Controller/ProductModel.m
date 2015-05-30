//
//  ProductModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.id = dict[@"id"];
        self.name = dict[@"name"];
        self.type= dict[@"type"];
        self.status = dict[@"status"];
        self.isVip = dict[@"isVip"];
        self.rate = [dict[@"rate"] floatValue];
        self.days = dict[@"days"];
        self.startMoney = [dict[@"startMoney"] floatValue];
        self.percent = [dict[@"percent"] floatValue];
    }
    return self;
}


+ (instancetype)ProductWithDict:(NSDictionary *)dict {
    
    return [[ProductModel alloc] initWithDict:dict];
}

@end
