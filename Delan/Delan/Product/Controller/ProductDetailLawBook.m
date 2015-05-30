//
//  ProductDetailLawBook.m
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductDetailLawBook.h"

@interface ProductDetailLawBook ()

@end

@implementation ProductDetailLawBook

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-177);
    
    UIWebView * lawBook = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.0];
    
    [lawBook loadRequest:request];
    
    [self.view addSubview:lawBook];
    NSLog(@"%lf",self.view.frame.size.height);
}



@end
