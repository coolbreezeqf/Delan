//
//  HelpCenterTableViewController.m
//  Delan
//
//  Created by qf on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "HelpCenterTableViewController.h"
#import "HelpDetailViewController.h"
@interface HelpCenterTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *infoArr;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation HelpCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self initData];
	[self initUI];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)initUI{
	self.navigationItem.title = @"帮助中心";

	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.scrollEnabled = NO;
	[self.view addSubview:_tableView];
}

- (void)initData{
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"HelpCenterInfo" withExtension:@"plist"];
	_infoArr = [NSArray arrayWithContentsOfURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_infoArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HelpCenterCell"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[cell.imageView setImage:[UIImage imageNamed:_infoArr[indexPath.row][@"cellIcon"]]];
	cell.textLabel.text = _infoArr[indexPath.row][@"cellName"];
	cell.textLabel.font = kFont15;
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//TO DO
	[self.navigationController pushViewController:[[HelpDetailViewController alloc] init] animated:YES];
}




@end
