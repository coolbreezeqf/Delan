//
//  InvestRecordModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestRecordModel : NSObject


@property (nonatomic,copy)NSString *productName;//产品名
@property (nonatomic,copy)NSString *endTime;//截止日期
@property (nonatomic,copy)NSString *investMoney;//投资金额
@property (nonatomic,copy)NSString *investGet;//投资收益
@property (nonatomic,copy)NSString *investTime;//投资时间
@property (nonatomic,assign)int investStatus;//投资状态,1为投资中,2为回款中,3为已回款

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)InvestRecordModel:(NSDictionary *)dict;

@end
