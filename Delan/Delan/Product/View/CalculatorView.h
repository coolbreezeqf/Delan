//
//  CalculatorView.h
//  微贷宝
//
//  Created by apple on 15/4/19.
//  Copyright (c) 2015年 WDB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorView : UIView

- (CalculatorView *)calculatorCreate;

@property (weak, nonatomic) IBOutlet UITextField *calculateMoney;

@property (weak, nonatomic) IBOutlet UITextField *calculateDays;

@property (weak, nonatomic) IBOutlet UILabel *calculatorResult;

- (IBAction)calculating:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *calculatingBtn;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

//用于接收本产品的年化利率
@property (nonatomic, assign) float yearRate;

@end
