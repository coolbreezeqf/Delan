//
//  InvestRecordsController.m
//  Delan
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestRecordsController.h"
#import "InvestedUser.h"
#import "InvestedUserCell.h"

#define investedUserCellHeight 44.0
#define investedUserTitleViewHeight 25.0

@interface InvestRecordsController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation InvestRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 177);

    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, investedUserTitleViewHeight, kMainScreenWidth, kMainScreenHeight - 177 - investedUserTitleViewHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self setTitleView];
    [self.view addSubview:tableView];
}


- (void)setTitleView {
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, investedUserTitleViewHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel * userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, investedUserTitleViewHeight)];
    userLabel.text = @"用户";
    userLabel.font = kFont14;
    userLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * investMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2 - 70, 0, 120, investedUserTitleViewHeight)];
    investMoneyLabel.text = @"投资金额 (元)";
    investMoneyLabel.font = kFont14;
    investMoneyLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth - 140, 0, 140, investedUserTitleViewHeight)];
    timeLabel.text = @"时间";
    timeLabel.font = kFont14;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:userLabel];
    [titleView addSubview:investMoneyLabel];
    [titleView addSubview:timeLabel];
    
    [self.view addSubview:titleView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"investedUserCell";
    InvestedUserCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InvestedUserCell alloc] init];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return investedUserCellHeight;
}


@end
