//
//  AccountManageViewCell.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageViewCell.h"

@implementation AccountManageViewCell

- (void)awakeFromNib {
    
    self.headImg.layer.borderWidth = 0.1;
    self.headImg.layer.cornerRadius = 30;
    self.headImg.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
