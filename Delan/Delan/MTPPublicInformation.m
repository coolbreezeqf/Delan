//
//  MTPPublicInformation.m
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MTPPublicInformation.h"
#import "MTPItem.h"


NSString *const kMTPPublicInformationTotalNum = @"totalNum";
NSString *const kMTPPublicInformationNoticeNum = @"noticeNum";
NSString *const kMTPPublicInformationItem = @"item";
NSString *const kMTPPublicInformationPageNum = @"pageNum";


@interface MTPPublicInformation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MTPPublicInformation

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
            self.totalNum = [[self objectOrNilForKey:kMTPPublicInformationTotalNum fromDictionary:dict] doubleValue];
            self.noticeNum = [[self objectOrNilForKey:kMTPPublicInformationNoticeNum fromDictionary:dict] doubleValue];
    NSObject *receivedMTPItem = [dict objectForKey:kMTPPublicInformationItem];
    NSMutableArray *parsedMTPItem = [NSMutableArray array];
    if ([receivedMTPItem isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMTPItem) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMTPItem addObject:[MTPItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMTPItem isKindOfClass:[NSDictionary class]]) {
       [parsedMTPItem addObject:[MTPItem modelObjectWithDictionary:(NSDictionary *)receivedMTPItem]];
    }

    self.item = [NSArray arrayWithArray:parsedMTPItem];
            self.pageNum = [[self objectOrNilForKey:kMTPPublicInformationPageNum fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalNum] forKey:kMTPPublicInformationTotalNum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.noticeNum] forKey:kMTPPublicInformationNoticeNum];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItem] forKey:kMTPPublicInformationItem];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageNum] forKey:kMTPPublicInformationPageNum];

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

    self.totalNum = [aDecoder decodeDoubleForKey:kMTPPublicInformationTotalNum];
    self.noticeNum = [aDecoder decodeDoubleForKey:kMTPPublicInformationNoticeNum];
    self.item = [aDecoder decodeObjectForKey:kMTPPublicInformationItem];
    self.pageNum = [aDecoder decodeDoubleForKey:kMTPPublicInformationPageNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_totalNum forKey:kMTPPublicInformationTotalNum];
    [aCoder encodeDouble:_noticeNum forKey:kMTPPublicInformationNoticeNum];
    [aCoder encodeObject:_item forKey:kMTPPublicInformationItem];
    [aCoder encodeDouble:_pageNum forKey:kMTPPublicInformationPageNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    MTPPublicInformation *copy = [[MTPPublicInformation alloc] init];
    
    if (copy) {

        copy.totalNum = self.totalNum;
        copy.noticeNum = self.noticeNum;
        copy.item = [self.item copyWithZone:zone];
        copy.pageNum = self.pageNum;
    }
    
    return copy;
}


@end
