//
//  MTPItem.h
//
//  Created by qf  on 15/5/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MTPItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *urlpath;
@property (nonatomic, strong) NSString *noticeContent;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *noticeUrl;
@property (nonatomic, assign) double noticeId;
@property (nonatomic, strong) NSString *noticeTitle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
