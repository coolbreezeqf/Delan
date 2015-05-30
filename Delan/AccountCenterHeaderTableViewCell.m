//
//  AccountCenterHeaderTableViewCell.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountCenterHeaderTableViewCell.h"
#import "AccountManageViewCell.h"

@implementation AccountCenterHeaderTableViewCell

- (void)awakeFromNib {
    self.AccountCenterRechargeButton.layer.cornerRadius = 10.0;
    self.AccountCenterWithdrawalsButton.layer.cornerRadius = 10.0;
    
    [self.AccountCenterBuyNowButton addTarget:self action:@selector(buyNowAction) forControlEvents:UIControlEventTouchUpInside];
    [self.AccountCenterRechargeButton addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.AccountCenterWithdrawalsButton addTarget:self action:@selector(withdrawalsAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buyNowAction{
    
}

- (void)rechargeAction{
    
}

- (void)withdrawalsAction{
    NSLog(@"提现");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
