//
//  CardManageController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "CardManageController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface CardManageController ()

@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)NSMutableArray *nameAr;
@property (nonatomic,strong)NSMutableArray *numAr;

@end

@implementation CardManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"银行卡管理";
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = RGBCOLOR(228.0, 229.0, 230.0);
    [self.view addSubview:self.table];
    
    self.nameAr = [[NSMutableArray alloc] initWithObjects:@"中信银行",@"中信银行", nil];
    self.numAr = [[NSMutableArray alloc] initWithObjects:@"尾号2312",@"尾号2312", nil];
    
    [self naviButton];
}

#pragma mark 添加顶部按钮
- (void)naviButton{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(0, 0, 20, 18)];
    [btn1 setImage:[UIImage imageNamed:@"AccountManageCardAdd"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(addCard) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)addCard{
    NSLog(@"添加银行卡");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.nameAr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myId = @"myId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myId];
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myId];
        cell.imageView.image = [UIImage imageNamed:@"email"];
        cell.textLabel.text = [self.nameAr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.numAr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        [self.nameAr removeObjectAtIndex:indexPath.row];
        [self.numAr removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

@end
