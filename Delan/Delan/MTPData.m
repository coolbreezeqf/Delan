//
//  MTPData.m
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPData.h"
#import "MTPPublicInformation.h"


NSString *const kMTPDataPublicInformation = @"publicInformation";


@interface MTPData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPData

@synthesize publicInformation = _publicInformation;


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
            self.publicInformation = [MTPPublicInformation modelObjectWithDictionary:[dict objectForKey:kMTPDataPublicInformation]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.publicInformation dictionaryRepresentation] forKey:kMTPDataPublicInformation];

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

    self.publicInformation = [aDecoder decodeObjectForKey:kMTPDataPublicInformation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_publicInformation forKey:kMTPDataPublicInformation];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPData *copy = [[MTPData alloc] init];
    
    if (copy) {

        copy.publicInformation = [self.publicInformation copyWithZone:zone];
    }
    
    return copy;
}


@end
