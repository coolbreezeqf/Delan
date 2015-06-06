//
//  MTMediaData.m
//
//  Created by qf  on 15/6/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTMediaData.h"
#import "MTMediaHelpInfo.h"


NSString *const kMTMediaDataHelpInfo = @"helpInfo";


@interface MTMediaData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTMediaData

@synthesize helpInfo = _helpInfo;


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
            self.helpInfo = [MTMediaHelpInfo modelObjectWithDictionary:[dict objectForKey:kMTMediaDataHelpInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.helpInfo dictionaryRepresentation] forKey:kMTMediaDataHelpInfo];

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

    self.helpInfo = [aDecoder decodeObjectForKey:kMTMediaDataHelpInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_helpInfo forKey:kMTMediaDataHelpInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTMediaData *copy = [[MTMediaData alloc] init];
    
    if (copy) {

        copy.helpInfo = [self.helpInfo copyWithZone:zone];
    }
    
    return copy;
}


@end
