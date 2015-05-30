//
//  ProgressCircleView.h
//  微贷宝
//
//  Created by apple on 15/4/14.
//  Copyright (c) 2015年 WDB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressCircleView : UIView

//中心颜色
@property (strong, nonatomic)UIColor *centerColor;

//圆环背景色(未完成的部分)
@property (strong, nonatomic)UIColor *arcBackColor;

//圆环色(100%)
@property (strong, nonatomic)UIColor *arcFinishColor;
//圆环色(0-100%)
@property (strong, nonatomic)UIColor *arcUnfinishColor;


//百分比数值（0-1）
@property (assign, nonatomic) float percent;

//年化利率
@property (assign, nonatomic) float yearRate;

//圆环宽度
@property (assign, nonatomic) float width;


@end
