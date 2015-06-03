//
//  InvestDetailModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestDetailModel : NSObject

@property (nonatomic,copy)NSString *id;//资金流水号
@property (nonatomic,copy)NSString *money;//金额
@property (nonatomic,copy)NSString *rest;//余额
@property (nonatomic,copy)NSString *time;//操作时间
@property (nonatomic,copy)NSString *status;//状态,1投资,2提现,3充值,4回款

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)InvestDetailModel:(NSDictionary *)dict;


@end
