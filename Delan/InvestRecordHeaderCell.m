//
//  InvestRecordHeaderCell.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestRecordHeaderCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@implementation InvestRecordHeaderCell


- (void)awakeFromNib {
    
    self.blueView.layer.borderWidth = 1;
    self.blueView.layer.borderColor = [RGBCOLOR(133.0, 168.0, 221.0)CGColor];
    self.blueView.layer.cornerRadius = 8.0;
    
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.bgView.layer.cornerRadius = 8.0;
    
    
    
}

+ (InvestRecordHeaderCell *)headerViewWithTableView:(UITableView *)tableView index:(int)selIndex {
    
    InvestRecordHeaderCell * headerView;
    
    NSString *cellName = @"";
    
    if (kScreenWidth == 320) {
        if (selIndex == 0) {
            cellName = @"InvestRecordHeaderCell320";
        }
        else if (selIndex != 0){
            cellName = @"InvestRecordHeaderCellt320";
        }
    }
    else if (kScreenWidth == 375){
        if (selIndex == 0) {
            cellName = @"InvestRecordHeaderCell375";
        }
        else if (selIndex != 0){
            cellName = @"InvestRecordHeaderCellt375";
        }
    }
    else{
        if (selIndex == 0) {
            cellName = @"InvestRecordHeaderCell414";
        }
        else if (selIndex != 0){
            cellName = @"InvestRecordHeaderCellt414";
        }
    }
    
    NSLog(@"%d",selIndex);
    
    headerView = [[[NSBundle mainBundle]loadNibNamed:cellName owner:self options:nil] lastObject];
    if (selIndex == 3) {
        headerView.dsbx.text = @"已收本息";
        headerView.dsbj.text = @"已收本金";
        headerView.dslx.text = @"已收利息";
    }
    

    return headerView;
}

@end
