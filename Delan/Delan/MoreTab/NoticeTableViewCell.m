//
//  NoticeTableViewCell.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "NoticeTableViewCell.h"
#define NoticeCellHeight 90
@interface NoticeTableViewCell ()
@property (nonatomic,strong) UILabel *contentLb;
@end

@implementation NoticeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self initUI];
	}
	return self;
}

- (void)initUI{
	self.backgroundColor = [UIColor clearColor];
	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, kMainScreenWidth - 10, NoticeCellHeight)];
	view.backgroundColor = [UIColor whiteColor];
	view.layer.cornerRadius = 1;
	view.layer.borderColor = [UIColor grayColor].CGColor;
	view.layer.borderWidth = 1;
	[self.contentView addSubview:view];
	
	UIView *a = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 2, NoticeCellHeight)];
	a.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NoticeLine"]];
	[view addSubview:a];
	
	
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth - 50, 21)];
	_titleLabel.font = kFontBold15;
	[view addSubview:_titleLabel];
	
	UIView *b = [[UIView alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom + 5, _titleLabel.width, 1)];
	b.backgroundColor = [UIColor colorWithRed:0.780f green:0.780f blue:0.800f alpha:1.00f];
	[view addSubview:b];
	
	_contentLb = [[UILabel alloc] initWithFrame:CGRectMake(10, b.bottom + 10, _titleLabel.width, 31.5)];
	_contentLb.font = kFont13;
	_contentLb.numberOfLines = 2;
	[view addSubview:_contentLb];
}

- (void)setContent:(NSString *)content{
	_contentLb.text = content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
