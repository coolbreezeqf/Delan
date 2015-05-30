//
//  MTPItem.m
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPItem.h"


NSString *const kMTPItemUrlpath = @"urlpath";
NSString *const kMTPItemNoticeContent = @"noticeContent";
NSString *const kMTPItemImageUrl = @"imageUrl";
NSString *const kMTPItemNoticeUrl = @"noticeUrl";
NSString *const kMTPItemNoticeId = @"noticeId";
NSString *const kMTPItemNoticeTitle = @"noticeTitle";


@interface MTPItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPItem

@synthesize urlpath = _urlpath;
@synthesize noticeContent = _noticeContent;
@synthesize imageUrl = _imageUrl;
@synthesize noticeUrl = _noticeUrl;
@synthesize noticeId = _noticeId;
@synthesize noticeTitle = _noticeTitle;


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
            self.urlpath = [self objectOrNilForKey:kMTPItemUrlpath fromDictionary:dict];
            self.noticeContent = [self objectOrNilForKey:kMTPItemNoticeContent fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kMTPItemImageUrl fromDictionary:dict];
            self.noticeUrl = [self objectOrNilForKey:kMTPItemNoticeUrl fromDictionary:dict];
            self.noticeId = [[self objectOrNilForKey:kMTPItemNoticeId fromDictionary:dict] doubleValue];
            self.noticeTitle = [self objectOrNilForKey:kMTPItemNoticeTitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.urlpath forKey:kMTPItemUrlpath];
    [mutableDict setValue:self.noticeContent forKey:kMTPItemNoticeContent];
    [mutableDict setValue:self.imageUrl forKey:kMTPItemImageUrl];
    [mutableDict setValue:self.noticeUrl forKey:kMTPItemNoticeUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.noticeId] forKey:kMTPItemNoticeId];
    [mutableDict setValue:self.noticeTitle forKey:kMTPItemNoticeTitle];

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

    self.urlpath = [aDecoder decodeObjectForKey:kMTPItemUrlpath];
    self.noticeContent = [aDecoder decodeObjectForKey:kMTPItemNoticeContent];
    self.imageUrl = [aDecoder decodeObjectForKey:kMTPItemImageUrl];
    self.noticeUrl = [aDecoder decodeObjectForKey:kMTPItemNoticeUrl];
    self.noticeId = [aDecoder decodeDoubleForKey:kMTPItemNoticeId];
    self.noticeTitle = [aDecoder decodeObjectForKey:kMTPItemNoticeTitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_urlpath forKey:kMTPItemUrlpath];
    [aCoder encodeObject:_noticeContent forKey:kMTPItemNoticeContent];
    [aCoder encodeObject:_imageUrl forKey:kMTPItemImageUrl];
    [aCoder encodeObject:_noticeUrl forKey:kMTPItemNoticeUrl];
    [aCoder encodeDouble:_noticeId forKey:kMTPItemNoticeId];
    [aCoder encodeObject:_noticeTitle forKey:kMTPItemNoticeTitle];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPItem *copy = [[MTPItem alloc] init];
    
    if (copy) {

        copy.urlpath = [self.urlpath copyWithZone:zone];
        copy.noticeContent = [self.noticeContent copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.noticeUrl = [self.noticeUrl copyWithZone:zone];
        copy.noticeId = self.noticeId;
        copy.noticeTitle = [self.noticeTitle copyWithZone:zone];
    }
    
    return copy;
}


@end
