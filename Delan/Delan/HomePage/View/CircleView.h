//
//  CircleView.h
//  Delan
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProgressCircleView;

@interface CircleView : UIView

@property (weak, nonatomic) IBOutlet ProgressCircleView *progressCircleView;

@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@property (weak, nonatomic) IBOutlet UILabel *minPayLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;

@end
