//
//  BackProjectController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "BackProjectController.h"
#import "BackProjectHeaderCell.h"
#import "BackProjectCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface BackProjectController ()

@property (nonatomic,strong)BackProjectHeaderCell *headerView;
@property (nonatomic,strong)BackProjectCell *cell;
@property (nonatomic,strong)UISegmentedControl *seControl;
@property (nonatomic,strong)UITableView *table;

@end

@implementation BackProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"回款计划";
    [self createView];
}

- (void)createView{
    self.seControl = [[UISegmentedControl alloc] initWithItems:@[@"待回款明细",@"已回款明细"]];
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
        cellName = @"BackProjectCell320";
    }
    else if (kScreenWidth == 375){
        cellName = @"BackProjectCell375";
    }
    else{
        cellName = @"BackProjectCell414";
    }
    
    
    
    static NSString *myId=@"myId";
    self.cell = (BackProjectCell *)[tableView dequeueReusableCellWithIdentifier:myId];
    if(self.cell==nil)
    {
        self.cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.seControl.selectedSegmentIndex != 0) {
            self.cell.ysbj.text = @"已收本金(元)";
            self.cell.yslx.text = @"已收利息(元)";
        }
    }
    return self.cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    self.headerView = [BackProjectHeaderCell headerViewWithTableView:tableView index:self.seControl.selectedSegmentIndex];
    
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}


@end
