//
//  LRTextField.m
//  Delan
//
//  Created by qf on 15/5/30.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "LRTextField.h"

@interface LRTextField ()
@property (nonatomic,strong) UIImageView *leftImageView;
@end

@implementation LRTextField

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self initUI];
	}
	return self;
}

- (void)setLeftImage:(UIImage *)leftImage{
	_leftImageView.image = leftImage;
}

- (void)initUI{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.height, self.height)];
	_leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.height/2 - 10, 15, 20)];
	[view addSubview:_leftImageView];
	self.leftView = view;
	self.leftViewMode = UITextFieldViewModeAlways;
	self.layer.borderColor = RGBCOLOR(227, 227, 227).CGColor;
	self.layer.borderWidth = 1;
	self.layer.cornerRadius = 3;
	self.clearButtonMode = UITextFieldViewModeAlways;
	self.font = kFont15;
	self.backgroundColor = [UIColor whiteColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
