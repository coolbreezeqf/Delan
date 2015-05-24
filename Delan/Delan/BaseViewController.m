//
//  BaseViewController.m
//  Delan
//
//  Created by qf on 15/5/21.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize g_OffsetY;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//	self.navigationController.navigationBar.barTintColor =
	if (self != [self.navigationController.viewControllers objectAtIndex:0]) {
//		[self setLeftButton:[UIImage imageNamed:@"DLBackButtonImage"] title:nil target:self action:@selector(back) rect:CGRectMake(0, 0, 21, 35)];
		[self setLeftButton:[UIImage imageNamed:@"DLBackButtonImage"] title:nil target:self action:@selector(back)];
	}
	if (self.navigationController) {
		if (self.navigationController.navigationBarHidden == YES) {
			g_OffsetY = 0;
			self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
		}else{
			g_OffsetY = 64;
			self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64);
		}
	}
}

- (void)back{
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)setRightButton:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)selector{
	[self setRightButton:image title:title target:target action:selector rect:CGRectNull];
}

- (void)setRightButton:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)selector rect:(CGRect)rect{
	if (self.navigationController && self.navigationItem) {
		CGRect buttonFrame = CGRectMake(0, 0, 44, 44);
		UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
		if (image) {
			[button setBackgroundImage:image forState:UIControlStateNormal];
		}
		if (title) {
			[button setTitle:title forState:UIControlStateNormal];
		}
		[button addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
		CGRect viewFrame = CGRectMake(kMainScreenWidth - 100 / 2, 0, 44, 44);
		UIView *view = [[UIView alloc] initWithFrame:viewFrame];
		[view addSubview:button];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
	}
}

- (void)setLeftButton:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)selector{
	[self setLeftButton:image title:title target:target action:selector rect:CGRectNull];
}

- (void)setLeftButton:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)selector rect:(CGRect) rect{
	if (self.navigationItem) {
		CGRect buttonFrame;
		CGRect viewFrame;
		if (!CGRectIsEmpty(rect)) {
			buttonFrame = rect;
		}else{
			buttonFrame = CGRectMake(0, 0, 44, 44);
			viewFrame = CGRectMake(0, 0, 44, 44);
		}
		UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
		if (image) {
			[button setBackgroundImage:image forState:UIControlStateNormal];
		}
		if (title) {
			[button setTitle:title forState:UIControlStateNormal];
		}
		[button addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
		
		UIView *view = [[UIView alloc] initWithFrame:viewFrame];
		[view addSubview:button];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
	}
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