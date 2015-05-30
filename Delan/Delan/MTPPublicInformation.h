//
//  MTPPublicInformation.h
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MTPPublicInformation : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double totalNum;
@property (nonatomic, assign) double noticeNum;
@property (nonatomic, strong) NSArray *item;
@property (nonatomic, assign) double pageNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
