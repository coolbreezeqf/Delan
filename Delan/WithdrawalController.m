//
//  WithdrawalController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "WithdrawalController.h"
#import "AFNetworking.h"
#import "WithdrawalWebController.h"
#import "MBProgressHUD+NJ.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface WithdrawalController ()

@property (nonatomic,strong)UIScrollView *rootScrollView;
@property (nonatomic,strong)UITextField *numberText;
@property (nonatomic,strong)UIView *phoneView;

@end

@implementation WithdrawalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueAction) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.rootScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.rootScrollView];
    
    UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [keyBtn setFrame:self.rootScrollView.frame];
    [keyBtn addTarget:self action:@selector(hideKey) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:keyBtn];
    
    self.rootScrollView.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    self.title = @"申请提现";
    
    [self createPhoneView];
    
    UILabel *restLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 70, 30)];
    restLabel.text = @"可提现金额:";
    restLabel.font = [UIFont systemFontOfSize:12.0];
    [self.rootScrollView addSubview:restLabel];
    
    UILabel *rest = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, self.rest.length * 10, 30)];
    rest.text = self.rest;
    rest.font = [UIFont systemFontOfSize:12.0];
    rest.textColor = [UIColor redColor];
    [self.rootScrollView addSubview:rest];
    
    UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(rest.frame.size.width + rest.frame.origin.x, 70, 20, 30)];
    yuan.text = @"元";
    yuan.font = [UIFont systemFontOfSize:12.0];
    [self.rootScrollView addSubview:yuan];
    
    
    UIButton *bindButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindButon setFrame:CGRectMake(20, 116, kScreenWidth - 40, 40)];
    [bindButon setTitle:@"确认充值" forState:UIControlStateNormal];
    [bindButon addTarget:self action:@selector(sureBinding) forControlEvents:UIControlEventTouchUpInside];
    [bindButon setBackgroundColor:[UIColor colorWithRed:86.0/255 green:115.0/255 blue:186.0/255 alpha:1.0]];
    [bindButon.layer setCornerRadius:6.0];
    [self.rootScrollView addSubview:bindButon];
    
    UIImageView *safeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 176, 65,10)];
    safeImg.image = [UIImage imageNamed:@"AccountCenterManageBindSafe"];
    [self.rootScrollView addSubview:safeImg];
}

#pragma mark 充值按钮事件
- (void)sureBinding{
    WithdrawalWebController *web = [[WithdrawalWebController alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)hideKey{
    [self.numberText resignFirstResponder];
}


- (void)createPhoneView{
    
    
    self.phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 50)];
    self.phoneView.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 45, 30)];
    numberLabel.font = [UIFont systemFontOfSize:14.0];
    numberLabel.text = @"金额";
    [self.phoneView addSubview:numberLabel];
    
    self.numberText = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 180, 30)];
    self.numberText.font = [UIFont systemFontOfSize:12.0];
    [self.numberText addTarget:self action:@selector(valueAction) forControlEvents:UIControlEventValueChanged];
    self.numberText.keyboardType = UIKeyboardTypeNumberPad;
    self.numberText.placeholder = @"请输入充值金额";
    [self.phoneView addSubview:self.numberText];
    
    [self.rootScrollView addSubview:self.phoneView];
}

- (void)valueAction{
    if ([self.rest intValue] < [self.numberText.text intValue]) {
        [MBProgressHUD showError:@"提现金额不得大于余额"];
        self.numberText.text = self.rest;
        return;
    }
}

@end
