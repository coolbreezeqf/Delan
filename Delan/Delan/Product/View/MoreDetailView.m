//
//  MoreDetailView.m
//  Delan
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "MoreDetailView.h"
#import "ProductMoreDetailController.h"

//定位宏
#define segmentedControlHeight 35

@implementation MoreDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self segmentedControlLayout];
        
        [self makeAvailableView];
    }
    return self;
}



- (void)segmentedControlLayout {
    
    UISegmentedControl * segControl = [[UISegmentedControl alloc] initWithItems:@[@"项目详情",@"资料图片",@"法律意见书",@"投资记录"]];
    segControl.frame = CGRectMake(10, 15, kMainScreenWidth - 20, segmentedControlHeight);
    segControl.tintColor = RGBCOLOR(68, 90, 173);
    segControl.layer.borderWidth = 1.5;
    segControl.layer.borderColor = RGBCOLOR(68, 90, 173).CGColor;
    segControl.layer.cornerRadius = 8.0;
    segControl.clipsToBounds = YES;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold"size:14],NSFontAttributeName, nil];
    [segControl setTitleTextAttributes:dict forState:UIControlStateNormal];
    segControl.selectedSegmentIndex = 0;
    self.segControl = segControl;

    [self addSubview:self.segControl];
}


- (void)makeAvailableView {
    
    UIView * availableView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kMainScreenWidth, kMainScreenHeight - 177)];
    availableView.backgroundColor = [UIColor greenColor];
    self.availableView = availableView;
    ProductMoreDetailController * moreDetailVc = [[ProductMoreDetailController alloc] init];
    [self.availableView addSubview:moreDetailVc.view];
    [self addSubview:self.availableView];
}

@end
