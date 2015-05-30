//
//  HelpDetailTableViewCell.m
//  Delan
//
//  Created by qf on 15/5/29.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "HelpDetailTableViewCell.h"
#import "NSString+Additions.h"
#define ImageName @"HelpDetailIcon"

@interface HelpDetailTableViewCell ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UIImageView *iconImage;
@end

@implementation HelpDetailTableViewCell

+ (CGFloat)heightForCellWith:(NSString *)content{
	
	return 44 + [content sizeWithConstrainedToWidth:kMainScreenWidth - 20 fromFont:kFont13 lineSpace:3].height + 20;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		_iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ImageName]];
		_iconImage.frame = CGRectMake(5, 15, 15, 15);
		[self.contentView addSubview:_iconImage];
		_titleLb = [[UILabel alloc] initWithFrame:CGRectMake(_iconImage.right + 5, 10, kMainScreenWidth - _iconImage.right - 10, 30)];
		_titleLb.font = kFont15;
		[self.contentView addSubview:_titleLb];
	}
	return self;
}

- (void)setTitle:(NSString *)title{
	_titleLb.text = title;
}

- (void)setDetailContent:(NSString *)detailContent{
	if (!_contentLb) {
		_contentLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20, 44)];
		_contentLb.font = kFont13;
		_contentLb.lineBreakMode = NSLineBreakByWordWrapping;
		_contentLb.numberOfLines = 0;
		_contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kMainScreenWidth, 44)];
		_contentV.backgroundColor = RGBCOLOR(245, 245, 245);
		[_contentV addSubview:_contentLb];
	}
	_contentLb.text = detailContent;
	CGSize size = [_contentLb sizeThatFits:CGSizeMake(kMainScreenWidth - 20, MAXFLOAT)];
	_contentLb.height = size.height;
	_contentV.height = size.height + 20;
}

- (void)showDetailView{
	_isOpen = YES;
	[self.contentView addSubview:_contentV];
	_iconImage.transform = CGAffineTransformMakeRotation(_isOpen ? M_PI_2 : 0);
}

- (void)hideDetailView{
	_isOpen = NO;
	[_contentV removeFromSuperview];
	_iconImage.transform = CGAffineTransformMakeRotation(_isOpen ? M_PI_2 : 0);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
