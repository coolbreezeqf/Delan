//
//  HelpDetailTableViewCell.h
//  Delan
//
//  Created by qf on 15/5/29.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *detailContent;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isOpen;

+ (CGFloat)heightForCellWith:(NSString *)content;
//获取内容为content时，cell的高度
- (void)showDetailView;
//展开详情
- (void)hideDetailView;
//收起详情

@end
