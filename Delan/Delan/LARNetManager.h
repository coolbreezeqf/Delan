//
//  LARNetManager.h
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCCESSBLOCK      void(^)(NSDictionary* successDict)
#define FAILUREBLOCK      void(^)(NSDictionary *failDict, NSError *error)

@interface LARNetManager : NSObject
- (void)getMobileCodeWith:(NSString *)mobile
					 succ:(SUCCESSBLOCK) succ
				  failure:(FAILUREBLOCK) failure;

- (void)registerWith:(NSDictionary *)info
				succ:(SUCCESSBLOCK) succ
			 failure:(FAILUREBLOCK) failure;

- (void)userLogin:(NSDictionary *)info
			 succ:(SUCCESSBLOCK) succ
			 failure:(FAILUREBLOCK) failure;

@end
