//
//  RootTabBarController.h
//  Delan
//
//  Created by qf on 15/5/21.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController

@property (nonatomic, strong) UINavigationController *productNav;
@property (nonatomic, strong) UINavigationController *homePageNav;
@property (nonatomic, strong) UINavigationController *accoutNav;
@property (nonatomic, strong) UINavigationController *moreNav;

@end
