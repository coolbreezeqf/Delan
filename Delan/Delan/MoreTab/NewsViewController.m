//
//  NewsViewController.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MTNetManager.h"
#import "MediaDataModels.h"
#import "MBProgressHUD+NJ.h"
#import "SVPullToRefresh.h"
#import "DLWebViewController.h"
@interface NewsViewController ()<UITableViewDataSource, UITableViewDelegate>{
	NSInteger totalNum;
	NSInteger currentPageNum;
	NSInteger pageSize;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) MTNetManager *manager;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	_manager = [[MTNetManager alloc] init];
	[self initData];
	[self initUI];
}

- (void)initUI{
	self.navigationItem.title = @"行业报道";
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	
	__weak NewsViewController *weakself = self;
	[self.tableView addPullToRefreshWithActionHandler:^{
		MLOG(@"respone pull to refresh");
		[weakself insertRowToTop];
	}];

	[_tableView.pullToRefreshView setTitle:@"下拉加载..." forState:SVPullToRefreshStateTriggered];
	[_tableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
	[_tableView.pullToRefreshView setTitle:@"已载入" forState:SVPullToRefreshStateStopped];

	[self.tableView addInfiniteScrollingWithActionHandler:^{
		MLOG(@"下拉加载");
		if (totalNum == currentPageNum) {
			[MBProgressHUD showError:@"已经没有更多内容了"];
		}else{
			[weakself addRowToBottom];
		}
	}];
}

- (void)initData{
	totalNum = 0;
	currentPageNum = 0;
	pageSize = 5;
	_dataArr = [NSMutableArray arrayWithCapacity:42];
	
	[self insertRowToTop];

//	NSDictionary *dic = @{@"image": @"ProductDetailBackgroud",
//						  @"title": @"银监会12年来首次大调整",
//						  @"content": @"银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整"};
//	NSDictionary *dic1 = @{@"image": @"ProductDetailBackgroud",
//						  @"title": @"银监会12年来首次大调整",
//						  @"content": @"银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整"};
//	NSDictionary *dic2 = @{@"image": @"ProductDetailBackgroud",
//						  @"title": @"银监会12年来首次大调整",
//						  @"content": @"银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整"};
//	_dataArr = @[dic,dic1,dic2];
}

- (void)insertRowToTop{
	__weak NewsViewController *weakself = self;
	[_manager getMediaInfoWith:1 andPageSize:pageSize succ:^(MTMediaHelpInfo *info) {
		totalNum = [info.totalNum integerValue];
		currentPageNum = [info.pageNum integerValue];
		[_dataArr removeAllObjects];
		[_dataArr addObjectsFromArray:info.item];
		[_tableView reloadData];
		[weakself.tableView.pullToRefreshView stopAnimating];
	} failure:^(NSDictionary *failDict, NSError *error) {
		[MBProgressHUD showError:@"服务器提交了一个错误"];
		[weakself.tableView.pullToRefreshView stopAnimating];
	}];
}

- (void)addRowToBottom{
	__weak NewsViewController *weakself = self;
	[_manager getMediaInfoWith:currentPageNum + 1 andPageSize:pageSize succ:^(MTMediaHelpInfo *info) {
		totalNum = [info.totalNum integerValue];
		currentPageNum = [info.pageNum integerValue];
		[_dataArr addObjectsFromArray:info.item];
		[_tableView reloadData];
		[weakself.tableView.infiniteScrollingView stopAnimating];
	} failure:^(NSDictionary *failDict, NSError *error) {
		[weakself.tableView.infiniteScrollingView stopAnimating];
	}];
}

#pragma mark - talbeview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [_dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	MTMediaItem *item = _dataArr[indexPath.section];
	return [NewsTableViewCell heightWithContent:item.noticeContent];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

	NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
	if (!cell) {
		cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewsCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	MTMediaItem *item = _dataArr[indexPath.section];
	
	[cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:[UIImage imageNamed:@"ProductDetailBackgroud"]];
	cell.titleLabel.text = item.noticeTitle;
	cell.content = item.noticeContent;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//跳转到webview
	MTMediaItem *item = _dataArr[indexPath.section];
	DLWebViewController *wvc = [[DLWebViewController alloc] initWithUrl:item.noticeUrl];
	[self.navigationController pushViewController:wvc animated:YES];
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
