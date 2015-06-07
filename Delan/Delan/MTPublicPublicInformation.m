//
//  MTPublicPublicInformation.m
//
//  Created by qf  on 15/6/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPublicPublicInformation.h"
#import "MTPublicItem.h"


NSString *const kMTPublicPublicInformationTotalNum = @"totalNum";
NSString *const kMTPublicPublicInformationNoticeNum = @"noticeNum";
NSString *const kMTPublicPublicInformationItem = @"item";
NSString *const kMTPublicPublicInformationPageNum = @"pageNum";


@interface MTPublicPublicInformation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPublicPublicInformation

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
            self.totalNum = [self objectOrNilForKey:kMTPublicPublicInformationTotalNum fromDictionary:dict];
            self.noticeNum = [self objectOrNilForKey:kMTPublicPublicInformationNoticeNum fromDictionary:dict];
    NSObject *receivedMTPublicItem = [dict objectForKey:kMTPublicPublicInformationItem];
    NSMutableArray *parsedMTPublicItem = [NSMutableArray array];
    if ([receivedMTPublicItem isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMTPublicItem) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMTPublicItem addObject:[MTPublicItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMTPublicItem isKindOfClass:[NSDictionary class]]) {
       [parsedMTPublicItem addObject:[MTPublicItem modelObjectWithDictionary:(NSDictionary *)receivedMTPublicItem]];
    }

    self.item = [NSArray arrayWithArray:parsedMTPublicItem];
            self.pageNum = [self objectOrNilForKey:kMTPublicPublicInformationPageNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalNum forKey:kMTPublicPublicInformationTotalNum];
    [mutableDict setValue:self.noticeNum forKey:kMTPublicPublicInformationNoticeNum];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItem] forKey:kMTPublicPublicInformationItem];
    [mutableDict setValue:self.pageNum forKey:kMTPublicPublicInformationPageNum];

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

    self.totalNum = [aDecoder decodeObjectForKey:kMTPublicPublicInformationTotalNum];
    self.noticeNum = [aDecoder decodeObjectForKey:kMTPublicPublicInformationNoticeNum];
    self.item = [aDecoder decodeObjectForKey:kMTPublicPublicInformationItem];
    self.pageNum = [aDecoder decodeObjectForKey:kMTPublicPublicInformationPageNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalNum forKey:kMTPublicPublicInformationTotalNum];
    [aCoder encodeObject:_noticeNum forKey:kMTPublicPublicInformationNoticeNum];
    [aCoder encodeObject:_item forKey:kMTPublicPublicInformationItem];
    [aCoder encodeObject:_pageNum forKey:kMTPublicPublicInformationPageNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPublicPublicInformation *copy = [[MTPublicPublicInformation alloc] init];
    
    if (copy) {

        copy.totalNum = [self.totalNum copyWithZone:zone];
        copy.noticeNum = [self.noticeNum copyWithZone:zone];
        copy.item = [self.item copyWithZone:zone];
        copy.pageNum = [self.pageNum copyWithZone:zone];
    }
    
    return copy;
}


@end
