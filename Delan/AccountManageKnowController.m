//
//  AccountManageKnowController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageKnowController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface AccountManageKnowController ()

@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *numText;

@property (nonatomic,strong) UIScrollView *rootScrollView;

@end

@implementation AccountManageKnowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.rootScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.rootScrollView];
    
    UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [keyBtn setFrame:self.rootScrollView.frame];
    [keyBtn addTarget:self action:@selector(hideKey) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:keyBtn];
    
    self.rootScrollView.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    self.title = @"身份认证";
    
    [self createPhoneView];
    
    UILabel *a = [[UILabel alloc] initWithFrame:CGRectMake(20, 156, 300, 20)];
    a.font = [UIFont systemFontOfSize:12.0];
    a.textColor = [UIColor orangeColor];
    a.text = @"请填写真实信息,身份认证核实后该信息不可更改";
    [self.rootScrollView addSubview:a];
    
    UIButton *bindButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindButon setFrame:CGRectMake(20, 186, kScreenWidth - 40, 40)];
    [bindButon setTitle:@"确认认证" forState:UIControlStateNormal];
    [bindButon setBackgroundColor:[UIColor colorWithRed:86.0/255 green:115.0/255 blue:186.0/255 alpha:1.0]];
    [bindButon.layer setCornerRadius:6.0];
    [self.rootScrollView addSubview:bindButon];
    
    UIImageView *safeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 256, 65,10)];
    safeImg.image = [UIImage imageNamed:@"AccountCenterManageBindSafe"];
    [self.rootScrollView addSubview:safeImg];
}

- (void)hideKey{
    [self.nameText resignFirstResponder];
    [self.numText resignFirstResponder];
}

- (void)createPhoneView{
    
    UILabel *bindLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 30)];
    bindLabel.font = [UIFont systemFontOfSize:14.0];
    bindLabel.text = @"您的信息";
    [self.rootScrollView addSubview:bindLabel];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 100)];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    numberLabel.font = [UIFont systemFontOfSize:14.0];
    numberLabel.text = @"姓名";
    [phoneView addSubview:numberLabel];
    
    self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 180, 30)];
    self.nameText.font = [UIFont systemFontOfSize:12.0];
    self.nameText.placeholder = @"请输入您的真实姓名";
    [phoneView addSubview:self.nameText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    [phoneView addSubview:line];
    
    UILabel *yzmLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 45, 30)];
    yzmLabel.text = @"身份证";
    yzmLabel.font = [UIFont systemFontOfSize:14.0];
    [phoneView addSubview:yzmLabel];
    
    self.numText = [[UITextField alloc] initWithFrame:CGRectMake(80, 60, 180, 30)];
    self.numText.font = [UIFont systemFontOfSize:12.0];
    self.numText.keyboardType = UIKeyboardTypeNumberPad;
    self.numText.placeholder = @"请输入您的真实身份证号";
    [phoneView addSubview:self.numText];
    
    [self.rootScrollView addSubview:phoneView];
}

@end
