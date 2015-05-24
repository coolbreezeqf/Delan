//
//  ProductDetailController.m
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "ProductDetailController.h"
#import "DetailHeaderView.h"
#import "PercentCircleView.h"
#import "ProductDetail.h"

#define normalCellHeight 40
#define dowmPullViewHeight 100
#define calculatorViewHeight 63

@interface ProductDetailController () <UIScrollViewDelegate> {
    
    //记录球当前的进度百分比
    CGFloat _currentPercent;
}

/**
 *  模型属性
 */
@property (nonatomic, strong) ProductDetail * productModel;


/**
 *  tableHeaderView
 */
@property (nonatomic, strong) CADisplayLink * CA_display;
@property (nonatomic, strong) DetailHeaderView * detailHeader;


@end

@implementation ProductDetailController

#pragma mark - 懒加载
- (ProductDetail *)productModel {
    if (_productModel == nil) {
        _productModel = [[ProductDetail alloc] init];
    }
    return _productModel;
}

#pragma mark - 初始化UI/网络请求
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated {
    
    //设置标题
    self.navigationItem.title = @"项目详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGBACOLOR(68, 90, 173, 0.4);
    //设置标题颜色
    NSMutableDictionary * style = [NSMutableDictionary dictionary];
    style[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //标题大小
    style[NSFontAttributeName] = kFont20;
    self.navigationController.navigationBar.titleTextAttributes = style;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewHeader];
    
    [self updateModel];
}


- (void)updateModel {
    
    self.productModel.saledPercent = 0.54;
    self.productModel.type = 0;
    self.productModel.minPay = 1000;
    self.productModel.repayType = @"到期还本付息";
    self.productModel.repayDay = @"2015-05-29";
    
    //更新表头数据
    [self updateTableViewHeaderData];
}


- (void)setTableViewHeader {
    
    self.detailHeader = [DetailHeaderView headerViewWithTableView:self.tableView];
    self.tableView.tableHeaderView = self.detailHeader;
}


- (void)updateTableViewHeaderData {
    
    //根据得到的type确定产品类型并改球色
    self.detailHeader.typePercentView.type = self.productModel.type;
    
    //非vip产品隐藏vip头像
    if (0 == self.detailHeader.typePercentView.type) {
        self.detailHeader.vipIconLabel.hidden = NO;
    }
    else {
        self.detailHeader.vipIconLabel.hidden = YES;
    }
    
    _currentPercent = 0.0;
    CADisplayLink * CA_update = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayPercent)];
    [CA_update addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.CA_display = CA_update;
}



#pragma mark - 持续更新动画
- (void)displayPercent {
    
    _currentPercent += self.productModel.saledPercent / 60.0;
    if (_currentPercent >= self.productModel.saledPercent) {
        self.detailHeader.typePercentView.percent = self.productModel.saledPercent;
        [self.CA_display invalidate];
        self.CA_display = nil;
    }
    else {
        self.detailHeader.typePercentView.percent = _currentPercent;
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"normalCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        if (0 == indexPath.row) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            cell.backgroundColor = RGBCOLOR(242, 247, 251);
            cell.textLabel.text = @"起投金额";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = kFontBold18;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d 元",self.productModel.minPay];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Futura" size:16.0];
        }
        else if (1 == indexPath.row) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            cell.backgroundColor = RGBCOLOR(242, 247, 251);
            cell.textLabel.text = @"还款方式";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = kFontBold18;
            cell.detailTextLabel.text = self.productModel.repayType;
            cell.detailTextLabel.font = [UIFont fontWithName:@"Futura" size:16.0];
        }
        else if (2 == indexPath.row) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            cell.backgroundColor = RGBCOLOR(242, 247, 251);
            cell.textLabel.text = @"还款日期";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = kFontBold18;
            cell.detailTextLabel.text = self.productModel.repayDay;
            cell.detailTextLabel.font = [UIFont fontWithName:@"Futura" size:16.0];
        }
        else if (3 == indexPath.row) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, dowmPullViewHeight)];
            UIImageView * arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProductDetailUpArrow"]];
            arrowView.center = CGPointMake(kMainScreenWidth/2, 40);
            arrowView.bounds = CGRectMake(0, 0, 18, 15);
            [customView addSubview:arrowView];
            
            UILabel * pullLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, 20)];
            pullLabel.font = kFontBold15;
            pullLabel.textColor = RGBACOLOR(208, 208, 208, 0.8);
            pullLabel.textAlignment = NSTextAlignmentCenter;
            pullLabel.text = @"—— 继续拖动,查看详情 ——";
            [customView addSubview:pullLabel];
            
            [cell addSubview:customView];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        }
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView * calculatorView = [[UIView alloc] init];
    
    UIButton * investBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    investBtn.frame = CGRectMake(calculatorViewHeight, 0, kMainScreenWidth - calculatorViewHeight, calculatorViewHeight);
    [investBtn setTitle:@"立 即 投 资" forState:UIControlStateNormal];
    investBtn.titleLabel.font = kFontBold20;
    [investBtn setBackgroundColor:RGBACOLOR(68, 90, 173, 1.0)];
    [investBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [calculatorView addSubview:investBtn];
    
    UIButton * calculatorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calculatorBtn.frame = CGRectMake(0, 0, calculatorViewHeight, calculatorViewHeight);
    [calculatorBtn setBackgroundColor:RGBACOLOR(144, 179, 247, 1.0)];
    [calculatorBtn addTarget:self action:@selector(invest) forControlEvents:UIControlEventTouchUpInside];
    [calculatorView addSubview:calculatorBtn];
    
    UIImageView * calculatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProductDetailCalculator"]];
    calculatorImageView.frame = CGRectMake(10, 15, 43, 33);
    [calculatorBtn addSubview:calculatorImageView];
    
    return calculatorView;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.row || 1 == indexPath.row || 2 == indexPath.row) {
        return normalCellHeight;
    }
    else if (3 == indexPath.row) {
        return dowmPullViewHeight;
    }
    else {
        return (kMainScreenHeight - 64 - 49);
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return calculatorViewHeight;
}


#pragma mark - UIScrollViewDelegate



#pragma mark - 监听点击立即投资
- (void)invest {
    
    NSLog(@"执行立即投资");
}







@end
