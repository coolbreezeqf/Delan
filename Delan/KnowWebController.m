
//
//  KnowWebController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "KnowWebController.h"

@interface KnowWebController ()

@end

@implementation KnowWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实名认证";
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [web loadHTMLString:self.code baseURL:nil];
    
    [self.view addSubview:web];
}

@end
