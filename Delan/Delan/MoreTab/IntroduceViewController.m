//
//  IntroduceViewController.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initData];
	[self initUI];
}

- (void)initUI{
	self.navigationItem.title = @"公司简介";
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	[self.view addSubview:_tableView];
}
- (void)initData{
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"IntroduceInfo" withExtension:@"plist"];
	_dataArr = [NSArray arrayWithContentsOfURL:url];
}

#pragma action

- (NSInteger)heightForCell:(NSString *)content{
	UILabel *lb = [[UILabel alloc] init];
	lb.numberOfLines = 0;
	lb.lineBreakMode = NSLineBreakByWordWrapping;
	lb.font = kFont13;
	lb.text = content;
	CGSize size = [lb sizeThatFits:CGSizeMake(kMainScreenWidth - 20, MAXFLOAT)];
	return size.height + 30;
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [_dataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return [self heightForCell:_dataArr[indexPath.section][@"content"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InCell"];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = _dataArr[indexPath.section][@"content"];
	cell.textLabel.numberOfLines = 0;
	cell.textLabel.font = kFont13;
	cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
	cell.frame = CGRectMake(cell.left, cell.top, kMainScreenWidth - 20, [self heightForCell:cell.textLabel.text]);
//	cell.textLabel.textColor = [UIColor grayColor];
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kMainScreenWidth-10, 44)];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20 , 0 , kMainScreenWidth - 20, 44)];
	label.text = _dataArr[section][@"title"];
	[view addSubview:label];
	return view;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	return _dataArr[section][@"title"];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
