//
//  MyVipController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "MyVipController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface MyVipController ()

@end

@implementation MyVipController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的VIP";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *rootScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 64)];
    rootScroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 64);
    
    UIImageView *vipImg = [[UIImageView alloc] init];
    [vipImg setFrame:CGRectMake(kScreenWidth / 2 - 50, 20, 100, 100)];
    vipImg.image = [UIImage imageNamed:@"AccountCenterMyVipN"];
    [rootScroll addSubview:vipImg];
    
    UILabel *vipStatus = [[UILabel alloc ] initWithFrame:CGRectMake(vipImg.frame.origin.x - 20, 140, 150, 30)];
    vipStatus.text = @"您还未开通VIP会员";
    vipStatus.textAlignment = NSTextAlignmentCenter;
    vipStatus.textColor = RGBCOLOR(135.0, 171.0, 225.0);
    vipStatus.font = [UIFont systemFontOfSize:14.0];
    [rootScroll addSubview:vipStatus];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setFrame:CGRectMake(20, kScreenHeight - 200, kScreenWidth - 40, 50)];
    sureBtn.backgroundColor = RGBCOLOR(135.0, 171.0, 225.0);
    sureBtn.layer.cornerRadius = 8.0;
    [sureBtn setTitle:@"立即开通" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rootScroll addSubview:sureBtn];
    
    UIImageView *safeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, sureBtn.frame.origin.y + 70, 65,10)];
    safeImg.image = [UIImage imageNamed:@"AccountCenterManageBindSafe"];
    [rootScroll addSubview:safeImg];
    
    [self.view addSubview:rootScroll];
}


@end
