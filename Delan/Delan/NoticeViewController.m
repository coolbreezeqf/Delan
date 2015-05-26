//
//  NoticeViewController.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
@interface NoticeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self initUI];
	[self initData];
}

- (void) initUI{
	self.navigationItem.title = @"官方公告";
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];
}

- (void) initData{
	NSDictionary *dic = @{@"title": @"德岚新成员增信宝上线",
						  @"content": @"德岚新成员增心宝将于明年5-19号上线，高收益，低风险"};
	_dataArr = @[dic,dic,dic];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//TO DO
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
	if (!cell) {
		cell = [[NoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoticeCell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	NSDictionary *dic = _dataArr[indexPath.row];
	
	cell.titleLabel.text = dic[@"title"];
	cell.content = dic[@"content"];
	
	return cell;
}

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
