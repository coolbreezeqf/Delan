//
//  ProductDetail.m
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductDetail.h"

@implementation ProductDetail

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.type = [dict[@"type"] intValue];
        self.yearRate = [dict[@"yearRate"] floatValue];
        self.deadline = [dict[@"deadline"] intValue];
        self.saledPercent = [dict[@"saledPercent"] floatValue];
        self.saled = [dict[@"saled"] floatValue];
        self.total = [dict[@"total"] floatValue];
        self.minPay = [dict[@"minPay"] intValue];
        self.repayType = dict[@"repayType"];
        self.repayDay = dict[@"repayDay"];
    }
    return self;
}


+ (instancetype)ProductDetailWithDict:(NSDictionary *)dict {
    
    return [[ProductDetail alloc] initWithDict:dict];
}

@end
