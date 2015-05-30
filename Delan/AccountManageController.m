//
//  AccountManageController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "AccountManageController.h"
#import "AccountManageViewCell.h"
#import "AccountManageOtherCell.h"
#import "AccountManageBindingController.h"
#import "AccountManageBindingEmailController.h"
#import "AccountManageKnowController.h"
#import "AccountManageEmergencyController.h"
#import "AccountManagePassController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kUrl @"http://192.168.1.108:8080//mobile/user/accountManage.json"

@interface AccountManageController ()

@property (nonatomic,strong) UITableView *rootTable;
@property (nonatomic,strong) UIActionSheet *myActionSheet;
@property (nonatomic,strong) AccountManageViewCell *cell;
@property (nonatomic,strong) NSString *filePath;//头像路径
@property (nonatomic,strong) UIImage *head;//头像

@end

@implementation AccountManageController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.head = [UIImage imageNamed:@"AccountCenterManageHead"];
    
    self.rootTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 50) style:UITableViewStyleGrouped];
    self.rootTable.delegate = self;
    self.rootTable.dataSource = self;
    self.rootTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rootTable.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rootTable];
    self.title = @"账户管理";
    
    [self updateModel];
    
}

#pragma mark 网络请求
- (void)updateModel{
    AFHTTPRequestOperationManager *manaager = [AFHTTPRequestOperationManager manager];
    
    NSString * requestUrl = kUrl;
    NSDictionary * requestDict = @{@"token":@"kshdfkdshf",
                                   @"mobile":@"13999999999"};
    [manaager POST:requestUrl parameters:requestDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * resultDict = (NSDictionary *)responseObject[@"data"][@"info"];
        
        NSLog(@"%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常,请稍后再试"];
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *ar = @[@"已绑定手机:137****1234",@"未绑定邮箱",@"已通过实名认证:习**",@"未添加紧急联系人",@"已设置登录密码"];
    NSArray *ir = @[@"AccountCenterPhone",@"AccountCenterEmail",@"AccountCenterKnow",@"AccountCenterCentent",@"AccountCenterPassword"];
    
    NSString *cellName = @"";
    if (kScreenWidth == 320) {
        cellName = @"AccountManageViewCell320";
    }
    else if (kScreenWidth == 375){
        cellName = @"AccountManageViewCell375";
    }
    else{
        cellName = @"AccountManageViewCell414";
    }
    
    if (indexPath.row == 0) {
        static NSString *myId=@"myId";
        self.cell = (AccountManageViewCell *)[tableView dequeueReusableCellWithIdentifier:myId];
        if (self.cell == nil) {
            self.cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
            self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.cell.headImg.image = self.head;
        }
        
        return self.cell;
        
    }
    else{
        static NSString *myId = @"myId";
        AccountManageOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:myId];
        if (cell == nil) {
            cell = [[AccountManageOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myId];
            cell.myIcon.image = [UIImage imageNamed:[ir objectAtIndex:indexPath.row - 1]];
            cell.myLabel.text = [ar objectAtIndex:indexPath.row - 1];
            cell.myLabel.font = [UIFont systemFontOfSize:14.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 90;
    }
    else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.rootTable deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSLog(@"none");
        return;
    }
    else if (indexPath.row == 1) {
        AccountManageBindingController *ab = [[AccountManageBindingController alloc] init];
        [self.navigationController pushViewController:ab animated:YES];
    }
    else if (indexPath.row == 2){
        AccountManageBindingEmailController *ae = [[AccountManageBindingEmailController alloc] init];
        [self.navigationController pushViewController:ae animated:YES];
    }
    else if (indexPath.row == 3){
        AccountManageKnowController *ak = [[AccountManageKnowController alloc] init];
        [self.navigationController pushViewController:ak animated:YES];
    }
    else if (indexPath.row == 4){
        AccountManageEmergencyController *aec = [[AccountManageEmergencyController alloc] init];
        [self.navigationController pushViewController:aec animated:YES];
    }
    else{
        AccountManagePassController *ap = [[AccountManagePassController alloc] init];
        [self.navigationController pushViewController:ap animated:YES];
    }
}

@end
