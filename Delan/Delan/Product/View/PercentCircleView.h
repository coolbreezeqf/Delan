//
//  PercentCircleView.h
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentCircleView : UIView

@property (nonatomic, assign) CGFloat percent;


//  1:普通产品
//  2:已还款产品
//  3:已售罄产品
@property (nonatomic, assign) int type;

//  0:不是Vip
//  1:是Vip
@property (nonatomic, assign) int isVip;


@end
