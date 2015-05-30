//
//  ProductDetailPictureInformation.m
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductDetailPictureInformation.h"

@interface ProductDetailPictureInformation ()

@end

@implementation ProductDetailPictureInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-177);
    
    UIWebView * pictureInfo = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.0];
    
    [pictureInfo loadRequest:request];
    
    [self.view addSubview:pictureInfo];
    NSLog(@"%lf",self.view.frame.size.height);
}


@end
