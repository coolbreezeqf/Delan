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
							succ:(SUCCESS_DIC_BLOCK) succ
						 failure:(FAILUREBLOCK) failure{
	NSDictionary *parameters = @{@"token": [UserService sharedUserService].token,
								 @"pageNum": [NSString stringWithFormat:@"%i",pageNum],
								 @"pageSize": [NSString stringWithFormat:@"%i",pageSize]};
	[_manager POST:URL_PublicInformation parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#warning TO DO
		succ(responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(nil,error);
	}];
}

//媒体报道
- (void)getMediaInfoWith:(NSInteger)pageNum andPageSize:(NSInteger)pageSize
					succ:(void(^)(MTMediaHelpInfo* info)) succ
				 failure:(FAILUREBLOCK) failure{
	NSDictionary *parameters = @{@"token": [UserService sharedUserService].token,
								 @"pageNum": [NSString stringWithFormat:@"%i",pageNum],
								 @"pageSize": [NSString stringWithFormat:@"%i",pageSize]};
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

@end
