//
//  FeedBackViewController.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MTNetManager.h"
#import "MBProgressHUD+NJ.h"
#define ButtonColor RGBCOLOR(87, 112, 187)
#define BackGroundColor RGBCOLOR(245, 245, 245)
@interface FeedBackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *feedBackBtn;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.navigationItem.title = @"意见与反馈";
	self.view.backgroundColor = BackGroundColor;
	
	/**关闭边缘延伸**/
	self.modalPresentationCapturesStatusBarAppearance = NO;
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.extendedLayoutIncludesOpaqueBars = NO;
	/*****end*****/
	
	_textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, kMainScreenWidth-20, kMainScreenHeight)];
	_textView.font = kFont15;
	_textView.layer.cornerRadius = 3;
	_textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_textView.layer.borderWidth = 1;
	_textView.scrollEnabled = YES;
	_textView.delegate = self;
	[_textView setContentOffset:CGPointMake(0, 0)];
	[self.view addSubview:_textView];
	
	_feedBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(_textView.left, _textView.bottom + 10, _textView.width, 44)];
	[_feedBackBtn addTarget:self action:@selector(feedBack) forControlEvents:UIControlEventTouchDown];
	[_feedBackBtn setBackgroundColor:ButtonColor];
	[_feedBackBtn setTitle:@"反馈意见" forState:UIControlStateNormal];
	_feedBackBtn.layer.cornerRadius = 1;
	[self.view addSubview:_feedBackBtn];
	
	[_textView becomeFirstResponder];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	_tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, kMainScreenWidth - 20, 30)];
	_tipLabel.enabled = NO;
	_tipLabel.backgroundColor = [UIColor clearColor];
	_tipLabel.textColor = [UIColor grayColor];
	_tipLabel.text = @"感谢您对德岚的关注，您的意见我们一定认真听取～";
	_tipLabel.font = kFont13;
	[_textView addSubview:_tipLabel];
}

- (void)textViewDidChange:(UITextView *)textView{
	if (textView.text.length == 0) {
		_tipLabel.text = @"感谢您对德岚的关注，您的意见我们一定认真听取～";
	}else{
		_tipLabel.text = @"";
	}
}

- (void)feedBack{
	//Feed Back
	MTNetManager *manager = [[MTNetManager alloc] init];
	MLOG(@"feedBack");
	[manager postFeedBackWith:_textView.text succ:^(NSDictionary *successDict) {
		[MBProgressHUD showSuccess:@"发送成功"];
	} failure:^(NSDictionary *failDict, NSError *error) {
		
	}];
}

#pragma mark - keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification{
	NSDictionary *info = [notification userInfo];
	//获取高度
	NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
	CGSize hightSize = [value CGRectValue].size;
	_textView.height = self.view.height -  hightSize.height - _feedBackBtn.height - 20;
	_feedBackBtn.top = _textView.bottom + 10;
//	[UIView animateWithDuration:0.5 animations:^{
//		[_textView setContentOffset:CGPointMake(0, hightSize.height)];
//	}];
}

- (void)keyboardWillHide:(NSNotification *)notification{
	NSDictionary *info = [notification userInfo];
	//获取高度
	NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
	CGSize hightSize = [value CGRectValue].size;
	_textView.height += hightSize.height;
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
