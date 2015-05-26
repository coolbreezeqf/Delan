//
//  MoreViewController.m
//  Delan
//
//  Created by qf on 15/5/20.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "MoreViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "HelpCenterTableViewController.h"
#import "FeedBackViewController.h"
#import "NewsViewController.h"
#import "IntroduceViewController.h"
#import "NoticeViewController.h"
@interface MoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *rowInfo;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self initUI];
	[self initData];
}

- (void)viewWillAppear:(BOOL)animated{
//	self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
	self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - set UI
- (void)initUI{
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.title = @"更 多";
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	[self.view addSubview:_tableView];
}

#pragma mark - set Data
- (void)initData{
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"MoreTabInfo" withExtension:@"plist"];
	NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
	_rowInfo = dic[@"tableViewInfo"];
}

#pragma mark - action
- (void)logoutUser{
	
}

#pragma mark - tableView delegate and datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreTabCell"];
	if (indexPath.section == 2) {
		//退出登录按钮
		UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
		[btn addTarget:self action:@selector(logoutUser) forControlEvents:UIControlEventTouchDown];
		[btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[cell addSubview:btn];
	}else{
		//设置cell
		cell.textLabel.text = _rowInfo[indexPath.section][indexPath.row][@"cellName"];
		cell.textLabel.font = kFont15;
		[cell.imageView setImage:[UIImage imageNamed:_rowInfo[indexPath.section][indexPath.row][@"cellIcon"]]];
	}
	
	//设置
	if (indexPath.section != 2) {
		if (indexPath.row == 3) {
			//版本信息
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
			label.font = kFont15;
#warning 动态获取
			label.text = @"V1.2.4";
			label.textColor = [UIColor grayColor];
			cell.accessoryView = label;
		}else{
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0) {
		switch (indexPath.row) {
			case 0:{
				IntroduceViewController *ivc = [[IntroduceViewController alloc] init];
				[self.navigationController pushViewController:ivc animated:YES];
			}break;
			case 1:{
				//官方公告
				NoticeViewController *nvc = [[NoticeViewController alloc] init];
				[self.navigationController pushViewController:nvc animated:YES];
			}break;
			case 2:{
				NewsViewController *nvc = [[NewsViewController alloc] init];
				[self.navigationController pushViewController:nvc animated:YES];
			}break;

			default:break;
		}
	}else if(indexPath.section == 1){
		switch (indexPath.row) {
			case 0:{
				HelpCenterTableViewController *hvc = [[HelpCenterTableViewController alloc] init];
				[self.navigationController pushViewController:hvc animated:YES];
			}break;
			case 1:{
				FeedBackViewController *fbvc = [[FeedBackViewController alloc] init];
				[self.navigationController pushViewController:fbvc animated:YES];
			}break;
			default:{
			}break;
		}
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if (section == 0) {
		return 0.1;
	}
	return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger num = 0;
	switch (section) {
	case 0: num = 3;break;
		case 1: num = 4; break;
		case 2: num = 1; break;
	default:
			break;
	}
	return num;
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
