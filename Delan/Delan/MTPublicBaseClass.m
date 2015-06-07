//
//  MTPublicBaseClass.m
//
//  Created by qf  on 15/6/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPublicBaseClass.h"
#import "MTPublicData.h"


NSString *const kMTPublicBaseClassMsg = @"msg";
NSString *const kMTPublicBaseClassData = @"data";
NSString *const kMTPublicBaseClassCode = @"code";


@interface MTPublicBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPublicBaseClass

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
            self.msg = [self objectOrNilForKey:kMTPublicBaseClassMsg fromDictionary:dict];
            self.data = [MTPublicData modelObjectWithDictionary:[dict objectForKey:kMTPublicBaseClassData]];
            self.code = [self objectOrNilForKey:kMTPublicBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kMTPublicBaseClassMsg];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kMTPublicBaseClassData];
    [mutableDict setValue:self.code forKey:kMTPublicBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kMTPublicBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kMTPublicBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kMTPublicBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kMTPublicBaseClassMsg];
    [aCoder encodeObject:_data forKey:kMTPublicBaseClassData];
    [aCoder encodeObject:_code forKey:kMTPublicBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPublicBaseClass *copy = [[MTPublicBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
