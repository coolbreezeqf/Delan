//
//  OpenVipWebController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/5.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "OpenVipWebController.h"

@interface OpenVipWebController ()

@end

@implementation OpenVipWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开通VIP";
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [web loadData:self.code MIMEType:nil textEncodingName:nil baseURL:nil];
    [self.view addSubview:web];
}

@end
