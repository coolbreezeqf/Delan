//
//  BackProjectModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackProjectModel : NSObject


@property (nonatomic,copy)NSString *productName;//产品名
@property (nonatomic,copy)NSString *endTime;//截止日期
@property (nonatomic,copy)NSString *shouldGetMoney;//应收本金(已收)
@property (nonatomic,copy)NSString *shouldGetLX;//应收利息(已收)
@property (nonatomic,copy)NSString *times;//期次
@property (nonatomic,copy)NSString *backTime;//回款日期
@property (nonatomic,assign)int backStatus;//投资状态,1为待回款,2为已回款

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)BackProjectModel:(NSDictionary *)dict;

@end
