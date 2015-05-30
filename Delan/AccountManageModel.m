//
//  AccountManageModel.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageModel.h"

@implementation AccountManageModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        self.bindingEmail = dict[@"bindingEmail"];
        self.bindingNum = dict[@"bindingNum"];
        self.emPersonName = dict[@"emPersonName"];
        self.emPersonNum = dict[@"emPersonNum"];
        self.emPersonRe = dict[@"emPersonRe"];
        self.isBindingEmail = [dict[@"isBindingEmail"] intValue];
        self.isBindingPhone = [dict[@"isBindingPhone"] intValue];
        self.isEmPerson = [dict[@"isEmPerson"] intValue];
        self.isKnow = [dict[@"isKnow"] intValue];
        self.knowId = dict[@"knowId"];
        self.knowName = dict[@"knowName"];
        self.userId = dict[@"userId"];
        self.userName = dict[@"userName"];
        self.userPhoneNum = dict[@"userPhoneNum"];
        self.userStatus = [dict[@"userStatus"] intValue];
    }
    return self;
}


+ (instancetype)AccountManageModel:(NSDictionary *)dict {
    
    return [[AccountManageModel alloc] initWithDict:dict];
}

@end
