//
//  WebController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/2.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "WebController.h"

@interface WebController ()

@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [web loadHTMLString:self.code baseURL:nil];
    
    [self.view addSubview:web];
}

@end
