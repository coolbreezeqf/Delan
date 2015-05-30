//
//  InvestRecordHeaderCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestRecordHeaderCell : UIView
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) IBOutlet UILabel *getMoney;
@property (strong, nonatomic) IBOutlet UILabel *waitGetMoney;
@property (strong, nonatomic) IBOutlet UILabel *waitGetGood;
@property (strong, nonatomic) IBOutlet UILabel *totalInvest;
@property (strong, nonatomic) IBOutlet UILabel *rest;
@property (strong, nonatomic) IBOutlet UILabel *dsbx;
@property (strong, nonatomic) IBOutlet UILabel *dsbj;
@property (strong, nonatomic) IBOutlet UILabel *dslx;

@property (nonatomic,assign) int secIndex;

+ (InvestRecordHeaderCell *)headerViewWithTableView:(UITableView *)tableView index:(int)selIndex;

@end
