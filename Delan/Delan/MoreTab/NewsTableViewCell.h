//
//  NewsTableViewCell.h
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *content;

+ (NSInteger)heightWithContent:(NSString *)content;
@end
