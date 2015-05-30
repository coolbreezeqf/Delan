//
//  RootNavgationController.m
//  Delan
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "RootNavgationController.h"
#import "HomePageController.h"
#import "MoreViewController.h"
#import "ProductController.h"
#import "AccountCenterController.h"

@interface RootNavgationController ()

@end

@implementation RootNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (([viewController isMemberOfClass:[HomePageController class]]) || [viewController isMemberOfClass:[MoreViewController class]] || [viewController isMemberOfClass:[AccountCenterController class]] || [viewController isMemberOfClass:[ProductController class]]) {
        
        //调用父类的push
        [super pushViewController:viewController animated:animated];
        
    } else {
        
        //在跳转时自动隐藏tabBar
        [viewController setHidesBottomBarWhenPushed:YES];
        
        //调用父类的push
        [super pushViewController:viewController animated:animated];
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
