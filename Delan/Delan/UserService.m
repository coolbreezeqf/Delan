//
//  UserService.m
//  Delan
//
//  Created by qf on 15/5/31.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "UserService.h"
#import "RootNavgationController.h"
#import "LoginViewController.h"
@interface UserService ()
@property (nonatomic, strong) NSString *userFilePath;
@property (nonatomic, strong) NSString *password;
@end

@implementation UserService

static UserService *userService = nil;

- (NSString *)userFilePath{
	if (!_userFilePath) {
		NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docPath = storeFilePath[0];
		_userFilePath = [docPath stringByAppendingPathComponent:@"user.plist"];
	}
	return _userFilePath;
}

- (instancetype)init{
	if (self = [super init]) {
		_isLogin = NO;
		_mobile = nil;
		_token = nil;
		_password = nil;
		_userInfo = nil;
		[self loadLocalUserInfo];
	}
	return self;
}

//加载上次登录的信息
- (void)loadLocalUserInfo{
	if ([[NSFileManager defaultManager] fileExistsAtPath:self.userFilePath]) {
		NSDictionary *userInfo = [NSDictionary dictionaryWithContentsOfFile:self.userFilePath];
		NSString *token = [userInfo objectForKey:@"token"];
		if (token && token.length ) {
			[self loadUserInfoWith:userInfo];
		}
	}
}

//载入用户信息
- (void)loadUserInfoWith:(NSDictionary *)info{
	_isLogin = YES;
	self.mobile = info[@"mobile"];
	self.token = @"xxxxxx";
	self.password = info[@"password"];
	self.userInfo = [UserUserInfo modelObjectWithDictionary:info[@"userInfo"]];
}

//弹出登录视图
- (void)showLoginView{
	RootNavgationController *nav = [[RootNavgationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
	[kAppDelegate.tabBar presentViewController:nav animated:YES completion:^{
	}];
}

//登录
- (void)loginWith:(NSString *)userMobile andPassword:(NSString *)pwd succ:(SUCCESSBLOCK) succ
		  failure:(FAILUREBLOCK) failure{
	LARNetManager *manager = [[LARNetManager alloc] init];
	NSDictionary *dic = @{@"mobile": userMobile,
						  @"password": pwd};
	[manager userLogin:dic succ:^(NSDictionary *successDict) {
		NSDictionary *dic = @{@"mobile": userMobile,
							  @"password": pwd,
							  @"userInfo": successDict};
		[[UserService sharedUserService] userLoginWithInfo:dic];
		succ(successDict);
	} failure:^(NSDictionary *failDict, NSError *error) {
		failure(failDict,error);
	}];
}

//重新加载用户信息
- (void)reLoadUserInfo{
	[self loginWith:self.mobile andPassword:self.password succ:^(NSDictionary *successDict) {
		//登陆成功
	} failure:^(NSDictionary *failDict, NSError *error) {
		self.isLogin = NO;
		[self showLoginView];
	}];
}

//自动登录
- (void)userLoginWithInfo:(NSDictionary *)info{
	[self loadUserInfoWith:info];
	[self writeUserInfoToFile];
}

//登出
- (void)userLogout{
	_isLogin = NO;
	self.token = @"";
	[self writeUserInfoToFile];
}

//写入文件
- (void)writeUserInfoToFile{
	NSDictionary *dic = @{@"mobile": self.mobile,
						  @"password": self.password,
						  @"token": self.token,
						  @"userInfo": [self.userInfo dictionaryRepresentation]};
	[dic writeToFile:self.userFilePath atomically:YES];
}

+ (UserService *)sharedUserService{
	@synchronized(self){
		if (userService == nil) {
			userService = [[UserService alloc] init];
		}
	}
	return userService;
}

- (id)copyWithZone:(NSZone *)zone{
	return self;
}

@end
