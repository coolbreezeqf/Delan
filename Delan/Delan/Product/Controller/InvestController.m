//
//  InvestController.m
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestController.h"
#import "WebPayController.h"

#define iPhoneScreenWidth_small 320
#define iPhoneScreenWidth_middle 375
#define iPhoneScreenWidth_large 414

@interface InvestController ()

@end

@implementation InvestController

#pragma mark - 初始化UI/网络请求
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    scrollView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight + 200);
    scrollView.backgroundColor = [UIColor whiteColor];
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
        [scrollView addSubview:view];
    }
    [self.view addSubview:scrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //设置标题
    self.navigationItem.title = @"立即投资";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //设置标题颜色
    NSMutableDictionary * style = [NSMutableDictionary dictionary];
    style[NSForegroundColorAttributeName] = [UIColor blackColor];
    //标题大小
    style[NSFontAttributeName] = kFont16;
    self.navigationController.navigationBar.titleTextAttributes = style;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.submitBtn.layer.cornerRadius = 5.0;
    self.submitBtn.clipsToBounds = YES;
    
    [self.submitBtn addTarget:self action:@selector(submitInvestInfo) forControlEvents:UIControlEventTouchUpInside];
    self.htmlCode = @"http://www.baidu.com";
}


//重写init方法
- (instancetype)init {
    
    if (iPhoneScreenWidth_small == kMainScreenWidth) {
        return [super initWithNibName:@"InvestViewFor320" bundle:nil];
    }
    else if (iPhoneScreenWidth_middle == kMainScreenWidth) {
        return [super initWithNibName:@"InvestViewFor375" bundle:nil];
    }
    else {
        return [super initWithNibName:@"InvestViewFor414" bundle:nil];
    }
}


#pragma mark - 监听点击提交按钮
- (void)submitInvestInfo {
    
    WebPayController * webPayVc = [[WebPayController alloc] init];
    webPayVc.requestUrl = self.htmlCode;
    [self.navigationController pushViewController:webPayVc animated:YES];
}


@end
