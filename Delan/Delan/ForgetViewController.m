//
//  ForgetViewController.m
//  Delan
//
//  Created by qf on 15/5/31.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ForgetViewController.h"
#import "LRTextField.h"
#import "MBProgressHUD+NJ.h"
#import "LARNetManager.h"
@interface ForgetViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) LRTextField *userNameTF; //手机号码
@property (nonatomic, strong) LRTextField *checkCodeTF; //验证码
@property (nonatomic, strong) UIButton *getCheckCodeBt; //获取验证码按钮
//@property (nonatomic, strong) UIButton *nextStep;	//下一步
@property (nonatomic, strong) LRTextField *userPasswordTF; //密码
@property (nonatomic, strong) LRTextField *checkPasswordTF; //验证密码
@property (nonatomic, strong) UIButton *doneBt;	//完成按钮

@end

@implementation ForgetViewController

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
	self.navigationItem.title = @"忘记密码";
//	self.navigationController.navigationBar.tintColor = kMainColor;
	
	[self setLeftButton:[UIImage imageNamed:@"DLBackButton2"] title:nil target:self action:@selector(back) rect:CGRectMake(0, 0, 22, 22)];
	
	// 手机号
	_userNameTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, 64+10, kMainScreenWidth-20, 44)];
	_userNameTF.leftImage = [UIImage imageNamed:@"LRUser"];
	_userNameTF.placeholder = @"请输入你的手机号";
	_userNameTF.delegate = self;
	_userNameTF.keyboardType = UIKeyboardTypeNumberPad;
	[self.view addSubview:_userNameTF];
	
	
	//获取验证码button
	_getCheckCodeBt = [[UIButton alloc] initWithFrame:CGRectMake(0, _userNameTF.bottom + 15, 115, 44)];
	_getCheckCodeBt.left = kMainScreenWidth - _getCheckCodeBt.width - 10;
	_getCheckCodeBt.backgroundColor = RGBCOLOR(253, 171, 105);
	[_getCheckCodeBt setTitle:@"获取验证码" forState:UIControlStateNormal];
	[_getCheckCodeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_getCheckCodeBt addTarget:self action:@selector(getCheckCode) forControlEvents:UIControlEventTouchDown];
	_getCheckCodeBt.titleLabel.font = kFont14;
	[self.view addSubview:_getCheckCodeBt];
	
	//验证码tf
	_checkCodeTF = [[LRTextField alloc] initWithFrame:CGRectMake(10, _userNameTF.bottom + 15, kMainScreenWidth-_getCheckCodeBt.width - 30, 44)];
	_checkCodeTF.leftImage = [UIImage imageNamed:@"LRCheck"];
	_checkCodeTF.placeholder = @"请输入验证码";
	_checkCodeTF.delegate = self;
	_checkCodeTF.keyboardType = UIKeyboardTypeNumberPad;
	[self.view addSubview:_checkCodeTF];
	
//	_nextStep = [[UIButton alloc] initWithFrame:CGRectMake(10, _checkCodeTF.bottom + 20, kMainScreenWidth-20, 44)];
//	_nextStep.backgroundColor = kMainColor;
//	[_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
//	[_nextStep addTarget:self action:@selector(nextstep) forControlEvents:UIControlEventTouchDown];
//	[self.view addSubview:_nextStep];
	
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
	
	UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, _checkPasswordTF.bottom+5, kMainScreenWidth, 20)];
	tipLb.font = kFont11;
	tipLb.text = @"密码需6-16位，建议使用字母和数字的组合";
	tipLb.textColor = [UIColor grayColor];
	tipLb.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:tipLb];

	
	_doneBt = [[UIButton alloc] initWithFrame:CGRectMake(10, _checkPasswordTF.bottom + 40, kMainScreenWidth-20, 44)];
	_doneBt.backgroundColor = kMainColor;
	[_doneBt setTitle:@"完成" forState:UIControlStateNormal];
	[_doneBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_doneBt addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:_doneBt];
}

//- (void)nextstep{
//	if (self.checkCodeTF.text.length != 6) {
//		[MBProgressHUD showError:@"验证码不能为空"];
//		return;
//	}
//	if (1) {//验证码正确
//		[_nextStep removeFromSuperview];
//		[_userNameTF removeFromSuperview];
//		[_checkCodeTF removeFromSuperview];
//		[_getCheckCodeBt removeFromSuperview];
//		[self.view addSubview:_userPasswordTF];
//		[self.view addSubview:_checkPasswordTF];
//		[self.view addSubview:_doneBt];
//		
//		UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, _checkPasswordTF.bottom+5, kMainScreenWidth, 20)];
//		tipLb.font = kFont11;
//		tipLb.text = @"密码需6-16位，建议使用字母和数字或符号的组合";
//		tipLb.textColor = [UIColor grayColor];
//		tipLb.textAlignment = NSTextAlignmentCenter;
//		[self.view addSubview:tipLb];
//	}
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

//判断密码格式是否符合规范
- (BOOL)checkUpPassword:(NSString *)str
{
	NSString *      regex = @"(^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$)";
	NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:str];
}

- (void)time:(id)sender{
	static int timeCnt = 60;
	timeCnt--;
	[_getCheckCodeBt setTitle:[NSString stringWithFormat:@"%d秒后重发",timeCnt] forState:UIControlStateNormal];
	
	if (timeCnt == 0) {
		[self abledCheckCodeBt];
		[(NSTimer *)sender invalidate];
		timeCnt = 60;
	}
}

- (void)unabledCheckCodeBt{
	[_getCheckCodeBt setBackgroundColor:[UIColor lightGrayColor]];
	_getCheckCodeBt.enabled = NO;
	[_getCheckCodeBt setTitle:@"60秒后重发" forState:UIControlStateNormal];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
	[timer fire];
}

- (void)abledCheckCodeBt{
	[_getCheckCodeBt setTitle:@"重新获取验证码" forState:UIControlStateNormal];
	[_getCheckCodeBt setBackgroundColor:RGBCOLOR(253, 171, 105)];
	_getCheckCodeBt.enabled = YES;
}

//验证密码，发送请求
- (void)done{
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
	LARNetManager *manager = [[LARNetManager alloc] init];
	NSDictionary *info = @{@"mobile": _userNameTF.text,
						   @"smsCode": _checkPasswordTF.text,
						   @"password": _userPasswordTF.text};
	[manager forgetPasswordWith:info succ:^(NSDictionary *successDict) {
		[MBProgressHUD hideHUD];
		[MBProgressHUD showSuccess:@"修改成功"];
		[self.navigationController popToRootViewControllerAnimated:YES];
	} failure:^(NSDictionary *failDict, NSError *error) {
		[MBProgressHUD hideHUD];
		MLOG(@"%@",failDict[@"msg"]);
		[MBProgressHUD showError:@"修改失败"];
	}];
}

//获取验证码
- (void)getCheckCode{
	if (self.userNameTF.text.length != 11) {
		[MBProgressHUD showError:@"请输入正确的手机号"];
		return;
	}
	[MBProgressHUD showMessage:@"正在发送验证码"];
	LARNetManager *netmanager = [[LARNetManager alloc] init];
	[netmanager getModifyMobileCodeWith:_userNameTF.text succ:^(NSDictionary *successDict) {
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
