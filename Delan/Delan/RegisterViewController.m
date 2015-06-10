//
//  RegisterViewController.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "RegisterViewController.h"
#import "LRTextField.h"
#import "MBProgressHUD+NJ.h"
#import "LARNetManager.h"
#import "DLWebViewController.h"
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

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
	self.view.backgroundColor = RGBCOLOR(245, 245, 245);
	self.navigationItem.title = @"注 册";
	self.navigationController.navigationBar.barTintColor = kMainColor;
	
	[self setLeftButton:[UIImage imageNamed:@"DLBackButton2"] title:nil target:self action:@selector(back) rect:CGRectMake(0, 0, 22, 22)];
	
	//手机号
	_userNameTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, 64+10, kMainScreenWidth-20, 44)];
	_userNameTF.leftImage = [UIImage imageNamed:@"LRUser"];
	_userNameTF.placeholder = @"请输入你的手机号";
	_userNameTF.delegate = self;
	_userNameTF.keyboardType = UIKeyboardTypeNumberPad;
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
	_checkCodeTF.keyboardType = UIKeyboardTypeNumberPad;
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
	tipLabel.text = @"密码需6-16位，使用字母和数字的组合";
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

- (void)time:(id)sender{
	static int timeCnt = 60;
	timeCnt--;
	[_getCheckCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重发",timeCnt] forState:UIControlStateNormal];
	
	if (timeCnt == 0) {
		[self abledCheckCodeBt];
		[(NSTimer *)sender invalidate];
		timeCnt = 60;
	}
}

- (void)unabledCheckCodeBt{
	[_getCheckCodeButton setBackgroundColor:[UIColor lightGrayColor]];
	_getCheckCodeButton.enabled = NO;
	[_getCheckCodeButton setTitle:@"60秒后重发" forState:UIControlStateNormal];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
	[timer fire];
}

- (void)abledCheckCodeBt{
	[_getCheckCodeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
	[_getCheckCodeButton setBackgroundColor:RGBCOLOR(253, 171, 105)];
	_getCheckCodeButton.enabled = YES;
}

//获取验证码
- (void)getCheckCode{
	if (self.userNameTF.text.length != 11) {
		[MBProgressHUD showError:@"请输入正确的手机号"];
		return;
	}
	
	[MBProgressHUD showMessage:@"正在发送验证码"];
	LARNetManager *netmanager = [[LARNetManager alloc] init];
	[netmanager getMobileCodeWith:_userNameTF.text succ:^(NSDictionary *successDict) {
		[MBProgressHUD hideHUD];
		[MBProgressHUD showSuccess:@"已发送，请注意查收"];
		[self unabledCheckCodeBt];
		MLOG(@"success");
	} failure:^(NSDictionary *failDict, NSError *error) {
		[MBProgressHUD hideHUD];
		if (failDict) {
			[MBProgressHUD showError:[failDict objectForKey:@"msg"]];
		}
		if (error) {
			[MBProgressHUD showError:@"网络错误或请求失败"];
		}
		[self abledCheckCodeBt];
	}];
}

//判断密码格式是否符合规范
- (BOOL)checkUpPassword:(NSString *)str
{
	NSString *      regex = @"(^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$)";
	NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:str];
}

//注册用户
- (void)registerUser{
	if (self.userNameTF.text.length != 11) {
		[MBProgressHUD showError:@"请输入正确的手机号"];
		return;
	}
	if ([self.checkCodeTF.text isEqualToString:@""]) {
		[MBProgressHUD showError:@"请输入验证码"];
		return;
	}
	if (![self checkUpPassword:self.userPasswordTF.text]) {
		[MBProgressHUD showError:@"密码格式不符合规范"];
		return;
	}
	if (![self.checkPasswordTF.text isEqualToString:self.userPasswordTF.text]) {
		[MBProgressHUD showError:@"两次输入的密码不同"];
		return;
	}
	
	[MBProgressHUD showMessage:@"请稍后..."];
	// 注册请求
	LARNetManager *netManager = [[LARNetManager alloc] init];
	
	NSDictionary *userInfo = @{@"mobile": _userNameTF.text,
							   @"password": _userPasswordTF.text,
							   @"smsCode": _checkCodeTF.text};
	[netManager registerWith:userInfo succ:^(NSDictionary *successDict) {
		[MBProgressHUD showSuccess:@"注册成功"];
		[UserService sharedUserService].mobile = [successDict objectForKey:@"username"];
//		MLOG(@"successDic: %@", successDict);
		[self.navigationController popViewControllerAnimated:YES];
	} failure:^(NSDictionary *failDict, NSError *error) {
		[MBProgressHUD showError:@"网络错误或服务器异常"];
		MLOG(@"%@", error);
	}];
}

//展开协议
- (void)showProtocol{
	
	DLWebViewController *wvc = [[DLWebViewController alloc] initWithUrl:DLProtocolUrl];
	[self.navigationController pushViewController:wvc animated:YES];
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
