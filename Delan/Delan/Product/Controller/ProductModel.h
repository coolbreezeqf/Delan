//
//  ProductModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

@property (nonatomic,copy)NSString *id;//产品id
@property (nonatomic,copy)NSString *name;//产品名
@property (nonatomic,copy)NSString *type;//产品类型
@property (nonatomic,copy)NSString *status;//投资状态
@property (nonatomic,copy)NSString *isVip;//vip状态
@property (nonatomic,assign)float rate;//年化收益率
@property (nonatomic,copy)NSString *days;//理财天数
@property (nonatomic,assign)float startMoney;//起投金额
@property (nonatomic,assign)float percent;//投资进度

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)ProductWithDict:(NSDictionary *)dict;

@end
