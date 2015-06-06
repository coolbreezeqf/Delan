//
//  MTNetManager.h
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTMediaHelpInfo;

#define URL_PublicInformation [NSString stringWithFormat:@"%@	",HostUrl]
#define URL_GetMediaList [NSString stringWithFormat:@"%@mobile/infomation/getMediaList.json",HostUrl]

#define SUCCESS_DIC_BLOCK      void(^)(NSDictionary* successDict)
#define FAILUREBLOCK      void(^)(NSDictionary *failDict, NSError *error)


@interface MTNetManager : NSObject

//获取公告
- (void)getPublicInformationWith:(NSInteger)pageNum andPageSize:(NSInteger)pageSize
							succ:(SUCCESS_DIC_BLOCK) succ
						 failure:(FAILUREBLOCK) failure;
//获取媒体报道
- (void)getMediaInfoWith:(NSInteger)pageNum andPageSize:(NSInteger)pageSize
					succ:(void(^)(MTMediaHelpInfo* info)) succ
				 failure:(FAILUREBLOCK) failure;

@end
