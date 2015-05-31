//
//  UserUserInfo.m
//
//  Created by qf  on 15/5/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserUserInfo.h"


NSString *const kUserUserInfoId = @"id";
NSString *const kUserUserInfoApiStatus = @"apiStatus";
NSString *const kUserUserInfoApiUserId = @"apiUserId";
NSString *const kUserUserInfoSessionId = @"sessionId";
NSString *const kUserUserInfoApiUserCustId = @"apiUserCustId";
NSString *const kUserUserInfoName = @"name";
NSString *const kUserUserInfoUserType = @"userType";


@interface UserUserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserUserInfo

@synthesize userInfoIdentifier = _userInfoIdentifier;
@synthesize apiStatus = _apiStatus;
@synthesize apiUserId = _apiUserId;
@synthesize sessionId = _sessionId;
@synthesize apiUserCustId = _apiUserCustId;
@synthesize name = _name;
@synthesize userType = _userType;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userInfoIdentifier = [self objectOrNilForKey:kUserUserInfoId fromDictionary:dict];
            self.apiStatus = [self objectOrNilForKey:kUserUserInfoApiStatus fromDictionary:dict];
            self.apiUserId = [self objectOrNilForKey:kUserUserInfoApiUserId fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kUserUserInfoSessionId fromDictionary:dict];
            self.apiUserCustId = [self objectOrNilForKey:kUserUserInfoApiUserCustId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kUserUserInfoName fromDictionary:dict];
            self.userType = [self objectOrNilForKey:kUserUserInfoUserType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userInfoIdentifier forKey:kUserUserInfoId];
    [mutableDict setValue:self.apiStatus forKey:kUserUserInfoApiStatus];
    [mutableDict setValue:self.apiUserId forKey:kUserUserInfoApiUserId];
    [mutableDict setValue:self.sessionId forKey:kUserUserInfoSessionId];
    [mutableDict setValue:self.apiUserCustId forKey:kUserUserInfoApiUserCustId];
    [mutableDict setValue:self.name forKey:kUserUserInfoName];
    [mutableDict setValue:self.userType forKey:kUserUserInfoUserType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userInfoIdentifier = [aDecoder decodeObjectForKey:kUserUserInfoId];
    self.apiStatus = [aDecoder decodeObjectForKey:kUserUserInfoApiStatus];
    self.apiUserId = [aDecoder decodeObjectForKey:kUserUserInfoApiUserId];
    self.sessionId = [aDecoder decodeObjectForKey:kUserUserInfoSessionId];
    self.apiUserCustId = [aDecoder decodeObjectForKey:kUserUserInfoApiUserCustId];
    self.name = [aDecoder decodeObjectForKey:kUserUserInfoName];
    self.userType = [aDecoder decodeObjectForKey:kUserUserInfoUserType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userInfoIdentifier forKey:kUserUserInfoId];
    [aCoder encodeObject:_apiStatus forKey:kUserUserInfoApiStatus];
    [aCoder encodeObject:_apiUserId forKey:kUserUserInfoApiUserId];
    [aCoder encodeObject:_sessionId forKey:kUserUserInfoSessionId];
    [aCoder encodeObject:_apiUserCustId forKey:kUserUserInfoApiUserCustId];
    [aCoder encodeObject:_name forKey:kUserUserInfoName];
    [aCoder encodeObject:_userType forKey:kUserUserInfoUserType];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserUserInfo *copy = [[UserUserInfo alloc] init];
    
    if (copy) {

        copy.userInfoIdentifier = [self.userInfoIdentifier copyWithZone:zone];
        copy.apiStatus = [self.apiStatus copyWithZone:zone];
        copy.apiUserId = [self.apiUserId copyWithZone:zone];
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.apiUserCustId = [self.apiUserCustId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.userType = [self.userType copyWithZone:zone];
    }
    
    return copy;
}


@end
