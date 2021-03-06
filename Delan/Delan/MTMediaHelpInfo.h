//
//  MTMediaHelpInfo.h
//
//  Created by qf  on 15/6/5
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MTMediaHelpInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *totalNum;
@property (nonatomic, strong) NSString *noticeNum;
@property (nonatomic, strong) NSArray *item;
@property (nonatomic, strong) NSString *pageNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
