//
//  NewsTableViewCell.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NSString+Additions.h"
#define DefaultHeight 42
#define ContentFont kFont13

@interface NewsTableViewCell ()
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *myView;
@end

@implementation NewsTableViewCell

+ (NSInteger)heightWithContent:(NSString *)content{
	NSInteger height = 185;
	
	CGSize s = [content sizeWithConstrainedToWidth:kMainScreenWidth - 40 fromFont:kFont13 lineSpace:3];
	
	return height + s.height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self initUI];
	}
	return self;
}

- (void)initUI{
	
	self.backgroundColor = [UIColor clearColor];
	
	_myView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kMainScreenWidth - 20, DefaultHeight)];
	_myView.backgroundColor = [UIColor whiteColor];
	_myView.layer.cornerRadius = 3;
	_myView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_myView.layer.borderWidth = 1;
	[self.contentView addSubview:_myView];
	
	_titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, _myView.width - 20, 120)];
	[_myView addSubview:_titleImageView];
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleImageView.bottom + 10, _titleImageView.width, 30)];
	_titleLabel.font = kFont15;
	[_myView addSubview:_titleLabel];
	
	_contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom + 5, _titleLabel.width, DefaultHeight)];
	_contentLabel.font = kFont13;
	_contentLabel.numberOfLines = 0;
	_contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
	_contentLabel.textColor = [UIColor lightGrayColor];
	[_myView addSubview:_contentLabel];

}

- (void)setContent:(NSString *)content{
	_contentLabel.text = content;
	CGSize size = [_contentLabel sizeThatFits:CGSizeMake(_contentLabel.width, MAXFLOAT)];
	_contentLabel.frame = CGRectMake(_contentLabel.left, _contentLabel.top, _contentLabel.width, size.height);
	_myView.height = _contentLabel.bottom + 10;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
