//
//  AccountManageEmergencyController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageEmergencyController.h"
#import "PersonController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface AccountManageEmergencyController ()

@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *numText;

@property (nonatomic,strong) UIScrollView *rootScrollView;

@end

@implementation AccountManageEmergencyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = @"请选择您与联系人的关系";
    
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.rootScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.rootScrollView];
    
    UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [keyBtn setFrame:self.rootScrollView.frame];
    [keyBtn addTarget:self action:@selector(hideKey) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:keyBtn];
    
    self.rootScrollView.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    self.title = @"紧急联系人";
    
    [self createPhoneView];
    
    UIButton *bindButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindButon setFrame:CGRectMake(20, 216, kScreenWidth - 40, 40)];
    [bindButon setTitle:@"确认添加" forState:UIControlStateNormal];
    [bindButon setBackgroundColor:[UIColor colorWithRed:86.0/255 green:115.0/255 blue:186.0/255 alpha:1.0]];
    [bindButon.layer setCornerRadius:6.0];
    [self.rootScrollView addSubview:bindButon];
    
    UIImageView *safeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 286, 65,10)];
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
    bindLabel.text = @"添加紧急联系人";
    [self.rootScrollView addSubview:bindLabel];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 150)];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    numberLabel.font = [UIFont systemFontOfSize:14.0];
    numberLabel.text = @"姓名";
    [phoneView addSubview:numberLabel];
    
    self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 180, 30)];
    self.nameText.font = [UIFont systemFontOfSize:12.0];
    self.nameText.placeholder = @"请输入联系人姓名";
    [phoneView addSubview:self.nameText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    [phoneView addSubview:line];
    
    UILabel *yzmLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 45, 30)];
    yzmLabel.text = @"手机号";
    yzmLabel.font = [UIFont systemFontOfSize:14.0];
    [phoneView addSubview:yzmLabel];
    
    self.numText = [[UITextField alloc] initWithFrame:CGRectMake(80, 60, 180, 30)];
    self.numText.font = [UIFont systemFontOfSize:12.0];
    self.numText.keyboardType = UIKeyboardTypeNumberPad;
    self.numText.placeholder = @"请输入联系人手机号";
    [phoneView addSubview:self.numText];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    [phoneView addSubview:line1];
    
    UILabel *choseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 60, 30)];
    choseLabel.text = @"关系";
    choseLabel.font = [UIFont systemFontOfSize:14.0];
    [phoneView addSubview:choseLabel];
    
    self.choseLabel1 = [[UITextField alloc] initWithFrame:CGRectMake(80, 110, 180, 30)];
    self.choseLabel1.placeholder = self.person;
    self.choseLabel1.enabled = NO;
    self.choseLabel1.font = [UIFont systemFontOfSize:12.0];
    [phoneView addSubview:self.choseLabel1];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 115, 10, 20)];
    [im setImage:[UIImage imageNamed:@"AccountManageER"]];
    [phoneView addSubview:im];
    
    UIButton *choseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [choseBtn setFrame:CGRectMake(0, 100, kScreenWidth, 50)];
    [choseBtn addTarget:self action:@selector(selectPerson) forControlEvents:UIControlEventTouchUpInside];
    [phoneView addSubview:choseBtn];
    
    [self.rootScrollView addSubview:phoneView];
}

- (void)selectPerson{
    PersonController *person = [[PersonController alloc] init];
    [self.navigationController pushViewController:person animated:YES];
}

@end
