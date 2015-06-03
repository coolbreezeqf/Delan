//
//  InvestRecordExModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestRecordExModel : NSObject

@property (nonatomic,copy)NSString *get;//累计收益
@property (nonatomic,copy)NSString *waitGetMoney;//待收本金
@property (nonatomic,copy)NSString *waitGetGood;//待收收益
@property (nonatomic,copy)NSString *totalInvest;//累计投资
@property (nonatomic,copy)NSString *rest;//可用余额
@property (nonatomic,copy)NSString *waitGetAll;//待收本息
@property (nonatomic,copy)NSString *waitGetLX;//待收利息
@property (nonatomic,copy)NSString *alreadyGetAll;//已收本息
@property (nonatomic,copy)NSString *alreadyGetMoney;//已收本金
@property (nonatomic,copy)NSString *alreadyGetLX;//已收利息

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)InvestRecordExModel:(NSDictionary *)dict;

@end
