//
//  AccountCenterHeaderTableViewCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCenterHeaderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *AccountCenterBuyNowButton;
@property (strong, nonatomic) IBOutlet UILabel *AccountCenterTotalMoney;
@property (strong, nonatomic) IBOutlet UILabel *AccountCenterRest;
@property (strong, nonatomic) IBOutlet UIButton *AccountCenterRechargeButton;
@property (strong, nonatomic) IBOutlet UIButton *AccountCenterWithdrawalsButton;



@end
