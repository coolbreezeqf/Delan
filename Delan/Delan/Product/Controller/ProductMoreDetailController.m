//
//  ProductMoreDetailController.m
//  Delan
//
//  Created by apple on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductMoreDetailController.h"

#define iPhoneScreenWidth_small 320
#define iPhoneScreenWidth_middle 375
#define iPhoneScreenWidth_large 414

@interface ProductMoreDetailController ()

@end

@implementation ProductMoreDetailController


//重写init方法
- (instancetype)init {
    
    if (kMainScreenWidth == iPhoneScreenWidth_small) {
        return [super initWithNibName:@"ProductMoreDetailControllerFor320" bundle:nil];
    }
    else if (kMainScreenWidth == iPhoneScreenWidth_middle) {
        return [super initWithNibName:@"ProductMoreDetailControllerFor375" bundle:nil];
    }
    else {
        return [super initWithNibName:@"ProductMoreDetailControllerFor414" bundle:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
