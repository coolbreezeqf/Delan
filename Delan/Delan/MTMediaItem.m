//
//  MTMediaItem.m
//
//  Created by qf  on 15/6/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTMediaItem.h"


NSString *const kMTMediaItemNoticeContent = @"noticeContent";
NSString *const kMTMediaItemImageUrl = @"imageUrl";
NSString *const kMTMediaItemNoticeUrl = @"noticeUrl";
NSString *const kMTMediaItemNoticeTitle = @"noticeTitle";
NSString *const kMTMediaItemNoticeDate = @"noticeDate";

@interface MTMediaItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTMediaItem

@synthesize noticeContent = _noticeContent;
@synthesize imageUrl = _imageUrl;
@synthesize noticeUrl = _noticeUrl;
@synthesize noticeTitle = _noticeTitle;
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
            self.noticeContent = [self objectOrNilForKey:kMTMediaItemNoticeContent fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kMTMediaItemImageUrl fromDictionary:dict];
            self.noticeUrl = [self objectOrNilForKey:kMTMediaItemNoticeUrl fromDictionary:dict];
            self.noticeTitle = [self objectOrNilForKey:kMTMediaItemNoticeTitle fromDictionary:dict];
		self.noticeDate = [self objectOrNilForKey:kMTMediaItemNoticeDate fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.noticeContent forKey:kMTMediaItemNoticeContent];
    [mutableDict setValue:self.imageUrl forKey:kMTMediaItemImageUrl];
    [mutableDict setValue:self.noticeUrl forKey:kMTMediaItemNoticeUrl];
    [mutableDict setValue:self.noticeTitle forKey:kMTMediaItemNoticeTitle];
	[mutableDict setValue:self.noticeDate forKey:kMTMediaItemNoticeDate];
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

    self.noticeContent = [aDecoder decodeObjectForKey:kMTMediaItemNoticeContent];
    self.imageUrl = [aDecoder decodeObjectForKey:kMTMediaItemImageUrl];
    self.noticeUrl = [aDecoder decodeObjectForKey:kMTMediaItemNoticeUrl];
    self.noticeTitle = [aDecoder decodeObjectForKey:kMTMediaItemNoticeTitle];
	self.noticeDate = [aDecoder decodeObjectForKey:kMTMediaItemNoticeDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_noticeContent forKey:kMTMediaItemNoticeContent];
    [aCoder encodeObject:_imageUrl forKey:kMTMediaItemImageUrl];
    [aCoder encodeObject:_noticeUrl forKey:kMTMediaItemNoticeUrl];
    [aCoder encodeObject:_noticeTitle forKey:kMTMediaItemNoticeTitle];
	[aCoder encodeObject:_noticeDate forKey:kMTMediaItemNoticeDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTMediaItem *copy = [[MTMediaItem alloc] init];
    
    if (copy) {

        copy.noticeContent = [self.noticeContent copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.noticeUrl = [self.noticeUrl copyWithZone:zone];
        copy.noticeTitle = [self.noticeTitle copyWithZone:zone];
		copy.noticeDate = [self.noticeDate copyWithZone:zone];
    }
    
    return copy;
}


@end
