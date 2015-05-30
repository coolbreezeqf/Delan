//
//  InvestController.h
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BaseViewController.h"

@interface InvestController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property (weak, nonatomic) IBOutlet UILabel *investRangeLabel;

@property (weak, nonatomic) IBOutlet UILabel *availableMoneyLabel;

@property (weak, nonatomic) IBOutlet UITextField *investTextField;

@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *evaluateYearRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, copy) NSString * htmlCode;

@end
