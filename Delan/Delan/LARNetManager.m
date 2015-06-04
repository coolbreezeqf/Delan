//
//  LARNetManager.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "LARNetManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "UserDataModels.h"
@interface LARNetManager ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation LARNetManager

- (instancetype)init{
	if (self = [super init]) {
		_manager = [AFHTTPRequestOperationManager manager];
	}
	return self;
}

- (void)getMobileCodeWith:(NSString *)mobile
					 succ:(SUCCESSBLOCK) succ
				  failure:(FAILUREBLOCK) failure{
	NSString *url = [NSString stringWithFormat:@"%@user/getMobileCode.json",HostUrl];
	MLOG(@"request: %@",url);
	[_manager POST:url parameters:@{@"mobile": mobile} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[MBProgressHUD hideHUD];
		MLOG(@"msg: %@",responseObject);
		if ([[responseObject objectForKey:@"code"] integerValue]) {
			[MBProgressHUD showSuccess:@"验证码已发送，请注意查收"];
		}else{
			[MBProgressHUD showError:[responseObject objectForKey:@"msg"]];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[MBProgressHUD hideHUD];
		NSLog(@"Error:%@",error);
	}];
}

//忘记密码


//注册
- (void)registerWith:(NSDictionary *)info
				succ:(SUCCESSBLOCK) succ
			 failure:(FAILUREBLOCK) failure{
	NSString *url = [NSString stringWithFormat:@"%@mobile/user/register.json",HostUrl];
	MLOG(@"request: %@", url);
	[_manager POST:url parameters:info success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[MBProgressHUD hideHUD];
		if ([[responseObject objectForKey:@"code"] integerValue]) {
			succ([[responseObject objectForKey:@"data"] objectForKey:@"userInfo"]);
		}else{
			[MBProgressHUD showError:[responseObject objectForKey:@"msg"]];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[MBProgressHUD hideHUD];
		failure(nil, error);
	}];
}

//登录
- (void)userLogin:(NSDictionary *)info
			 succ:(SUCCESSBLOCK) succ
			 failure:(FAILUREBLOCK) failure{
	NSString *url = [NSString stringWithFormat:@"%@mobile/user/login.json", HostUrl];
	MLOG(@"request: %@", url);
	[_manager POST:url parameters:info success:^(AFHTTPRequestOperation *operation, id responseObject) {
		MLOG(@"response: %@",responseObject);
		UserBaseClass *userbase = [UserBaseClass modelObjectWithDictionary:responseObject];
		if ([userbase.code integerValue]) {
			succ([userbase.data.userInfo dictionaryRepresentation]);
		}else{
			failure(responseObject,nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(nil,error);
		MLOG(@"%@",error);
	}];
}



@end
