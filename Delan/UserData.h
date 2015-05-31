//
//  UserData.h
//
//  Created by qf  on 15/5/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserUserInfo;

@interface UserData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) UserUserInfo *userInfo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
