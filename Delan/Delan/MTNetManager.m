//
//  MTNetManager.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "MTNetManager.h"
#import "AFNetworking.h"
#import "MediaDataModels.h"
#import "PublicDataModels.h"
#import "MBProgressHUD+NJ.h"
@interface MTNetManager()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation MTNetManager

- (instancetype)init{
	if (self = [super init]) {
		_manager = [AFHTTPRequestOperationManager manager];
	}
	return self;
}

- (void)getPublicInformationWith:(NSInteger)pageNum andPageSize:(NSInteger)pageSize
							succ:(void(^)(MTPublicPublicInformation* info)) succ
						 failure:(FAILUREBLOCK) failure{
	NSDictionary *parameters = @{@"token": [UserService sharedUserService].token?[UserService sharedUserService].token: @"xxx",
								 @"pageNum": [NSString stringWithFormat:@"%i",pageNum],
								 @"pageSize": [NSString stringWithFormat:@"%i",pageSize]};
	MLOG(@"post: %@",URL_PublicInformation);
	[_manager POST:URL_PublicInformation parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		MTPublicBaseClass *base = [MTPublicBaseClass modelObjectWithDictionary:responseObject];
		if ([base.code integerValue]) {
			succ(base.data.publicInformation);
		}else{
			failure(responseObject,nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(nil,error);
	}];
}

//媒体报道
- (void)getMediaInfoWith:(NSInteger)pageNum andPageSize:(NSInteger)pageSize
					succ:(void(^)(MTMediaHelpInfo* info)) succ
				 failure:(FAILUREBLOCK) failure{
	//warning 这里的token有必要吗？
	NSDictionary *parameters = @{@"token": @"xxx",//[UserService sharedUserService].token,
								 @"pageNum": [NSString stringWithFormat:@"%i",pageNum],
								 @"pageSize": [NSString stringWithFormat:@"%i",pageSize]};
	MLOG(@"post: %@",URL_GetMediaList);
	[_manager POST:URL_GetMediaList parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		MTMediaBaseClass *base = [MTMediaBaseClass modelObjectWithDictionary:responseObject];
		if ([base.msg isEqualToString:@""]) {
			succ(base.data.helpInfo);
		}else{
//			[MBProgressHUD showError:@"加载失败"];
			failure(responseObject,nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(nil, error);
	}];
}

- (void)postFeedBackWith:(NSString *) feedback
					succ:(SUCCESSBLOCK) succ
				 failure:(FAILUREBLOCK) failure{
	NSString *url = [NSString stringWithFormat:@"%@mobile/infomation/postFeedBack.json",HostUrl];
	UserService *user = [UserService sharedUserService];
	NSDictionary *parameters = @{@"token": user.isLogin? user.token: @"xxxxx",
								 @"username": user.isLogin? user.mobile: @"13777777777",
								 @"feedback": feedback
								 };
	[_manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		succ(responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(nil,error);
	}];
}

@end
