//
//  AccountManageViewCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountManageViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userPhone;
@property (strong, nonatomic) IBOutlet UILabel *userType;
@property (strong, nonatomic) IBOutlet UIImageView *phoneIcon;
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) IBOutlet UIImageView *knowIcon;
@property (strong, nonatomic) IBOutlet UIImageView *passwordIcon;

@end
