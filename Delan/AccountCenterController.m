//
//  AccountCenterController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountCenterController.h"
#import "AccountCenterHeaderTableViewCell.h"
#import "AccountManageController.h"
#import "InvestRecordController.h"
#import "BackProjectController.h"
#import "InvestDetailController.h"
#import "CardManageController.h"
#import "MyVipController.h"
#import "SVPullToRefresh.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "AccountCenterModel.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kUrl @"http://yingzibaiye.oicp.net/mobile/user/myProperty.json"

@interface AccountCenterController ()

@property (nonatomic,strong)AccountCenterHeaderTableViewCell *headerView;

@property (nonatomic,strong)AccountCenterModel *model;

@property (nonatomic,strong)UITableView *table;

@end

@implementation AccountCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的账户";
    [self createTableView];
    [self createNavigationButton];
    [self updateModel];
    
}

#pragma mark 网络请求
- (void)updateModel{
    AFHTTPRequestOperationManager *manaager = [AFHTTPRequestOperationManager manager];
    
    NSString * requestUrl = kUrl;
    NSDictionary * requestDict = @{@"token":@"kshdfkdshf",
                                   @"mobile":@"13999999999"};
    [manaager POST:requestUrl parameters:requestDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * resultDict = (NSDictionary *)responseObject;
        
        NSDictionary *dict = resultDict[@"data"][@"info"];
            
        self.model = [[AccountCenterModel alloc] initWithDict:dict];

        NSLog(@"%@",responseObject);
        
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常,请稍后再试"];
        NSLog(@"%@",error);
    }];
}

#pragma mark 创建tableview
- (void)createTableView{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    __weak AccountCenterController * weakVC = self;
    
    [weakVC.table addPullToRefreshWithActionHandler:^{
        [weakVC refreshAction];
        [weakVC performSelector:@selector(stopRefreshAnimation) withObject:nil afterDelay:1];
    }];
    
}

#pragma mark 刷新事件
-(void)refreshAction{
    [self.table reloadData];
}

//停止下拉刷新
-(void)stopRefreshAnimation{
    [self.table.pullToRefreshView stopAnimating];
}

#pragma mark 创建navigation按钮
- (void)createNavigationButton{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 18)];
    [btn setImage:[UIImage imageNamed:@"AccountCenterRefresh"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(reflashButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *reflashButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = reflashButton;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(0, 0, 20, 18)];
    [btn1 setImage:[UIImage imageNamed:@"AccountCenterSetting"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pushToSettingViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItem = sortButton;

}

- (void)reflashButtonAction{
    
}

- (void)pushToSettingViewAction{
    AccountManageController *mgView = [[AccountManageController alloc] init];
    [self.navigationController pushViewController:mgView animated:YES];
}

- (void)buyNowAction{
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark tableview代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *ar = @[@"投资记录",@"回款计划",@"资金明细",@"银行卡管理",@"我的Vip"];
    
    if (indexPath.row == 0) {
        NSString *cellName = @"";
        if (kScreenWidth == 320) {
            cellName = @"AccountCenterHeaderTableViewCell320";
        }
        else if (kScreenWidth == 375){
            cellName = @"AccountCenterHeaderTableViewCell375";
        }
        else{
            cellName = @"AccountCenterHeaderTableViewCell414";
        }
        
        
        static NSString *myId1 = @"myId";
        AccountCenterHeaderTableViewCell *cell = (AccountCenterHeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myId1];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        }
        cell.AccountCenterTotalMoney.text = [NSString stringWithFormat:@"总资产:%@元",self.model.totalMoney];
        cell.AccountCenterRest.text = [NSString stringWithFormat:@"可用余额:%@元",self.model.restMoney];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.AccountCenterBuyNowButton addTarget:self action:@selector(buyNowAction) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    else{
        static NSString *myId2 = @"myId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myId2];
        
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId2];
            cell.textLabel.text = [ar objectAtIndex:indexPath.row - 1];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        InvestRecordController *invest = [[InvestRecordController alloc] init];
        [self.navigationController pushViewController:invest animated:YES];
    }
    else if (indexPath.row == 2){
        BackProjectController *back = [[BackProjectController alloc] init];
        [self.navigationController pushViewController:back animated:YES];
    }
    else if (indexPath.row == 3){
        InvestDetailController *in = [[InvestDetailController alloc] init];
        [self.navigationController pushViewController:in animated:YES];
    }
    else if (indexPath.row == 4){
        CardManageController *card = [[CardManageController alloc] init];
        [self.navigationController pushViewController:card animated:YES];
    }
    else if (indexPath.row == 5){
        MyVipController *myVip = [[MyVipController alloc] init];
        [self.navigationController pushViewController:myVip animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 230;
    }
    else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}



@end
