//
//  AccountManagePassController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManagePassController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface AccountManagePassController ()

@property (nonatomic,strong) UITextField *nowPassText;

@property (nonatomic,strong) UITextField *npText;

@property (nonatomic,strong) UITextField *npaText;

@property (nonatomic,strong) UIScrollView *rootScrollView;

@end

@implementation AccountManagePassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.rootScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight + 100)];
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.rootScrollView];
    
    UIButton *bindButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindButon setFrame:CGRectMake(20, 270, kScreenWidth - 40, 40)];
    [bindButon setTitle:@"确认修改" forState:UIControlStateNormal];
    [bindButon setBackgroundColor:[UIColor colorWithRed:86.0/255 green:115.0/255 blue:186.0/255 alpha:1.0]];
    [bindButon.layer setCornerRadius:6.0];
    [self.rootScrollView addSubview:bindButon];
    
    UIImageView *safeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 320, 65,10)];
    safeImg.image = [UIImage imageNamed:@"AccountCenterManageBindSafe"];
    [self.rootScrollView addSubview:safeImg];
    
    self.title = @"登录密码";
    self.rootScrollView.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1];
    
    UIButton *hideKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hideKeyBtn setFrame:self.rootScrollView.frame];
    [hideKeyBtn addTarget:self action:@selector(hideKeyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:hideKeyBtn];
    
    [self createView];
}

- (void)hideKeyAction{
    [self.nowPassText resignFirstResponder];
    [self.npText resignFirstResponder];
    [self.npaText resignFirstResponder];
}

- (void)createView{
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 30)];
    accountLabel.text = @"当前账号";
    accountLabel.font = [UIFont systemFontOfSize:14.0];
    [self.rootScrollView addSubview:accountLabel];
    
    UILabel *accountRealLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
    accountRealLabel.text = @"137****1234";
    accountRealLabel.font = [UIFont systemFontOfSize:14.0];
    [self.rootScrollView addSubview:accountRealLabel];
    
    UIView *nowPassView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, kScreenWidth, 50)];
    nowPassView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nowPassLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 30)];
    nowPassLabel.text = @"当前密码";
    nowPassLabel.font = [UIFont systemFontOfSize:14.0];
    [nowPassView addSubview:nowPassLabel];
    
    self.nowPassText = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, 200, 30)];
    self.nowPassText.placeholder = @"请输入当前密码";
    self.nowPassText.secureTextEntry = YES;
    self.nowPassText.font = [UIFont systemFontOfSize:12.0];
    [nowPassView addSubview:self.nowPassText];
    
    [self.rootScrollView addSubview:nowPassView];
    
    UILabel *setNewLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 106, 150, 30)];
    setNewLabel.text = @"设置新的密码";
    setNewLabel.font = [UIFont systemFontOfSize:14.0];
    [self.rootScrollView addSubview:setNewLabel];
    
    UIView *newPassView = [[UIView alloc] initWithFrame:CGRectMake(0, 146, kScreenWidth, 100)];
    newPassView.backgroundColor = [UIColor whiteColor];
    [self.rootScrollView addSubview:newPassView];
    
    UILabel *newPassLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    newPassLabel.font = [UIFont systemFontOfSize:14.0];
    newPassLabel.text = @"新密码";
    [newPassView addSubview:newPassLabel];
    
    self.npText = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 180, 30)];
    self.npText.font = [UIFont systemFontOfSize:12.0];
    self.npText.placeholder = @"请设置您的新密码";
    self.npText.secureTextEntry = YES;
    [newPassView addSubview:self.npText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    [newPassView addSubview:line];
    
    UILabel *newPassAgainLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 60, 30)];
    newPassAgainLabel.text = @"再次输入";
    newPassAgainLabel.font = [UIFont systemFontOfSize:14.0];
    [newPassView addSubview:newPassAgainLabel];
    
    self.npaText = [[UITextField alloc] initWithFrame:CGRectMake(80, 60, 180, 30)];
    self.npaText.font = [UIFont systemFontOfSize:12.0];
    self.npaText.placeholder = @"请再次输入您的新密码";
    self.npaText.secureTextEntry = YES;
    [newPassView addSubview:self.npaText];
    
}

@end
