//
//  BankCardModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/3.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

@property (nonatomic,copy)NSString *bankIcon;//银行图标
@property (nonatomic,copy)NSString *bankName;//银行名
@property (nonatomic,copy)NSString *cardCode;//尾号

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)BankCardModel:(NSDictionary *)dict;


@end
