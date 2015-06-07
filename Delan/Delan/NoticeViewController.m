//
//  NoticeViewController.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "PublicDataModels.h"
#import "MTNetManager.h"
#import "SVPullToRefresh.h"
#import "MBProgressHUD+NJ.h"
#import "DLWebViewController.h"
@interface NoticeViewController ()<UITableViewDataSource, UITableViewDelegate>{
	NSInteger totalNum;
	NSInteger currentPageNum;
	NSInteger pageSize;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) MTNetManager *manager;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	_manager = [[MTNetManager alloc] init];
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
	
	__weak NoticeViewController *weakself = self;
	[self.tableView addPullToRefreshWithActionHandler:^{
		[weakself insertRowToTop];
	}];
	[_tableView.pullToRefreshView setTitle:@"下拉加载..." forState:SVPullToRefreshStateTriggered];
	[_tableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
	[_tableView.pullToRefreshView setTitle:@"已载入" forState:SVPullToRefreshStateStopped];
	[self.tableView addInfiniteScrollingWithActionHandler:^{
		if (totalNum == currentPageNum) {
			[MBProgressHUD showError:@"已经没有更多内容了"];
		}else{
			[weakself addRowToBottom];
		}
	}];
}

- (void) initData{
	totalNum = 0;
	currentPageNum = 0;
	pageSize = 5;
	_dataArr = [NSMutableArray arrayWithCapacity:42];
	
	[self insertRowToTop];
//	NSDictionary *dic = @{@"title": @"德岚新成员增信宝上线",
//						  @"content": @"德岚新成员增心宝将于明年5-19号上线，高收益，低风险"};
//	_dataArr = @[dic,dic,dic];
}

- (void)insertRowToTop{
	__weak NoticeViewController *weakself = self;
	[_manager getPublicInformationWith:1 andPageSize:pageSize succ:^(MTPublicPublicInformation *info) {
		totalNum = [info.totalNum integerValue];
		currentPageNum = [info.pageNum integerValue];
		[_dataArr removeAllObjects];
		[_dataArr addObjectsFromArray:info.item];
		[_tableView reloadData];
		[weakself.tableView.pullToRefreshView stopAnimating];
	} failure:^(NSDictionary *failDict, NSError *error) {
		[MBProgressHUD showError:@"网络错误"];
		[weakself.tableView.pullToRefreshView stopAnimating];
	}];
}

- (void)addRowToBottom{
	__weak NoticeViewController *weakself = self;
	[_manager getPublicInformationWith:currentPageNum + 1 andPageSize:pageSize succ:^(MTPublicPublicInformation *info) {
		totalNum = [info.totalNum integerValue];
		currentPageNum = [info.pageNum integerValue];
		[_dataArr addObjectsFromArray:info.item];
		[_tableView reloadData];
		[weakself.tableView.infiniteScrollingView stopAnimating];
	} failure:^(NSDictionary *failDict, NSError *error) {
		[weakself.tableView.infiniteScrollingView stopAnimating];
	}];
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
	MTPublicItem *item = _dataArr[indexPath.row];
	DLWebViewController *wvc = [[DLWebViewController alloc] initWithUrl:item.urlpath];
	[self.navigationController pushViewController:wvc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
	if (!cell) {
		cell = [[NoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoticeCell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
//	NSDictionary *dic = _dataArr[indexPath.row];
	MTPublicItem *item = _dataArr[indexPath.row];
	cell.titleLabel.text = item.noticeTitle;
	cell.content = item.noticeContent;
	
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
