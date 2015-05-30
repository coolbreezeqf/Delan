//
//  CalculatorView.m
//  微贷宝
//
//  Created by apple on 15/4/19.
//  Copyright (c) 2015年 WDB. All rights reserved.
//

#import "CalculatorView.h"

#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation CalculatorView

- (void)drawRect:(CGRect)rect {
    
    //设置计算按钮的圆角
    self.calculatingBtn.layer.cornerRadius = 5.0;
    self.calculatingBtn.clipsToBounds = YES;
    
}

- (CalculatorView *)calculatorCreate {
    
    CalculatorView * calculator;
    if (kMainScreenWidth == 320) {
        calculator = [[[NSBundle mainBundle] loadNibNamed:@"CalculatorViewFor320" owner:self options:nil] lastObject];
    }
    else if (kMainScreenWidth == 375) {
        calculator = [[[NSBundle mainBundle] loadNibNamed:@"CalculatorViewFor375" owner:self options:nil] lastObject];
    }
    else {
        calculator = [[[NSBundle mainBundle] loadNibNamed:@"CalculatorViewFor414" owner:self options:nil] lastObject];
    }
    
    //设置整一个计算器的圆角
    calculator.layer.cornerRadius = 8.0;
    calculator.clipsToBounds = YES;

    return calculator;
}


- (IBAction)calculating:(UIButton *)sender {
    
    CGFloat moneyOfDay = [self.calculateMoney.text floatValue];
    NSInteger days = [self.calculateDays.text integerValue];
    
    self.calculatorResult.text = [NSString stringWithFormat:@"%.2lf",(moneyOfDay * self.yearRate) * days / 360];
}
@end
