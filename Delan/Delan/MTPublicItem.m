//
//  MTPublicItem.m
//
//  Created by qf  on 15/6/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPublicItem.h"


NSString *const kMTPublicItemNoticeTitle = @"noticeTitle";
NSString *const kMTPublicItemNoticeContent = @"noticeContent";
NSString *const kMTPublicItemImageUrl = @"imageUrl";
NSString *const kMTPublicItemNoticeUrl = @"noticeUrl";
NSString *const kMTPublicItemNoticeId = @"noticeId";
NSString *const kMTPublicItemUrlpath = @"urlpath";
NSString *const kMTPublicItemNoticeDate = @"noticeDate";

@interface MTPublicItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPublicItem

@synthesize noticeTitle = _noticeTitle;
@synthesize noticeContent = _noticeContent;
@synthesize imageUrl = _imageUrl;
@synthesize noticeUrl = _noticeUrl;
@synthesize noticeId = _noticeId;
@synthesize urlpath = _urlpath;
@synthesize noticeDate = _noticeDate;

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
            self.noticeTitle = [self objectOrNilForKey:kMTPublicItemNoticeTitle fromDictionary:dict];
            self.noticeContent = [self objectOrNilForKey:kMTPublicItemNoticeContent fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kMTPublicItemImageUrl fromDictionary:dict];
            self.noticeUrl = [self objectOrNilForKey:kMTPublicItemNoticeUrl fromDictionary:dict];
            self.noticeId = [self objectOrNilForKey:kMTPublicItemNoticeId fromDictionary:dict];
            self.urlpath = [self objectOrNilForKey:kMTPublicItemUrlpath fromDictionary:dict];
		self.noticeDate = [self objectOrNilForKey:kMTPublicItemNoticeDate fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.noticeTitle forKey:kMTPublicItemNoticeTitle];
    [mutableDict setValue:self.noticeContent forKey:kMTPublicItemNoticeContent];
    [mutableDict setValue:self.imageUrl forKey:kMTPublicItemImageUrl];
    [mutableDict setValue:self.noticeUrl forKey:kMTPublicItemNoticeUrl];
    [mutableDict setValue:self.noticeId forKey:kMTPublicItemNoticeId];
    [mutableDict setValue:self.urlpath forKey:kMTPublicItemUrlpath];
	[mutableDict setValue:self.noticeDate forKey:kMTPublicItemNoticeDate];
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

    self.noticeTitle = [aDecoder decodeObjectForKey:kMTPublicItemNoticeTitle];
    self.noticeContent = [aDecoder decodeObjectForKey:kMTPublicItemNoticeContent];
    self.imageUrl = [aDecoder decodeObjectForKey:kMTPublicItemImageUrl];
    self.noticeUrl = [aDecoder decodeObjectForKey:kMTPublicItemNoticeUrl];
    self.noticeId = [aDecoder decodeObjectForKey:kMTPublicItemNoticeId];
    self.urlpath = [aDecoder decodeObjectForKey:kMTPublicItemUrlpath];
	self.noticeDate = [aDecoder decodeObjectForKey:kMTPublicItemNoticeDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_noticeTitle forKey:kMTPublicItemNoticeTitle];
    [aCoder encodeObject:_noticeContent forKey:kMTPublicItemNoticeContent];
    [aCoder encodeObject:_imageUrl forKey:kMTPublicItemImageUrl];
    [aCoder encodeObject:_noticeUrl forKey:kMTPublicItemNoticeUrl];
    [aCoder encodeObject:_noticeId forKey:kMTPublicItemNoticeId];
    [aCoder encodeObject:_urlpath forKey:kMTPublicItemUrlpath];
	[aCoder encodeObject:_noticeDate forKey:kMTPublicItemNoticeDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPublicItem *copy = [[MTPublicItem alloc] init];
    
    if (copy) {

        copy.noticeTitle = [self.noticeTitle copyWithZone:zone];
        copy.noticeContent = [self.noticeContent copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.noticeUrl = [self.noticeUrl copyWithZone:zone];
        copy.noticeId = [self.noticeId copyWithZone:zone];
        copy.urlpath = [self.urlpath copyWithZone:zone];
		copy.noticeDate = [self.noticeDate copyWithZone:zone];
    }
    
    return copy;
}


@end
