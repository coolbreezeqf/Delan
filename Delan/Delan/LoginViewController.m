//
//  LoginViewController.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"
#import "LRTextField.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) LRTextField *userNameTF;
@property (nonatomic,strong) LRTextField *userPasswordTF;
@property (nonatomic,strong) LRTextField *checkCodeTF;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *getCheckCodeButton;
@property (nonatomic,strong) UIButton *forgetButton;
@property (nonatomic,strong) UIButton *registerButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initUI];
}

- (void) initUI{
	self.view.backgroundColor = RGBCOLOR(245, 245, 245);
	self.navigationItem.title = @"登 录";
	self.navigationController.navigationBar.barTintColor = kMainColor;
	
	[self setLeftButton:nil title:@"取消" target:self action:@selector(cleanLogin)];

	//手机号tf
	_userNameTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, 64+10, kMainScreenWidth-20, 44)];
	_userNameTF.leftImage = [UIImage imageNamed:@"LRUser"];
	_userNameTF.placeholder = @"请输入您绑定的手机号";
	_userNameTF.delegate = self;
	[self.view addSubview:_userNameTF];
	
	//密码tf
	_userPasswordTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, _userNameTF.bottom+15, kMainScreenWidth-20, 44)];
	_userPasswordTF.leftImage = [UIImage imageNamed:@"LRPassWord"];
	_userPasswordTF.placeholder = @"请输入密码";
	_userPasswordTF.secureTextEntry = YES;
	_userPasswordTF.delegate = self;
	[self.view addSubview:_userPasswordTF];
	
	//获取验证码button
	_getCheckCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _userPasswordTF.bottom + 15, 115, 44)];
	_getCheckCodeButton.left = kMainScreenWidth - _getCheckCodeButton.width - 10;
	_getCheckCodeButton.backgroundColor = RGBCOLOR(253, 171, 105);
	[_getCheckCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
	[_getCheckCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_getCheckCodeButton addTarget:self action:@selector(getCheckCode) forControlEvents:UIControlEventTouchDown];
	_getCheckCodeButton.titleLabel.font = kFont14;
	[self.view addSubview:_getCheckCodeButton];
	
	//验证码tf
	_checkCodeTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, _userPasswordTF.bottom + 15, kMainScreenWidth-_getCheckCodeButton.width - 30, 44)];
	_checkCodeTF.leftImage = [UIImage imageNamed:@"LRCheck"];
	_checkCodeTF.placeholder = @"请输入验证码";
	_checkCodeTF.delegate = self;
	[self.view addSubview:_checkCodeTF];
	
	//登陆button
	_loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, _checkCodeTF.bottom + 15, kMainScreenWidth - 20, 44)];
	[_loginButton setBackgroundColor:kMainColor];
	[_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
	[_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:_loginButton];
	
	_forgetButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
	[_forgetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	[_forgetButton addTarget:self action:@selector(showForgetView) forControlEvents:UIControlEventTouchDown];
	_forgetButton.frame = CGRectMake(10, _loginButton.bottom + 5, 80, 25);
	[self.view addSubview:_forgetButton];
	
	_registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_registerButton setTitle:@"注册" forState:UIControlStateNormal];
	[_registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	[_registerButton addTarget:self action:@selector(showRegisterView) forControlEvents:UIControlEventTouchDown];
	_registerButton.frame = CGRectMake(0, _loginButton.bottom + 5, 50, 25);
	_registerButton.left = kMainScreenWidth - _registerButton.width - 10;
	[self.view addSubview:_registerButton];
}
- (void)cleanLogin{
	[self.navigationController dismissViewControllerAnimated:YES completion:^{
		
	}];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

//登录
- (void)login{
	
}

// 获取验证码
- (void)getCheckCode{
	
}

//push 注册用户界面
- (void)showRegisterView{
	[self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

//push 忘记密码界面
- (void)showForgetView{
	[self.navigationController pushViewController:[[ForgetViewController alloc] init] animated:YES];
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
