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
        self.productID = [dict[@"productID"] intValue];
        self.productName = dict[@"productName"];
        self.productType = [dict[@"productType"] intValue];
        self.status = [dict[@"status"] intValue];
        self.isVip = [dict[@"isVip"] intValue];
        self.yearRate = [dict[@"yearRate"] floatValue];
        self.deadline = [dict[@"deadline"] intValue];
        self.saledPercent = [dict[@"percent"] floatValue];
        self.available = [dict[@"available"] floatValue];
        self.total = [dict[@"total"] floatValue];
        self.minPay = [dict[@"minPay"] intValue];
        self.repayType = dict[@"repayType"];
        self.repayDay = dict[@"repayDay"];
        self.buyCounts = [dict[@"buyCounts"] intValue];
        self.trades = [dict[@"trades"] intValue];
        self.state = dict[@"state"];
        self.historys = [dict[@"historys"] intValue];
        self.topRate = dict[@"topRate"];
        self.advance = [dict[@"advance"] intValue];
        self.pictureInfoUrl = dict[@"pictureInfoUrl"];
        self.lawBookUrl = dict[@"lawBookUrl"];
    }
    return self;
}


+ (instancetype)ProductDetailWithDict:(NSDictionary *)dict {
    
    return [[ProductDetail alloc] initWithDict:dict];
}

@end
