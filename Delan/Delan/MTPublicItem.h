//
//  MTPublicItem.h
//
//  Created by qf  on 15/6/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MTPublicItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *noticeTitle;
@property (nonatomic, strong) NSString *noticeContent;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *noticeUrl;
@property (nonatomic, strong) NSString *noticeId;
@property (nonatomic, strong) NSString *urlpath;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
