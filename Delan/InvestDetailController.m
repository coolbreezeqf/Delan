//
//  InvestDetailController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/26.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "InvestDetailController.h"
#import "InvestDetailCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface InvestDetailController ()

@property (nonatomic,strong)UISegmentedControl *seControl;
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)InvestDetailCell *cell;


@end

@implementation InvestDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"投资明细";
    [self createView];
}

- (void)createView{
    self.seControl = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"收入",@"支出"]];
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
        cellName = @"InvestDetailCell320";
    }
    else if (kScreenWidth == 375){
        cellName = @"InvestDetailCell375";
    }
    else{
        cellName = @"InvestDetailCell414";
    }
    
    static NSString *myId=@"myId";
    self.cell = (InvestDetailCell *)[tableView dequeueReusableCellWithIdentifier:myId];
    if(self.cell==nil)
    {
        self.cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.seControl.selectedSegmentIndex == 1) {
            self.cell.money.textColor = [UIColor greenColor];
        }
    }
    return self.cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

@end
