//
//  MTMediaData.h
//
//  Created by qf  on 15/6/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTMediaHelpInfo;

@interface MTMediaData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) MTMediaHelpInfo *helpInfo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
