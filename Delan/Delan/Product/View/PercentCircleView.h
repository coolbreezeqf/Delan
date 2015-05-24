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

//  0:vip产品
//  1:普通产品
//  2:已售罄产品
//  3:已还款产品
@property (nonatomic, assign) int type;


@end
