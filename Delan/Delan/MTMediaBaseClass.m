//
//  MTMediaBaseClass.m
//
//  Created by qf  on 15/6/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTMediaBaseClass.h"
#import "MTMediaData.h"


NSString *const kMTMediaBaseClassMsg = @"msg";
NSString *const kMTMediaBaseClassData = @"data";
NSString *const kMTMediaBaseClassCode = @"code";


@interface MTMediaBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTMediaBaseClass

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
            self.msg = [self objectOrNilForKey:kMTMediaBaseClassMsg fromDictionary:dict];
            self.data = [MTMediaData modelObjectWithDictionary:[dict objectForKey:kMTMediaBaseClassData]];
            self.code = [self objectOrNilForKey:kMTMediaBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kMTMediaBaseClassMsg];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kMTMediaBaseClassData];
    [mutableDict setValue:self.code forKey:kMTMediaBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kMTMediaBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kMTMediaBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kMTMediaBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kMTMediaBaseClassMsg];
    [aCoder encodeObject:_data forKey:kMTMediaBaseClassData];
    [aCoder encodeObject:_code forKey:kMTMediaBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTMediaBaseClass *copy = [[MTMediaBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
