//
//  InvestedUser.h
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestedUser : NSObject

@property (nonatomic, copy) NSString * phoneNum;

@property (nonatomic, assign) int investMoney;

@property (nonatomic, copy) NSString * investTime;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)investedUserWithDict:(NSDictionary *)dict;

@end
