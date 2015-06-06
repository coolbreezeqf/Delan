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
@interface NewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}

- (void)initData{
//	_dataArr = [NSMutableArray arrayWithCapacity:42];
	
	NSDictionary *dic = @{@"image": @"ProductDetailBackgroud",
						  @"title": @"银监会12年来首次大调整",
						  @"content": @"银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整"};
	NSDictionary *dic1 = @{@"image": @"ProductDetailBackgroud",
						  @"title": @"银监会12年来首次大调整",
						  @"content": @"银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整"};
	NSDictionary *dic2 = @{@"image": @"ProductDetailBackgroud",
						  @"title": @"银监会12年来首次大调整",
						  @"content": @"银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整银监会12年来首次大调整"};
	_dataArr = @[dic,dic1,dic2];
}

#pragma mark - talbeview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [_dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return [NewsTableViewCell heightWithContent:_dataArr[indexPath.section][@"content"]];
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
	
	NSDictionary *data = _dataArr[indexPath.section];
	
	[cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:@"adsf"] placeholderImage:[UIImage imageNamed:data[@"image"]]];
	cell.titleLabel.text = data[@"title"];
	cell.content = data[@"content"];
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
