//
//  MTPublicData.h
//
//  Created by qf  on 15/6/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTPublicPublicInformation;

@interface MTPublicData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) MTPublicPublicInformation *publicInformation;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
