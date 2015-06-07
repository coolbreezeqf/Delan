//
//  DLWebViewController.h
//  Delan
//
//  Created by qf on 15/6/6.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLWebViewController : BaseViewController

@property (nonatomic,strong) UIWebView *webView;

- (instancetype)initWithUrl:(NSString *)url;
@end
