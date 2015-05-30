//
//  AccountManageModel.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManageModel : NSObject

@property(nonatomic,copy)NSString *bindingEmail;//绑定的email
@property(nonatomic,copy)NSString *bindingNum;//绑定的电话号码
@property(nonatomic,copy)NSString *emPersonName;//紧急联系人名
@property(nonatomic,copy)NSString *emPersonNum;//紧急联系人号码
@property(nonatomic,copy)NSString *emPersonRe;//紧急联系人关系
@property(nonatomic,assign)int isBindingEmail;//是否绑定邮箱
@property(nonatomic,assign)int isBindingPhone;//是否绑定手机号
@property(nonatomic,assign)int isEmPerson;//是否添加紧急联系人
@property(nonatomic,assign)int isKnow;//是否实名认证
@property(nonatomic,copy)NSString *knowId;//实名认证身份证号
@property(nonatomic,copy)NSString *knowName;//实名认证姓名
@property(nonatomic,copy)NSString *userId;//用户id
@property(nonatomic,copy)NSString *userName;//用户名
@property(nonatomic,copy)NSString *userPhoneNum;//用户手机号
@property(nonatomic,assign)int userStatus;//用户类型

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)AccountManageModel:(NSDictionary *)dict;

@end