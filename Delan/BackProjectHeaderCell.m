//
//  BackProjectHeaderCell.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BackProjectHeaderCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation BackProjectHeaderCell

- (void)awakeFromNib {
    self.blueView.layer.borderWidth = 1;
    self.blueView.layer.borderColor = [RGBCOLOR(133.0, 168.0, 221.0)CGColor];
    self.blueView.layer.cornerRadius = 8.0;
    
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.bgView.layer.cornerRadius = 8.0;
}

+ (BackProjectHeaderCell *)headerViewWithTableView:(UITableView *)tableView index:(int)selIndex {
    
    BackProjectHeaderCell * headerView;
    
    NSString *cellName = @"";
    
    if (kScreenWidth == 320) {
        
        cellName = @"BackProjectHeaderCell320";
    }
    else if (kScreenWidth == 375){
        
        cellName = @"BackProjectHeaderCell375";

    }
    else{

        cellName = @"BackProjectHeaderCell414";

    }
    
    headerView = [[[NSBundle mainBundle]loadNibNamed:cellName owner:self options:nil] lastObject];
    if (selIndex == 1) {
        headerView.dsbx.text = @"已收本息";
        headerView.dsbj.text = @"已收本金";
        headerView.dslx.text = @"已收利息";
    }
    
    
    return headerView;
}

@end
