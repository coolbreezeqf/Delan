//
//  UserService.h
//  Delan
//
//  Created by qf on 15/5/31.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserUserInfo.h"
#import "LARNetManager.h"

@interface UserService : NSObject

@property (nonatomic,assign) BOOL isLogin;		//登录状态
@property (nonatomic,strong) NSString *mobile;	//手机号
@property (nonatomic,strong) NSString *token;	//token
@property (nonatomic,strong) UserUserInfo *userInfo; //userInfo
+ (UserService *)sharedUserService;

//弹出登录视图
- (void)showLoginView;

//登录
- (void)loginWith:(NSString *)userMobile andPassword:(NSString *)pwd succ:(SUCCESSBLOCK) succ
		  failure:(FAILUREBLOCK) failure;

//重载用户信息
//sessionId过期时可以调用它重新获取
- (void)reLoadUserInfoWithSucc:(SUCCESSBLOCK) succ
				   failure:(FAILUREBLOCK) failure;
//登出
- (void)userLogout;
@end
