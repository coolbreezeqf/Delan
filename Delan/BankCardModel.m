//
//  BankCardModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/3.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.bankIcon= dict[@"bankIcon"];
        self.bankName = dict[@"bankName"];
        self.cardCode = dict[@"cardCode"];
    }
    return self;
}


+ (instancetype)BankCardModel:(NSDictionary *)dict {
    
    return [[BankCardModel alloc] initWithDict:dict];
}

@end
