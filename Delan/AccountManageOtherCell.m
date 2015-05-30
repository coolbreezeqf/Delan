//
//  AccountManageOtherCell.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageOtherCell.h"

@implementation AccountManageOtherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _myIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
        _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 200, 30)];
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49, [[UIScreen mainScreen] bounds].size.width, 1)];
        underLine.backgroundColor = [UIColor colorWithRed:233.0/255 green:234.0/255 blue:235.0/255 alpha:1.0];
        [self addSubview:_myIcon];
        [self addSubview:_myLabel];
        [self addSubview:underLine];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
