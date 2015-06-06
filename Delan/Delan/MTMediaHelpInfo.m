//
//  MTMediaHelpInfo.m
//
//  Created by qf  on 15/6/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTMediaHelpInfo.h"
#import "MTMediaItem.h"


NSString *const kMTMediaHelpInfoTotalNum = @"totalNum";
NSString *const kMTMediaHelpInfoNoticeNum = @"noticeNum";
NSString *const kMTMediaHelpInfoItem = @"item";
NSString *const kMTMediaHelpInfoPageNum = @"pageNum";


@interface MTMediaHelpInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTMediaHelpInfo

@synthesize totalNum = _totalNum;
@synthesize noticeNum = _noticeNum;
@synthesize item = _item;
@synthesize pageNum = _pageNum;


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
            self.totalNum = [self objectOrNilForKey:kMTMediaHelpInfoTotalNum fromDictionary:dict];
            self.noticeNum = [self objectOrNilForKey:kMTMediaHelpInfoNoticeNum fromDictionary:dict];
    NSObject *receivedMTMediaItem = [dict objectForKey:kMTMediaHelpInfoItem];
    NSMutableArray *parsedMTMediaItem = [NSMutableArray array];
    if ([receivedMTMediaItem isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMTMediaItem) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMTMediaItem addObject:[MTMediaItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMTMediaItem isKindOfClass:[NSDictionary class]]) {
       [parsedMTMediaItem addObject:[MTMediaItem modelObjectWithDictionary:(NSDictionary *)receivedMTMediaItem]];
    }

    self.item = [NSArray arrayWithArray:parsedMTMediaItem];
            self.pageNum = [self objectOrNilForKey:kMTMediaHelpInfoPageNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalNum forKey:kMTMediaHelpInfoTotalNum];
    [mutableDict setValue:self.noticeNum forKey:kMTMediaHelpInfoNoticeNum];
    NSMutableArray *tempArrayForItem = [NSMutableArray array];
    for (NSObject *subArrayObject in self.item) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItem addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItem addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItem] forKey:kMTMediaHelpInfoItem];
    [mutableDict setValue:self.pageNum forKey:kMTMediaHelpInfoPageNum];

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

    self.totalNum = [aDecoder decodeObjectForKey:kMTMediaHelpInfoTotalNum];
    self.noticeNum = [aDecoder decodeObjectForKey:kMTMediaHelpInfoNoticeNum];
    self.item = [aDecoder decodeObjectForKey:kMTMediaHelpInfoItem];
    self.pageNum = [aDecoder decodeObjectForKey:kMTMediaHelpInfoPageNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalNum forKey:kMTMediaHelpInfoTotalNum];
    [aCoder encodeObject:_noticeNum forKey:kMTMediaHelpInfoNoticeNum];
    [aCoder encodeObject:_item forKey:kMTMediaHelpInfoItem];
    [aCoder encodeObject:_pageNum forKey:kMTMediaHelpInfoPageNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTMediaHelpInfo *copy = [[MTMediaHelpInfo alloc] init];
    
    if (copy) {

        copy.totalNum = [self.totalNum copyWithZone:zone];
        copy.noticeNum = [self.noticeNum copyWithZone:zone];
        copy.item = [self.item copyWithZone:zone];
        copy.pageNum = [self.pageNum copyWithZone:zone];
    }
    
    return copy;
}


@end
