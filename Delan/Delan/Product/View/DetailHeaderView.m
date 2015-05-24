//
//  DetailHeaderView.m
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "DetailHeaderView.h"
#import "PercentCircleView.h"

#define iPhoneSmallWidth 320
#define iPhoneMiddleWidth 375
#define iPhoneBigWidth 414

@implementation DetailHeaderView

+ (DetailHeaderView *)headerViewWithTableView:(UITableView *)tableView {
    
    DetailHeaderView * headerView;
    //这里进行屏幕尺寸的适配(根据不同手机屏幕尺寸选择加载不同的xib视图)
    //iPhone4、4s、5、5s、5c
    if (kMainScreenWidth == iPhoneSmallWidth) {
        headerView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeaderViewFor320" owner:self options:nil] lastObject];
    }
    //iPhone6
    else if (kMainScreenWidth == iPhoneMiddleWidth) {
        headerView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeaderViewFor375" owner:self options:nil] lastObject];
    }
    //iPhone6Plusx
    else if (kMainScreenWidth == iPhoneBigWidth) {
        headerView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeaderViewFor414" owner:self options:nil] lastObject];
    }
    
    return headerView;
}


@end
