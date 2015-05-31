//
//  UserBaseClass.m
//
//  Created by qf  on 15/5/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserBaseClass.h"
#import "UserData.h"


NSString *const kUserBaseClassMsg = @"msg";
NSString *const kUserBaseClassData = @"data";
NSString *const kUserBaseClassCode = @"code";


@interface UserBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserBaseClass

@synthesize msg = _msg;
@synthesize data = _data;
@synthesize code = _code;


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
            self.msg = [self objectOrNilForKey:kUserBaseClassMsg fromDictionary:dict];
            self.data = [UserData modelObjectWithDictionary:[dict objectForKey:kUserBaseClassData]];
            self.code = [self objectOrNilForKey:kUserBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kUserBaseClassMsg];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kUserBaseClassData];
    [mutableDict setValue:self.code forKey:kUserBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kUserBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kUserBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kUserBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kUserBaseClassMsg];
    [aCoder encodeObject:_data forKey:kUserBaseClassData];
    [aCoder encodeObject:_code forKey:kUserBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserBaseClass *copy = [[UserBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
