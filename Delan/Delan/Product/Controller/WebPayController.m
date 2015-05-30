//
//  WebPayController.m
//  Delan
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "WebPayController.h"

@interface WebPayController ()

@end

@implementation WebPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView * webPay = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
    
    [webPay loadRequest:request];
    
    [self.view addSubview:webPay];
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
