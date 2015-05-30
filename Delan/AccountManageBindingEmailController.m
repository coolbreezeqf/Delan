
//
//  AccountManageBindingEmailController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageBindingEmailController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface AccountManageBindingEmailController (){
    NSTimer *_timer;//计时器
    UIView  *_btnView;//在发送按钮上的一层UIview来覆盖button 使其在倒计时中不能被点击
    NSInteger _timeCount;//总计时
}

@property (nonatomic,strong) UITextField *numberText;
@property (nonatomic,strong) UITextField *yzmText;
@property (nonatomic,strong) UIButton *yzmButton;
@property (nonatomic,strong) UIScrollView *rootScrollView;
@property (nonatomic,strong) UIView *phoneView;

@end

@implementation AccountManageBindingEmailController

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
    self.title = @"绑定邮箱";
    
    [self createPhoneView];
    
    
    UIButton *bindButon = [UIButton buttonWithType:UIButtonTypeCustom];
    [bindButon setFrame:CGRectMake(20, 166, kScreenWidth - 40, 40)];
    [bindButon setTitle:@"确认绑定" forState:UIControlStateNormal];
    [bindButon setBackgroundColor:[UIColor colorWithRed:86.0/255 green:115.0/255 blue:186.0/255 alpha:1.0]];
    [bindButon.layer setCornerRadius:6.0];
    [self.rootScrollView addSubview:bindButon];
    
    UIImageView *safeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 226, 65,10)];
    safeImg.image = [UIImage imageNamed:@"AccountCenterManageBindSafe"];
    [self.rootScrollView addSubview:safeImg];
}

- (void)hideKey{
    [self.numberText resignFirstResponder];
    [self.yzmText resignFirstResponder];
}

- (void)createPhoneView{
    
    UILabel *bindLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 30)];
    bindLabel.font = [UIFont systemFontOfSize:14.0];
    bindLabel.text = @"请绑定您的邮箱";
    [self.rootScrollView addSubview:bindLabel];
    
    self.phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 100)];
    self.phoneView.backgroundColor = [UIColor whiteColor];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    numberLabel.font = [UIFont systemFontOfSize:14.0];
    numberLabel.text = @"邮箱账号";
    [self.phoneView addSubview:numberLabel];
    
    self.numberText = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 180, 30)];
    self.numberText.font = [UIFont systemFontOfSize:12.0];
    self.numberText.keyboardType = UIKeyboardTypeEmailAddress;
    self.numberText.placeholder = @"请输入邮箱账号";
    [self.phoneView addSubview:self.numberText];
    
    self.yzmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (kScreenWidth == 320) {
        [self.yzmButton setFrame:CGRectMake(kScreenWidth - 110, 10, 110, 30)];
    }
    else{
        [self.yzmButton setFrame:CGRectMake(kScreenWidth - 110, 10, 110, 30)];
    }
    [self.yzmButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.yzmButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.yzmButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.yzmButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.yzmButton.layer setCornerRadius:14.0]; //设置矩形四个圆角半径
    [self.yzmButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 252.0/255, 160.0/255, 68.0/255, 1 });
    [self.yzmButton.layer setBorderColor:colorref];
    [self.phoneView addSubview:self.yzmButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:228.0/255 green:229.0/255 blue:230.0/255 alpha:1.0];
    [self.phoneView addSubview:line];
    
    UILabel *yzmLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 45, 30)];
    yzmLabel.text = @"验证码";
    yzmLabel.font = [UIFont systemFontOfSize:14.0];
    [self.phoneView addSubview:yzmLabel];
    
    self.yzmText = [[UITextField alloc] initWithFrame:CGRectMake(80, 60, 180, 30)];
    self.yzmText.font = [UIFont systemFontOfSize:12.0];
    self.yzmText.placeholder = @"请输入邮箱验证码";
    [self.phoneView addSubview:self.yzmText];
    
    [self.rootScrollView addSubview:self.phoneView];
}

- (void)sendCode:(UIButton *)btn{
    
    if (self.numberText.text.length > 0) {
        _timeCount = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        
        _btnView = [[UIView alloc] initWithFrame:self.yzmButton.frame];
        
        [self.phoneView addSubview:_btnView];
        
        [btn setTitleColor:[UIColor colorWithRed:102.0/255 green:103.0/255 blue:105.0/255 alpha:1] forState:UIControlStateNormal];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 102.0/255, 103.0/255, 105.0/255, 1 });
        [btn.layer setBorderColor:colorref];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请填写正确的邮箱地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)timeFireMethod{
    _timeCount--;
    
    NSString *str = [NSString stringWithFormat:@"%ld秒後重新获取",(long)_timeCount];
    
    [self.yzmButton setTitle:str forState:UIControlStateNormal];
    
    
    
    if (_timeCount == 0) {
        
        [_timer invalidate];
        
        [_btnView removeFromSuperview];
        
        [self.yzmButton setTitle:@"重新获取" forState:UIControlStateNormal];
        
        [self.yzmButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 252.0/255, 160.0/255, 68.0/255, 1 });
        [self.yzmButton.layer setBorderColor:colorref];
        
    }
    
}

@end
