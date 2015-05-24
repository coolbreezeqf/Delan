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

@interface RootNavgationController ()

@end

@implementation RootNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (([viewController isMemberOfClass:[HomePageController class]]) || [viewController isMemberOfClass:[MoreViewController class]]) {
        
        //调用父类的push
        [super pushViewController:viewController animated:animated];
        
    } else {
        
        //在跳转时自动隐藏tabBar
        [viewController setHidesBottomBarWhenPushed:YES];
        
        //调用父类的push
        [super pushViewController:viewController animated:animated];
    }
}


//定制导航条样式
+ (void)initialize {
    
    /***-----------------------标题文字风格样式的设置--------------------***/
    
    NSMutableDictionary * style = [NSMutableDictionary dictionary];
    
    //标题大小
    style[NSFontAttributeName] = kFontBold18;
    //标题颜色
    style[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:style];
    
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
