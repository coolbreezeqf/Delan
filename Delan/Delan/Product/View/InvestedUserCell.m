//
//  InvestedUserCell.m
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestedUserCell.h"

#define iPhoneScreenWidth_small 320
#define iPhoneScreenWidth_middle 375
#define iPhoneScreenWidth_large 414

@implementation InvestedUserCell

- (void)awakeFromNib {
    // Initialization code
}


//重写init方法
- (instancetype)init {
    
    if (self = [super init]) {
        if (iPhoneScreenWidth_small == kMainScreenWidth) {
            self = [[[NSBundle mainBundle] loadNibNamed:@"InvestedUserCellFor320" owner:self options:nil] lastObject];
        }
        else if (iPhoneScreenWidth_middle == kMainScreenWidth) {
            self = [[[NSBundle mainBundle] loadNibNamed:@"InvestedUserCellFor375" owner:self options:nil] lastObject];
        }
        else {
            self = [[[NSBundle mainBundle] loadNibNamed:@"InvestedUserCellFor414" owner:self options:nil] lastObject];
        }
    }
    return self;
}

@end
