//
//  UserService.m
//  Delan
//
//  Created by qf on 15/5/31.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "UserService.h"

@interface UserService ()
@property (nonatomic, strong) NSString *userFilePath;
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
		_userInfo = nil;
		[self loadLocalUserInfo];
	}
	return self;
}

- (void)loadLocalUserInfo{
	if ([[NSFileManager defaultManager] fileExistsAtPath:self.userFilePath]) {
		NSDictionary *userInfo = [NSDictionary dictionaryWithContentsOfFile:self.userFilePath];
		NSString *token = [userInfo objectForKey:@"token"];
		if (token && token.length ) {
			[self loadUserInfoWith:userInfo];
		}
	}
}

- (void)loadUserInfoWith:(NSDictionary *)info{
	_isLogin = YES;
	self.mobile = info[@"mobile"];
	self.token = @"xxxxxx";//info[@"token"];
	self.userInfo = [UserUserInfo modelObjectWithDictionary:info[@"userInfo"]];
}

- (void)userLoginWithInfo:(NSDictionary *)info{
	[self loadUserInfoWith:info];
	[self writeUserInfoToFile];
}

- (void)userLogout{
	_isLogin = NO;
	self.token = @"";
	[self writeUserInfoToFile];
}

- (void)writeUserInfoToFile{
	NSDictionary *dic = @{@"mobile": self.mobile,
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
