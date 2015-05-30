//
//  ProductController.m
//  Delan
//
//  Created by 广有射怪鸟事 on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductController.h"
#import "CustomTableViewCell.h"
#import "SVPullToRefresh.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "ProductModel.h"

/**
 *  定位宏
 */
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kButtonWidth [[UIScreen mainScreen] bounds].size.width / 3
#define tableUrl @"http://192.168.1.108:8080/mobile/finance/getProductList.json"

@interface ProductController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


@property(nonatomic,strong)UIView *topButtonView;//顶部按钮view

@property(nonatomic,strong)UIScrollView *rootScrollView;

@property(nonatomic,strong)NSMutableArray *productListArray;//产品数组

@property(nonatomic,strong)NSMutableArray *carArray;

@property(nonatomic,strong)NSMutableArray *houseArray;

@property(nonatomic,strong)NSMutableArray *productArray;//产品类型数组

@property(nonatomic,strong)NSMutableArray *buttonArray;//按钮数组

@property(nonatomic,strong)NSMutableArray *tableArray;//表格数组

@property(nonatomic,strong)UIButton *lastButton;//上一个按钮

@property(nonatomic,strong)UIView *selectedView;//按钮选中效果

@property(nonatomic,strong)UIView *sortView;//排序view

@property(nonatomic,strong)UIButton *hideSortViewButton;//隐藏sortview的button

@property(nonatomic,strong)UITableView *allTableView;

@property(nonatomic,strong)UITableView *carTableView;

@property(nonatomic,strong)UITableView *houseTableView;


@end

@implementation ProductController

#pragma mark 懒加载

- (NSMutableArray *)carArray{
    if (_carArray == nil) {
        _carArray = [NSMutableArray array];
    }
    return _carArray;
}

- (NSMutableArray *)houseArray{
    if (_houseArray == nil) {
        _houseArray = [NSMutableArray array];
    }
    return _houseArray;
}

- (NSMutableArray *)productListArray{
    if (_productListArray == nil) {
        _productListArray = [NSMutableArray array];
    }
    return _productListArray;
}

- (NSMutableArray *)productArray {
    
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

- (NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)tableArray{
    if (_tableArray == nil) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.rootScrollView triggerPullToRefresh];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"理财产品";
    [self createTopButtonView];
    [self createTableView];
    [self updateModel];
    
}

#pragma mark 网络请求

-(void)updateModel{
    
    AFHTTPRequestOperationManager *manaager = [AFHTTPRequestOperationManager manager];
    
    NSString * requestUrl = tableUrl;
    NSDictionary * requestDict = @{@"token":@"PFxTXXRLdw1eb........",
                                   @"index":@"0",
                                   @"number":@"10",
                                   @"type":@"0"};
    [manaager POST:requestUrl parameters:requestDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * resultDict = (NSDictionary *)responseObject;
        
        NSLog(@"%@",responseObject);
        
        NSArray * resultArray = resultDict[@"data"][@"result"];
        for (NSDictionary * dict in resultArray) {
            
            ProductModel *productModel = [[ProductModel alloc] initWithDict:dict];
            [self.productListArray addObject:productModel];
            
        }
        
        for (ProductModel *pro in self.productListArray) {
            if ([pro.type intValue] == 1) {
                [self.carArray addObject:pro];
            }
            else{
                [self.houseArray addObject:pro];
            }
        }
        
            [self.allTableView reloadData];
            [self.carTableView reloadData];
            [self.houseTableView reloadData];
        
        
        NSLog(@"%d,%d,%d",self.productListArray.count,self.carArray.count,self.houseArray.count);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常,请稍后再试"];
        NSLog(@"%@",error);
    }];
}

#pragma mark 创建底部表格
- (void)createTableView{
    self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 109, kScreenWidth, kScreenHeight - 109 - 40)];
    self.rootScrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.rootScrollView.tag = 501;
    self.rootScrollView.delegate = self;
    self.rootScrollView.bounces = NO;
    self.rootScrollView.directionalLockEnabled = YES;
    self.rootScrollView.userInteractionEnabled = YES;
    self.rootScrollView.pagingEnabled = YES;
    self.rootScrollView.showsHorizontalScrollIndicator = NO;
    self.rootScrollView.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
    
    //循环创建tableview
    
    self.allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 109 - 49) style:UITableViewStylePlain];
    self.allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.allTableView.delegate = self;
    self.allTableView.dataSource = self;
    self.allTableView.tag = 201;
    self.allTableView.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
    [self.rootScrollView addSubview:self.allTableView];
    
    self.carTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 109 - 49) style:UITableViewStylePlain];
    self.carTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.carTableView.delegate = self;
    self.carTableView.dataSource = self;
    self.carTableView.tag = 202;
    self.carTableView.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
    [self.rootScrollView addSubview:self.carTableView];
    
    self.houseTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - 109 - 49) style:UITableViewStylePlain];
    self.houseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.houseTableView.delegate = self;
    self.houseTableView.dataSource = self;
    self.houseTableView.tag = 203;
    self.houseTableView.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
    [self.rootScrollView addSubview:self.houseTableView];
    
    __weak ProductController * weakVC = self;
    
    [weakVC.allTableView addPullToRefreshWithActionHandler:^{
        [weakVC refreshAction];
        [weakVC performSelector:@selector(stopRefreshAnimation) withObject:nil afterDelay:1];
    }];
    [weakVC.houseTableView addPullToRefreshWithActionHandler:^{
        [weakVC refreshAction];
        [weakVC performSelector:@selector(stopRefreshAnimation) withObject:nil afterDelay:1];
    }];
    [weakVC.carTableView addPullToRefreshWithActionHandler:^{
        [weakVC refreshAction];
        [weakVC performSelector:@selector(stopRefreshAnimation) withObject:nil afterDelay:1];
    }];
    
    [weakVC.allTableView.pullToRefreshView setTitle:@"下拉可以刷新" forState:SVPullToRefreshStateStopped];
    [weakVC.allTableView.pullToRefreshView setTitle:@"正在帮你刷新" forState:SVPullToRefreshStateLoading];
    [weakVC.allTableView.pullToRefreshView setTitle:@"松开立即刷新" forState:SVPullToRefreshStateTriggered];
    
    [weakVC.carTableView.pullToRefreshView setTitle:@"下拉可以刷新" forState:SVPullToRefreshStateStopped];
    [weakVC.carTableView.pullToRefreshView setTitle:@"正在帮你刷新" forState:SVPullToRefreshStateLoading];
    [weakVC.carTableView.pullToRefreshView setTitle:@"松开立即刷新" forState:SVPullToRefreshStateTriggered];
    
    [weakVC.houseTableView.pullToRefreshView setTitle:@"下拉可以刷新" forState:SVPullToRefreshStateStopped];
    [weakVC.houseTableView.pullToRefreshView setTitle:@"正在帮你刷新" forState:SVPullToRefreshStateLoading];
    [weakVC.houseTableView.pullToRefreshView setTitle:@"松开立即刷新" forState:SVPullToRefreshStateTriggered];
    
    [self.view addSubview:self.rootScrollView];
}

#pragma mark 刷新事件
-(void)refreshAction{
    [self.productListArray removeAllObjects];
    [self.carArray removeAllObjects];
    [self.houseArray removeAllObjects];
    [self updateModel];
    if (self.rootScrollView.contentOffset.x < kScreenWidth) {
        [self.allTableView reloadData];
    }
    else if (kScreenWidth == self.rootScrollView.contentOffset.x){
        [self.carTableView reloadData];
    }
    else{
        [self.houseTableView reloadData];
    }
}

//停止下拉刷新
-(void)stopRefreshAnimation{
    if (self.rootScrollView.contentOffset.x < kScreenWidth / 2) {
        [self.allTableView.pullToRefreshView stopAnimating];
    }
    else if (kScreenWidth == self.rootScrollView.contentOffset.x){
        [self.carTableView.pullToRefreshView stopAnimating];
    }
    else{
        [self.houseTableView.pullToRefreshView stopAnimating];
    }
}

#pragma mark 创建顶部按钮
-(void)createTopButtonView{
    self.topButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 45)];
    self.topButtonView.backgroundColor = [UIColor whiteColor];
    
    self.productArray = @[@"全部产品",@"车贷宝",@"房贷宝"];
    
    int buttonX = 0;
    int buttonTag = 301;
    for (int i = 0; i < self.productArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, kButtonWidth, 45)];
        [btn setTitle:self.productArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:83.0/255 green:114.0/255 blue:185.0/255 alpha:1.0] forState:UIControlStateSelected];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setBorderWidth:0.5];   //边框宽度
        btn.tag = buttonTag;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 244.0/255, 245.0/255, 246.0/255, 1 });
        [btn.layer setBorderColor:colorref];//边框颜色
        [btn setFont :[UIFont fontWithName:@"Helvetica-Bold" size:12.0]];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        buttonX += kButtonWidth;
        buttonTag++;
        [self.topButtonView addSubview:btn];
        [self.buttonArray addObject:btn];
        if (btn.tag == 301) {
            btn.selected = YES;
            self.lastButton = btn;
        }
    }
    
    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth / 3, 1)];
    self.selectedView.backgroundColor = [UIColor colorWithRed:83.0/255 green:114.0/255 blue:185.0/255 alpha:1.0];
    [self.topButtonView addSubview:self.selectedView];
    
    [self.view addSubview:self.topButtonView];
}

#pragma mark 顶部按钮点击事件
- (void)buttonClickAction:(UIButton *)btn{
    self.lastButton.selected = NO;
    self.lastButton = btn;
    btn.selected = YES;
    
    if (btn.tag == 301) {
        [self.rootScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.selectedView setFrame:CGRectMake(0, 44, kScreenWidth / 3, 1)];
    }
    else if (btn.tag == 302){
        [self.rootScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        [self.selectedView setFrame:CGRectMake(kScreenWidth / 3, 44, kScreenWidth / 3, 1)];
    }
    else{
        [self.rootScrollView setContentOffset:CGPointMake(kScreenWidth * 2, 0) animated:YES];
        [self.selectedView setFrame:CGRectMake(kScreenWidth / 3 * 2, 44, kScreenWidth / 3, 1)];
    }
}

#pragma mark tableview代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 201) {
        return self.productListArray.count;
    }
    else if (tableView.tag == 202){
        return self.carArray.count;
    }
    else{
        return self.houseArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 201) {
        static NSString *myId1=@"myId";
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myId1];
        NSString *cellName = @"";
        if (kScreenWidth == 320) {
            cellName = @"CustomTableViewCell320";
        }
        else if (kScreenWidth == 375){
            cellName = @"CustomTableViewCell375";
        }
        else{
            cellName = @"CustomTableViewCell414";
        }
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        }
        
            ProductModel *pro = [self.productListArray objectAtIndex:indexPath.row];
            cell.ProductCellName.text = pro.name;
            NSString *r = [NSString stringWithFormat:@"%.2f%%",pro.rate];
            cell.ProductCellRate.text = r;
            cell.ProductCellTime.text = [NSString stringWithFormat:@"%@天",pro.days];
            NSString *m = [NSString stringWithFormat:@"%.2f元",pro.startMoney];
            cell.ProductCellMoney.text = m;
        
            if ([pro.status intValue] == 5) {
                
                if ([pro.isVip intValue] == 1) {
                    cell.ProductCellVipStatus.image = [UIImage imageNamed:@"ProductCellVip"];
                    cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft2"];
                    cell.ProductCellRate.textColor = RGBCOLOR(250.0, 169.0, 109.0);
                }
                else{
                    cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft"];
                    cell.ProductCellRate.textColor = RGBCOLOR(135.0, 171.0, 225.0);
                    cell.ProductCellVipStatus.image = nil;
                }
            }
            else if ([pro.status intValue] == 6){
                cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft3"];
                cell.ProductCellRate.textColor = RGBCOLOR(167.0, 190.0, 110.0);
                cell.ProductCellVipStatus.image = nil;
                
            }
            else if ([pro.status intValue] == 8){
                cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft4"];
                cell.ProductCellRate.textColor = RGBCOLOR(169.0, 170.0, 171.0);
                cell.ProductCellVipStatus.image = nil;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
        
        return cell;
    }
    else if (tableView.tag == 202){
        static NSString *myId2=@"myId";
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myId2];
        NSString *cellName = @"";
        if (kScreenWidth == 320) {
            cellName = @"CustomTableViewCell320";
        }
        else if (kScreenWidth == 375){
            cellName = @"CustomTableViewCell375";
        }
        else{
            cellName = @"CustomTableViewCell414";
        }
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        }
        
        ProductModel *pro = [self.carArray objectAtIndex:indexPath.row];
        cell.ProductCellName.text = pro.name;
        NSString *r = [NSString stringWithFormat:@"%.2f%%",pro.rate];
        cell.ProductCellRate.text = r;
        cell.ProductCellTime.text = [NSString stringWithFormat:@"%@天",pro.days];
        NSString *m = [NSString stringWithFormat:@"%.2f元",pro.startMoney];
        cell.ProductCellMoney.text = m;
        
        if ([pro.status intValue] == 5) {
            
            if ([pro.isVip intValue] == 1) {
                cell.ProductCellVipStatus.image = [UIImage imageNamed:@"ProductCellVip"];
                cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft2"];
                cell.ProductCellRate.textColor = RGBCOLOR(250.0, 169.0, 109.0);
            }
            else{
                cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft"];
                cell.ProductCellRate.textColor = RGBCOLOR(135.0, 171.0, 225.0);
                cell.ProductCellVipStatus.image = nil;
            }
        }
        else if ([pro.status intValue] == 6){
            cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft3"];
            cell.ProductCellRate.textColor = RGBCOLOR(167.0, 190.0, 110.0);
            cell.ProductCellVipStatus.image = nil;
            
        }
        else if ([pro.status intValue] == 8){
            cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft4"];
            cell.ProductCellRate.textColor = RGBCOLOR(169.0, 170.0, 171.0);
            cell.ProductCellVipStatus.image = nil;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
        
        return cell;
    }
    else{
        static NSString *myId3=@"myId";
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myId3];
        
        NSString *cellName = @"";
        if (kScreenWidth == 320) {
            cellName = @"CustomTableViewCell320";
        }
        else if (kScreenWidth == 375){
            cellName = @"CustomTableViewCell375";
        }
        else{
            cellName = @"CustomTableViewCell414";
        }
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        }
        
        ProductModel *pro = [self.houseArray objectAtIndex:indexPath.row];
        cell.ProductCellName.text = pro.name;
        NSString *r = [NSString stringWithFormat:@"%.2f%%",pro.rate];
        cell.ProductCellRate.text = r;
        cell.ProductCellTime.text = [NSString stringWithFormat:@"%@天",pro.days];
        NSString *m = [NSString stringWithFormat:@"%.2f元",pro.startMoney];
        cell.ProductCellMoney.text = m;
        
        if ([pro.status intValue] == 5) {
            
            if ([pro.isVip intValue] == 1) {
                cell.ProductCellVipStatus.image = [UIImage imageNamed:@"ProductCellVip"];
                cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft2"];
                cell.ProductCellRate.textColor = RGBCOLOR(250.0, 169.0, 109.0);
            }
            else{
                cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft"];
                cell.ProductCellRate.textColor = RGBCOLOR(135.0, 171.0, 225.0);
                cell.ProductCellVipStatus.image = nil;
            }
        }
        else if ([pro.status intValue] == 6){
            cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft3"];
            cell.ProductCellRate.textColor = RGBCOLOR(167.0, 190.0, 110.0);
            cell.ProductCellVipStatus.image = nil;
            
        }
        else if ([pro.status intValue] == 8){
            cell.ProductCellStatusLine.image = [UIImage imageNamed:@"ProductCellLeft4"];
            cell.ProductCellRate.textColor = RGBCOLOR(169.0, 170.0, 171.0);
            cell.ProductCellVipStatus.image = nil;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:244.0/255 green:245.0/255 blue:246.0/255 alpha:1.0];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


#pragma mark scroll代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.tag == 501) {
        UIButton *btn0 = [self.buttonArray objectAtIndex:0];
        UIButton *btn1 = [self.buttonArray objectAtIndex:1];
        UIButton *btn2 = [self.buttonArray objectAtIndex:2];
        
        self.lastButton.selected = NO;
        
        if (scrollView.contentOffset.x <= kScreenWidth / 2) {
            btn0.selected = YES;
            [self.rootScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            [self.selectedView setFrame:CGRectMake(0, 44, kScreenWidth / 3, 1)];
            self.lastButton = btn0;
        }else if (kScreenWidth / 2 < scrollView.contentOffset.x && scrollView.contentOffset.x <= kScreenWidth * 3 / 2){
            btn1.selected = YES;
            [self.rootScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
            [self.selectedView setFrame:CGRectMake(kScreenWidth / 3, 44, kScreenWidth / 3, 1)];
            self.lastButton = btn1;
        }else if (kScreenWidth * 3 / 2 < scrollView.contentOffset.x){
            btn2.selected = YES;
            [self.rootScrollView setContentOffset:CGPointMake(kScreenWidth * 2, 0) animated:YES];
            [self.selectedView setFrame:CGRectMake(kScreenWidth / 3 * 2, 44, kScreenWidth / 3, 1)];
            self.lastButton = btn2;
        }
        
    }
    else{
        return;
    }
    
}


@end
