//
//  LARNetManager.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "LARNetManager.h"
#import "AFNetworking.h"
@implementation LARNetManager

//- (void)commitOrderWith:(HubOrder *)order succ:(void (^)(NSDictionary *))succ failure:(void (^)())failure{
//	NSString *url;
//	kHubRequestUrl(@"commitOrder.ashx", url);
//	NSDictionary *dic = [order dictionaryRepresentation];
//	[NetManager requestWith:dic url:url method:@"POST" operationKey:nil parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
//		succ(successDict);
//	} failure:^(NSDictionary *failDict, NSError *error) {
//		failure();
//	}];
//	
//}

- (void)getMobileCodeWith:(NSString *)mobile succ:(void (^)(NSDictionary *))succ failure:(void (^)())failure{
	NSString *url = [NSString stringWithFormat:@"%@/user/getMobileCode.json",HostUrl];
//	[NetManager requestWith:@{@"mobile": mobile} url:url method:@"POST" operationKey:nil parameEncoding:AFNetworking succ:<#^(NSDictionary *successDict)success#> failure:<#^(NSDictionary *failDict, NSError *error)failure#>]
}


@end
