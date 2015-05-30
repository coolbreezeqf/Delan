//
//  AccountCenterModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCenterModel : NSObject

@property(nonatomic,copy)NSString *totalMoney;//我的总资产
@property(nonatomic,copy)NSString *restMoney;//我的余额

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)AccountCenterModel:(NSDictionary *)dict;

@end
