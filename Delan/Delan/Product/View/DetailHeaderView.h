//
//  DetailHeaderView.h
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PercentCircleView;

@interface DetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *yearRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@property (weak, nonatomic) IBOutlet UILabel *saledLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UIImageView *vipIconLabel;

@property (weak, nonatomic) IBOutlet PercentCircleView *typePercentView;

+ (DetailHeaderView *)headerViewWithTableView:(UITableView *)tableView;

@end
