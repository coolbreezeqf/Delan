//
//  MTPBaseClass.m
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPBaseClass.h"
#import "MTPData.h"


NSString *const kMTPBaseClassMsg = @"msg";
NSString *const kMTPBaseClassData = @"data";
NSString *const kMTPBaseClassCode = @"code";


@interface MTPBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPBaseClass

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
            self.msg = [self objectOrNilForKey:kMTPBaseClassMsg fromDictionary:dict];
            self.data = [MTPData modelObjectWithDictionary:[dict objectForKey:kMTPBaseClassData]];
            self.code = [[self objectOrNilForKey:kMTPBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kMTPBaseClassMsg];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kMTPBaseClassData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kMTPBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kMTPBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kMTPBaseClassData];
    self.code = [aDecoder decodeDoubleForKey:kMTPBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kMTPBaseClassMsg];
    [aCoder encodeObject:_data forKey:kMTPBaseClassData];
    [aCoder encodeDouble:_code forKey:kMTPBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPBaseClass *copy = [[MTPBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
