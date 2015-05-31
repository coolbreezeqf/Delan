//
//  UserService.h
//  Delan
//
//  Created by qf on 15/5/31.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserUserInfo.h"
@interface UserService : NSObject

@property (nonatomic,assign) BOOL isLogin;		//登录状态
@property (nonatomic,strong) NSString *mobile;	//手机号
@property (nonatomic,strong) NSString *token;	//token
@property (nonatomic,strong) UserUserInfo *userInfo; //userInfo
+ (UserService *)sharedUserService;

- (void)userLoginWithInfo:(NSDictionary *)info;
- (void)userLogout;
@end
