//
//  MoreViewController.m
//  Delan
//
//  Created by qf on 15/5/20.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.navigationItem.title = @"更多";
	UILabel *laa = [[UILabel alloc] initWithFrame:CGRectMake(0, self.g_OffsetY, kMainScreenWidth, 64)];
	laa.backgroundColor = [UIColor greenColor];
	[self.view addSubview:laa];
	
	
	UILabel *lbb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.g_OffsetY, kMainScreenWidth, 64)];
	lbb.backgroundColor = [UIColor greenColor];
	BaseViewController *base = [[BaseViewController alloc] init];
	[self.navigationController pushViewController:base animated:YES];
	[base.view addSubview:lbb];
	
}

- (void)viewWillAppear:(BOOL)animated{
//	self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
	self.navigationController.navigationBarHidden = NO;
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
