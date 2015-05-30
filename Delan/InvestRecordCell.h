//
//  InvestRecordCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestRecordCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *investName;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *investMoney;
@property (strong, nonatomic) IBOutlet UILabel *getMoney;
@property (strong, nonatomic) IBOutlet UILabel *investTime;
@property (strong, nonatomic) IBOutlet UILabel *investStatus;


@end
