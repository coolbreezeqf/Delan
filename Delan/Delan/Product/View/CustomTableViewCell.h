//
//  CustomTableViewCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/23.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ProductCellStatusLine;
@property (strong, nonatomic) IBOutlet UILabel *ProductCellName;
@property (strong, nonatomic) IBOutlet UIImageView *ProductCellBao;
@property (strong, nonatomic) IBOutlet UILabel *ProductCellRate;
@property (strong, nonatomic) IBOutlet UILabel *ProductCellTime;
@property (strong, nonatomic) IBOutlet UILabel *ProductCellMoney;
@property (strong, nonatomic) IBOutlet UIImageView *ProductCellVipStatus;
@property (strong, nonatomic) IBOutlet UIView *ProductCellStatus;


@end
