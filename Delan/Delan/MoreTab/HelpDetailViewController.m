//
//  HelpDetailViewController.m
//  Delan
//
//  Created by qf on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "HelpDetailViewController.h"
#import "HelpDetailTableViewCell.h"
#import "NSString+Additions.h"

#define SomeTag 123
#define ImageTag 124
@interface HelpDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HelpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initData];
	[self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
	_isOpen = NO;
	_selectedIndex = nil;
	_array = @[@"测试下自动换行能不能用，测试下自动换行能不能用，测试下自动换行能不能用，测试下自动换行能不能用，测试下自动换行能不能用",@"title",@"title"];
}

- (void)initUI{
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	[self.view addSubview:_tableView];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [_array count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (_selectedIndex != nil && indexPath.row == _selectedIndex.row) {
		if (_isOpen) {
			NSString *content = _array[_selectedIndex.row];
//			return 44 + [content sizeWithConstrainedToWidth:kMainScreenWidth - 20 fromFont:kFont13 lineSpace:3].height + 20;
			return [HelpDetailTableViewCell heightForCellWith:content];
		}
		return 44;
	}
	return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	HelpDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HelpDetailCell"];
	if (!cell) {
		cell = [[HelpDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HelpDetailCell"];
	}
	cell.title = _array[indexPath.row];
	cell.detailContent = _array[indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (_selectedIndex != nil && indexPath.row == _selectedIndex.row) {
		HelpDetailTableViewCell *cell = (HelpDetailTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
		if (_isOpen) {
			_isOpen = NO;
			[cell hideDetailView];
		}else{
			_isOpen = YES;
			[cell showDetailView];
		}
	}else{
		if (_isOpen) {
			HelpDetailTableViewCell *cell = (HelpDetailTableViewCell*)[tableView cellForRowAtIndexPath:_selectedIndex];
			[cell hideDetailView];
		}
		_isOpen = YES;
		_selectedIndex = indexPath;
		HelpDetailTableViewCell *cell = (HelpDetailTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
		[cell showDetailView];
	}
	[tableView reloadData];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//	if (_selectedIndex != nil && indexPath.row == _selectedIndex.row) {
//		//与上次点击的位置相同
//		if (_isOpen) {
//			//合上上次打开的位置
//			_isOpen = NO;
//			UITableViewCell *cell = [tableView cellForRowAtIndexPath:_selectedIndex];
//			UIView *view = [cell.subviews[0] viewWithTag:SomeTag];
//			while (view != nil) {
//				[view removeFromSuperview];
//				view = [cell.subviews[0] viewWithTag:SomeTag];
//			}
//			UIView *image = [cell.subviews[0] viewWithTag:ImageTag];
//			image.transform = CGAffineTransformMakeRotation(self.isOpen?M_PI_2:0);
//		}else{
//			//上次关闭的话就展开
//			_isOpen = YES;
//			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//			
//			UIView *image = [cell.subviews[0] viewWithTag:ImageTag];
//			image.transform = CGAffineTransformMakeRotation(self.isOpen ? M_PI_2 : 0);
//			
//			UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kMainScreenWidth - 20, 44)];
//			contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//			contentLabel.numberOfLines = 0;
//			contentLabel.font = kFont13;
//			contentLabel.text = _array[indexPath.row];
//			CGSize size = [contentLabel sizeThatFits:CGSizeMake(kMainScreenWidth, MAXFLOAT)];
//			contentLabel.height = size.height;
//			
//			contentLabel.tag = SomeTag;
//			
//			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kMainScreenWidth, size.height + 20)];
//			view.backgroundColor = RGBCOLOR(245, 245, 245);
//			view.tag = SomeTag;
//			[view addSubview:contentLabel];
//			[cell addSubview:view];
//		}
//		
//	}else{
//		if (_isOpen) {
//			_isOpen = NO;
//			UITableViewCell *cell = [tableView cellForRowAtIndexPath:_selectedIndex];
//			UIView *view = [cell.subviews[0] viewWithTag:SomeTag];
//			while (view != nil) {
//				[view removeFromSuperview];
//				view = [cell.subviews[0] viewWithTag:SomeTag];
//			}
//			UIView *image = [cell.subviews[0] viewWithTag:ImageTag];
//			image.transform = CGAffineTransformMakeRotation(self.isOpen?M_PI_2:0);
//		}
//		//展开
//		_isOpen = YES;
//		_selectedIndex = indexPath;
//		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//		UIView *image = [cell.subviews[0] viewWithTag:ImageTag];
//		image.transform = CGAffineTransformMakeRotation(self.isOpen ? M_PI_2 : 0);
////		for (UIView *view in [cell.subviews[0] subviews]) {
////			if (view.tag == ImageTag) {
////				view.transform = CGAffineTransformMakeRotation(self.isOpen?M_PI_2:0);
////			}
////		}
//		UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kMainScreenWidth - 20, 44)];
//		contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//		contentLabel.numberOfLines = 0;
//		contentLabel.font = kFont13;
//		contentLabel.text = _array[indexPath.row];
//		CGSize size = [contentLabel sizeThatFits:CGSizeMake(kMainScreenWidth, MAXFLOAT)];
//		contentLabel.height = size.height;
//		
//		contentLabel.tag = SomeTag;
//		
//		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kMainScreenWidth, size.height + 20)];
//		view.backgroundColor = RGBCOLOR(245, 245, 245);
//		view.tag = SomeTag;
//		[view addSubview:contentLabel];
//		[cell addSubview:view];
//	}
//	
//	
////	[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//	[tableView reloadData];
//}













/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
