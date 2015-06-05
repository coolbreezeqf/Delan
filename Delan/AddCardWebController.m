//
//  AddCardWebController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/6/5.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AddCardWebController.h"

@interface AddCardWebController ()

@end

@implementation AddCardWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加银行卡";
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [web loadData:self.code MIMEType:nil textEncodingName:nil baseURL:nil];
    [self.view addSubview:web];
}
@end
