//
//  UserUserInfo.h
//
//  Created by qf  on 15/5/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserUserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userInfoIdentifier;
@property (nonatomic, strong) NSString *apiStatus;
@property (nonatomic, strong) NSString *apiUserId;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *apiUserCustId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
