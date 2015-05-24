//
//  ProductDetail.h
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetail : NSObject

@property (nonatomic, assign) int type;

@property (nonatomic, assign) CGFloat yearRate;

@property (nonatomic, assign) int deadline;

@property (nonatomic, assign) CGFloat saledPercent;

@property (nonatomic, assign) CGFloat saled;

@property (nonatomic, assign) CGFloat total;

@property (nonatomic, assign) int minPay;

@property (nonatomic, copy) NSString * repayType;

@property (nonatomic, copy) NSString * repayDay;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)ProductDetailWithDict:(NSDictionary *)dict;

@end
