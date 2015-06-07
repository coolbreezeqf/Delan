//
//  DLWebViewController.m
//  Delan
//
//  Created by qf on 15/6/6.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "DLWebViewController.h"

@interface DLWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) UIView *toolBar;
@property (nonatomic,strong) UIButton *backBt;
@property (nonatomic,strong) UIButton *forwardBt;
@property (nonatomic,strong) UIButton *refreshBt;
@end

@implementation DLWebViewController

- (instancetype)initWithUrl:(NSString *)url{
	if (self = [super init]) {
		_url = url;
	}
	return self;
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	//webView
	_webView = [[UIWebView alloc] initWithFrame:self.view.frame];
	_webView.delegate = self;
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
	[_webView loadRequest: request];
	[self.view addSubview:_webView];

	//toolBar
	_toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
	_toolBar.bottom = self.view.bottom;
	_toolBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
	_toolBar.layer.borderColor = [UIColor grayColor].CGColor;
	_toolBar.layer.borderWidth = 1;
	[self.view addSubview:_toolBar];
	
	_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
	_activityIndicatorView.centerX = _toolBar.centerX;
	_activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//	_activityIndicatorView.backgroundColor = [UIColor grayColor];
	[_toolBar addSubview:_activityIndicatorView];
	
	_backBt = [UIButton buttonWithType:UIButtonTypeSystem];
	_backBt.frame = CGRectMake(10,5, 34, 34);
//	_backBt.enabled = NO;
	[_backBt addTarget:self action:@selector(webback) forControlEvents:UIControlEventTouchDown];
	[_backBt setTitle:@"<<" forState:UIControlStateNormal];
	[_toolBar addSubview:_backBt];
	
	_forwardBt = [UIButton buttonWithType:UIButtonTypeSystem];
	_forwardBt.frame = CGRectMake(_backBt.right + 10, 5, 34, 34);
//	_forwardBt.enabled = NO;
	[_forwardBt addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchDown];
	[_forwardBt setTitle:@">>" forState:UIControlStateNormal];
	[_toolBar addSubview:_forwardBt];
	
	_refreshBt = [UIButton buttonWithType:UIButtonTypeSystem];
	_refreshBt.frame = CGRectMake(0, 5, 60, 34);
	_refreshBt.right = kMainScreenWidth - 10;
	_refreshBt.titleLabel.textAlignment = NSTextAlignmentCenter;
	[_refreshBt addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchDown];
	[_refreshBt setTitle:@"刷新" forState:UIControlStateNormal];
	[_toolBar addSubview:_refreshBt];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma toolbar action
- (void)webback{
	[_webView goBack];
}

- (void)forward{
	[_webView goForward];
}

- (void)refresh{
	[_webView reload];
}

#pragma web view delegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

- (void)webViewDidStartLoad:(UIWebView *)webView{
	[_activityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[_activityIndicatorView stopAnimating];
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
