//
//  UserData.m
//
//  Created by qf  on 15/5/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserData.h"
#import "UserUserInfo.h"


NSString *const kUserDataUserInfo = @"userInfo";


@interface UserData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserData

@synthesize userInfo = _userInfo;


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
            self.userInfo = [UserUserInfo modelObjectWithDictionary:[dict objectForKey:kUserDataUserInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.userInfo dictionaryRepresentation] forKey:kUserDataUserInfo];

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

    self.userInfo = [aDecoder decodeObjectForKey:kUserDataUserInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userInfo forKey:kUserDataUserInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserData *copy = [[UserData alloc] init];
    
    if (copy) {

        copy.userInfo = [self.userInfo copyWithZone:zone];
    }
    
    return copy;
}


@end
