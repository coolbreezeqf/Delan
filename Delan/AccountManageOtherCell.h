//
//  AccountManageOtherCell.h
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountManageOtherCell : UITableViewCell
@property (nonatomic,strong) UIImageView *myIcon;
@property (nonatomic,strong) UILabel     *myLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
