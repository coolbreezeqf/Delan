//
//  ProductDetail.h
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetail : NSObject

//第一页详情属性
@property (nonatomic, assign) int productID;

@property (nonatomic, copy) NSString * productName;

//1:车贷宝 2:房贷宝
@property (nonatomic, assign) int productType;

//1:投资中 2:已还款 3:已售罄
@property (nonatomic, assign) int status;

//是否Vip 0:不是Vip 1:是Vip
@property (nonatomic, assign) int isVip;

@property (nonatomic, assign) CGFloat yearRate;

@property (nonatomic, assign) int deadline;

@property (nonatomic, assign) CGFloat saledPercent;

@property (nonatomic, assign) CGFloat available;

@property (nonatomic, assign) CGFloat total;

@property (nonatomic, assign) int minPay;

@property (nonatomic, copy) NSString * repayType;

@property (nonatomic, copy) NSString * repayDay;

//第二页更多详情
@property (nonatomic, assign) int buyCounts;

@property (nonatomic, assign) int trades;

@property (nonatomic, copy) NSString * state;

@property (nonatomic, assign) int historys;

@property (nonatomic, copy) NSString * topRate;

@property (nonatomic, assign) int advance;

@property (nonatomic, copy) NSMutableString * descParagraph;

//资料图片
@property (nonatomic, copy) NSString * pictureInfoUrl;

//法律意见书
@property (nonatomic, copy) NSString * lawBookUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)ProductDetailWithDict:(NSDictionary *)dict;

@end
