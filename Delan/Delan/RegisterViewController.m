//
//  RegisterViewController.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "RegisterViewController.h"
#import "LRTextField.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) LRTextField *userNameTF;
@property (nonatomic,strong) LRTextField *userPasswordTF;
@property (nonatomic,strong) LRTextField *checkPasswordTF;
@property (nonatomic,strong) LRTextField *checkCodeTF;
@property (nonatomic,strong) UIButton *getCheckCodeButton;
@property (nonatomic,strong) UIButton *registerButton;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initUI];
}

- (void)initUI{
	self.view.backgroundColor = RGBCOLOR(245, 245, 245);
	self.navigationItem.title = @"注 册";
	self.navigationController.navigationBar.tintColor = kMainColor;
	//手机号
	_userNameTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, 64+10, kMainScreenWidth-20, 44)];
	_userNameTF.leftImage = [UIImage imageNamed:@"LRUser"];
	_userNameTF.placeholder = @"请输入你的手机号";
	_userNameTF.delegate = self;
	[self.view addSubview:_userNameTF];

	//获取验证码
	_getCheckCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _userNameTF.bottom + 10, 115, 44)];
	_getCheckCodeButton.left = kMainScreenWidth - _getCheckCodeButton.width - 10;
	_getCheckCodeButton.backgroundColor = RGBCOLOR(253, 171, 105);
	[_getCheckCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
	[_getCheckCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_getCheckCodeButton addTarget:self action:@selector(getCheckCode) forControlEvents:UIControlEventTouchDown];
	_getCheckCodeButton.titleLabel.font = kFont14;
	[self.view addSubview:_getCheckCodeButton];
	
	//输入验证码
	_checkCodeTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, _userNameTF.bottom + 10, kMainScreenWidth-_getCheckCodeButton.width - 30, 44)];
	_checkCodeTF.leftImage = [UIImage imageNamed:@"LRCheck"];
	_checkCodeTF.placeholder = @"请输入验证码";
	_checkCodeTF.delegate = self;
	[self.view addSubview:_checkCodeTF];

	//密码
	_userPasswordTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, _checkCodeTF.bottom + 10, kMainScreenWidth-20, 44)];
	_userPasswordTF.leftImage = [UIImage imageNamed:@"LRPassWord"];
	_userPasswordTF.placeholder = @"请输入密码";
	_userPasswordTF.secureTextEntry = YES;
	_userPasswordTF.delegate = self;
	[self.view addSubview:_userPasswordTF];
	
	
	//确认密码
	_checkPasswordTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, _userPasswordTF.bottom + 10, kMainScreenWidth-20, 44)];
	_checkPasswordTF.leftImage = [UIImage imageNamed:@"LRPassWord"];
	_checkPasswordTF.placeholder = @"请确认密码";
	_checkPasswordTF.secureTextEntry = YES;
	_checkPasswordTF.delegate = self;
	[self.view addSubview:_checkPasswordTF];
	
	//提示信息
	UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _checkPasswordTF.bottom + 5, kMainScreenWidth, 20)];
	tipLabel.font = kFont12;
	tipLabel.text = @"密码需6-16位，建议使用字母和数字或符号的组合";
	tipLabel.textAlignment = NSTextAlignmentCenter;
	tipLabel.textColor = [UIColor grayColor];
	[self.view addSubview:tipLabel];
	
	//确认按钮
	_registerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, tipLabel.bottom + 10, kMainScreenWidth - 20, 44)];
	_registerButton.backgroundColor = kMainColor;
	[_registerButton setTitle:@"注 册"  forState:UIControlStateNormal];
	[_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:_registerButton];
	
	UIButton *protocol = [UIButton buttonWithType:UIButtonTypeSystem];
	protocol.frame = CGRectMake(0, _registerButton.bottom + 10, kMainScreenWidth, 20);
	protocol.titleLabel.font = kFont12;
	[protocol setTitle:@"*注册阅读并同意《德岚服务协议》" forState:UIControlStateNormal];
	[protocol addTarget:self action:@selector(showProtocol) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:protocol];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

//获取验证码
- (void)getCheckCode{
	MLOG(@"get CheckCode");
}

//注册用户
- (void)registerUser{
	MLOG(@"register user");
}

//展开协议
- (void)showProtocol{
	MLOG(@"show Protocol");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
