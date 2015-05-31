//
//  RootTabBarController.m
//  Delan
//
//  Created by qf on 15/5/21.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "RootTabBarController.h"
#import "RootNavgationController.h"
#import "MoreViewController.h"
#import "HomePageController.h"
#import "ProductController.h"
#import "AccountCenterController.h"

#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface RootTabBarController ()<UITabBarControllerDelegate, UITabBarDelegate>{
	NSInteger lastSelectIndex;			//上次选中的位置
	NSInteger currentSelectIndex;		//当前选中的位置
}

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.delegate = self;
	
	[self initTabBarController];
	[self notifyRegister];
}

- (void)notifyRegister{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView:) name:kMessageShowLoginView object:nil];
}

- (void)initTabBarController{
	/***修改这里NavegationController的RootViewController***/
	_homePageNav = [[RootNavgationController alloc] initWithRootViewController:[[HomePageController alloc] init]];
	_productNav = [[RootNavgationController alloc] initWithRootViewController:[[ProductController alloc] init]];
	_accoutNav = [[RootNavgationController alloc] initWithRootViewController:[[AccountCenterController alloc] init]];
	_moreNav = [[RootNavgationController alloc] initWithRootViewController:[[MoreViewController alloc] init]];
	/*****************************************************/
	
	NSArray *navArr = @[_homePageNav, _productNav, _accoutNav, _moreNav];
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"DLMainNav" withExtension:@"plist"];
	NSArray *infoArr = [NSArray arrayWithContentsOfURL:url];
	for (int i = 0; i < 4; i++) {
		UINavigationController *nc = navArr[i];
		NSDictionary *info = infoArr[i];
		nc.title = info[@"title"];
        nc.tabBarItem.image = [UIImage imageNamed:info[@"image"]];
		nc.tabBarItem.selectedImage = [UIImage imageNamed:info[@"selectImage"]];
		[self addChildViewController:nc];
	}
}

- (void)showLoginView:(NSNotification *)aNotification{
	//showLoginViewController
}

#pragma mark -delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
	lastSelectIndex = tabBarController.selectedIndex;
	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
	currentSelectIndex = tabBarController.selectedIndex;
	MLOG(@"select %d tab", currentSelectIndex);
	if (currentSelectIndex == 2) {
		if (1) {//没有登陆
			RootNavgationController *nav = [[RootNavgationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
			
			[self presentViewController:nav animated:YES completion:^{
				//登陆失败或成功
			}];
		}
//		[(RootNavgationController *)viewController pushViewController:vc animated:YES];
//		[(RootNavgationController *)viewController pushViewController:[[LoginViewController alloc] init] animated:YES];
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
