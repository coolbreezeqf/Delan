//
//  MTPData.h
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTPPublicInformation;

@interface MTPData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) MTPPublicInformation *publicInformation;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
