//
//  InvestRecordController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/25.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestRecordController.h"
#import "InvestRecordHeaderCell.h"
#import "InvestRecordCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface InvestRecordController ()

@property (nonatomic,strong)InvestRecordHeaderCell *headerView;
@property (nonatomic,strong)InvestRecordCell *cell;
@property (nonatomic,strong)UISegmentedControl *seControl;
@property (nonatomic,strong)UITableView *table;

@end

@implementation InvestRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"投资记录";
    [self createView];
}

- (void)createView{
    self.seControl = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"投资中",@"回款中",@"回款结束"]];
    self.seControl.selectedSegmentIndex = 0;
    [self.seControl addTarget:self action:@selector(seControlClick) forControlEvents:UIControlEventValueChanged];
    [self.seControl setFrame:CGRectMake(10, 74, kScreenWidth - 20, 30)];
    [self.view addSubview:self.seControl];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight - 64 - 30) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
}

- (void)seControlClick{
    [self.table reloadData];
}

#pragma mark tableview代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellName = @"";
    if (kScreenWidth == 320) {
        cellName = @"InvestRecordCell320";
    }
    else if (kScreenWidth == 375){
        cellName = @"InvestRecordCell375";
    }
    else{
        cellName = @"InvestRecordCell414";
    }
    
    
    
    static NSString *myId=@"myId";
    self.cell = (InvestRecordCell *)[tableView dequeueReusableCellWithIdentifier:myId];
    if(self.cell==nil)
    {
        self.cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.seControl.selectedSegmentIndex == 0) {
            NSLog(@"第一个");
        }
        else if (self.seControl.selectedSegmentIndex == 1){
            self.cell.investStatus.text = @"投资中";
        }
        else if (self.seControl.selectedSegmentIndex == 2){
            self.cell.investStatus.text = @"回款中";
        }
        else{
            self.cell.investStatus.text = @"已回款";
        }
    }
    return self.cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    self.headerView = [InvestRecordHeaderCell headerViewWithTableView:tableView index:self.seControl.selectedSegmentIndex];

    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}


@end
