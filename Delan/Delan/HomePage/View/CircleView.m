//
//  CircleView.m
//  Delan
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

#define iPhoneSmallWidth 320
#define iPhoneMiddleWidth 375
#define iPhoneBigWidth 414
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width

- (void)awakeFromNib {
    
    self.purchaseBtn.layer.cornerRadius = 8.0;
    self.purchaseBtn.clipsToBounds = YES;
}


//重写init方法
- (instancetype)init {
    
    if (self = [super init]) {
        if (iPhoneSmallWidth == kMainScreenWidth) {
            self = [[[NSBundle mainBundle] loadNibNamed:@"CircleViewFor320" owner:self options:nil] lastObject];
        }
        else if (iPhoneMiddleWidth == kMainScreenWidth) {
            self = [[[NSBundle mainBundle] loadNibNamed:@"CircleViewFor375" owner:self options:nil] lastObject];
        }
        else {
            self = [[[NSBundle mainBundle] loadNibNamed:@"CircleViewFor414" owner:self options:nil] lastObject];
        }
    }
    return self;
}



@end
