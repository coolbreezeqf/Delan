//
//  BackProjectHeaderCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackProjectHeaderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dsbx;
@property (strong, nonatomic) IBOutlet UILabel *waitGet;
@property (strong, nonatomic) IBOutlet UILabel *dsbj;
@property (strong, nonatomic) IBOutlet UILabel *dslx;
@property (strong, nonatomic) IBOutlet UILabel *waitGeyMoney;
@property (strong, nonatomic) IBOutlet UILabel *waitGetInterest;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UIView *blueView;

+ (BackProjectHeaderCell *)headerViewWithTableView:(UITableView *)tableView index:(int)selIndex;

@end
