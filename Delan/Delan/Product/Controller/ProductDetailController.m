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
#import "MoreDetailView.h"
#import "ProductMoreDetailController.h"
#import "ProductDetailPictureInformation.h"
#import "ProductDetailLawBook.h"
#import "InvestRecordsController.h"
#import "CalculatorView.h"
#import "InvestController.h"
#import "UIScrollView+SVPullToRefresh.h"

//手机相关
#define iPhoneScreenWidth_small 320
#define iPhoneScreenWidth_middle 375
#define iPhoneScreenWidth_large 414
#define iPhoneScreenHeight_4 480
#define iPhoneScreenHeight_5 568
#define iPhoneScreenHeight_6 667
#define iPhoneScreenHeight_6Plus 736
#define navigationBarHeight (self.navigationController.navigationBar.frame.size.height)
#define tabBarHeight (self.tabBarController.tabBar.frame.size.height)
#define stateBarHeight 20


//定位宏 - 第一页详情
#define normalCellHeight 40
#define downPullViewHeight 100
#define calculatorViewHeight 63

//定位宏 - 第二页详情


//定位宏 - 利率计算器偏移量
#define kDistance_Height736 (navigationBarHeight+stateBarHeight+calculatorViewHeight)
#define kDistance_Height667 (navigationBarHeight+stateBarHeight+calculatorViewHeight)
#define kDistance_Height568 (navigationBarHeight+stateBarHeight+calculatorViewHeight)
#define kDistance_Height480 (navigationBarHeight+stateBarHeight+calculatorViewHeight+13)


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

/**
 *  更多详情界面
 */
@property (nonatomic, strong) MoreDetailView * moreDetailView;
@property (nonatomic, retain) InvestRecordsController * investRecordsController;

/**
 *  利率计算器
 */
@property (nonatomic, strong) UIButton * coverBtn;
@property (nonatomic, strong) CalculatorView * calculatorView;

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGBACOLOR(68, 90, 173, 0.4);
    //设置标题颜色
    NSMutableDictionary * style = [NSMutableDictionary dictionary];
    style[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //标题大小
    style[NSFontAttributeName] = kFont16;
    self.navigationController.navigationBar.titleTextAttributes = style;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置为非全屏化
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [self setTableViewHeader];
    
    [self addPullRefreshView];
    
    [self updateModel];
}


- (void)updateModel {
    
    //模拟网络数据
    self.productModel.productName = @"贸易投资 NO.134";
    self.productModel.saledPercent = 0.54;
    self.productModel.status = 1;
    self.productModel.isVip = 1;
    self.productModel.minPay = 1000;
    self.productModel.repayType = @"到期还本付息";
    self.productModel.repayDay = @"2015-05-29";
    self.productModel.pictureInfoUrl = @"http://www.baidu.com";
    self.productModel.lawBookUrl = @"http://sports.sina.com.cn";
    
    //更新导航栏标题
    self.navigationItem.title = self.productModel.productName;
    
    //清空动画线程
    [self.CA_display invalidate];
    self.CA_display = nil;
    //更新表头数据
    [self updateTableViewHeaderData];
}


- (void)setTableViewHeader {
    
    self.detailHeader = [DetailHeaderView headerViewWithTableView:self.tableView];
    self.tableView.tableHeaderView = self.detailHeader;
}


- (void)updateTableViewHeaderData {
    
    //根据得到的type和isVip综合确定产品类型并改球色
    self.detailHeader.typePercentView.type = self.productModel.status;
    self.detailHeader.typePercentView.isVip = self.productModel.isVip;
    
    //非vip产品隐藏vip头像
    if (0 == self.detailHeader.typePercentView.isVip) {
        self.detailHeader.vipIconLabel.hidden = YES;
    }
    else {
        self.detailHeader.vipIconLabel.hidden = NO;
    }
    
    _currentPercent = 0.0;
    CADisplayLink * CA_update = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayPercent)];
    [CA_update addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.CA_display = CA_update;
}


#pragma mark - 辅助功能
- (void)addPullRefreshView {
    
    __weak typeof(self) block_SELF = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [block_SELF updateModel];
        [block_SELF.tableView.pullToRefreshView stopAnimating];
    }];
    self.tableView.pullToRefreshView.backgroundColor = RGBACOLOR(86, 112, 187, 1.0);
    self.tableView.pullToRefreshView.textColor = [UIColor whiteColor];
    [self.tableView.pullToRefreshView setTitle:@"下拉可以刷新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"正在帮你刷新" forState:SVPullToRefreshStateLoading];
    [self.tableView.pullToRefreshView setTitle:@"松开立即刷新" forState:SVPullToRefreshStateTriggered];
    self.tableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.tableView.pullToRefreshView.activityIndicatorViewColor = [UIColor whiteColor];
    self.tableView.pullToRefreshView.arrowColor = [UIColor whiteColor];
    
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
    
    static NSString * identifier = @"reuseCell";
    UITableViewCell * cell;
    
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
            UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, downPullViewHeight)];
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
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UIScrollView * moreView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64 - calculatorViewHeight)];
            moreView.contentSize = CGSizeMake(kMainScreenWidth, moreView.frame.size.height + 1);
            if (moreView.pullToRefreshView == nil) {
                __weak typeof(moreView) block_MOREVIEW = moreView;
                [moreView addPullToRefreshWithActionHandler:^{
                    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    self.tableView.scrollEnabled = YES;
                    [block_MOREVIEW.pullToRefreshView stopAnimating];
                }];
                moreView.pullToRefreshView.textColor = [UIColor grayColor];
                [moreView.pullToRefreshView setTitle:@"下拉返回到上一页详情" forState:SVPullToRefreshStateStopped];
                [moreView.pullToRefreshView setTitle:@"正在返回" forState:SVPullToRefreshStateLoading];
                [moreView.pullToRefreshView setTitle:@"松开立即返回上一页" forState:SVPullToRefreshStateTriggered];
            }
            
            MoreDetailView * moreDetailView = [[MoreDetailView alloc] initWithFrame:moreView.frame];
            [moreDetailView.segControl addTarget:self action:@selector(changeDetailView) forControlEvents:UIControlEventValueChanged];
            self.moreDetailView = moreDetailView;
            [moreView addSubview:self.moreDetailView];
            [cell addSubview:moreView];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [investBtn addTarget:self action:@selector(invest) forControlEvents:UIControlEventTouchUpInside];
    [calculatorView addSubview:investBtn];
    
    UIButton * calculatorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calculatorBtn.frame = CGRectMake(0, 0, calculatorViewHeight, calculatorViewHeight);
    [calculatorBtn setBackgroundColor:RGBACOLOR(144, 179, 247, 1.0)];
    [calculatorBtn addTarget:self action:@selector(showCalculator) forControlEvents:UIControlEventTouchUpInside];
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
        if (kMainScreenHeight == iPhoneScreenHeight_6Plus) {
            return downPullViewHeight + (iPhoneScreenHeight_6Plus - iPhoneScreenHeight_6);
        }
        else {
            return downPullViewHeight;
        }
    }
    else {
        return kMainScreenHeight - 64 - calculatorViewHeight;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return calculatorViewHeight;
}


#pragma mark - UIScrollViewDelegate

//拖拽结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self autoScrollFounction:scrollView];
}

//滑动开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    [self autoScrollFounction:scrollView];
}


//减速到0
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self autoScrollFounction:scrollView];
}


//判断方法
- (void)autoScrollFounction:(UIScrollView *)scrollView {
    
    int downPullHeight;
    if (iPhoneScreenHeight_6Plus == kMainScreenHeight) {
        downPullHeight = downPullViewHeight + (iPhoneScreenHeight_6Plus - iPhoneScreenHeight_6);
    }
    else {
        downPullHeight = downPullViewHeight;
    }
    int margin = 64+320+3*normalCellHeight+downPullHeight+calculatorViewHeight-kMainScreenHeight;
    
    if ((scrollView.contentOffset.y > 0 + margin) && (scrollView.contentOffset.y <= 128 + margin)) {
        [scrollView setContentOffset:CGPointMake(0, margin) animated:YES];
    }
    if (scrollView.contentOffset.y > 128 + margin) {
        if (iPhoneScreenHeight_6Plus == kMainScreenHeight) {
            [scrollView setContentOffset:CGPointMake(0, 540 + (iPhoneScreenHeight_6Plus - iPhoneScreenHeight_6)) animated:YES];
            self.tableView.scrollEnabled = NO;
        }
        else {
            [scrollView setContentOffset:CGPointMake(0, 540) animated:YES];
            self.tableView.scrollEnabled = NO;
        }
    }
}


#pragma mark - 监听点击计算器按钮
- (void)showCalculator {
    
    //出现蒙层效果
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverBtn.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self.coverBtn.backgroundColor = [UIColor blackColor];
    [self.tableView addSubview:self.coverBtn];
    self.coverBtn.alpha = 0.6;
    self.tableView.scrollEnabled = NO;
    self.navigationItem.hidesBackButton = YES;
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    CGFloat calculatorHeight;
    
    if (736 == kMainScreenHeight) {
        calculatorHeight = kDistance_Height736;
    }
    else if (667 == kMainScreenHeight) {
        calculatorHeight = kDistance_Height667;
    }
    else if (568 == kMainScreenHeight) {
        calculatorHeight = kDistance_Height568;
    }
    else {
        calculatorHeight = kDistance_Height480;
    }
    
    
    self.calculatorView = [[CalculatorView alloc] calculatorCreate];
    
    //传递该产品的年化利率
    self.calculatorView.yearRate = self.productModel.yearRate / 100;
    
    self.calculatorView.center = CGPointMake(self.tableView.frame.size.width + self.calculatorView.frame.size.width / 2 , self.tableView.frame.size.height / 2 - calculatorHeight);
    [self.calculatorView.closeBtn addTarget:self action:@selector(closeCalculator:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.calculatorView];
    
    //计算器进场动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    //到终点时减速
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //改变center
    self.calculatorView.center = CGPointMake(self.tableView.frame.size.width / 2 - 30, self.tableView.frame.size.height / 2 - calculatorHeight);
    
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.15];
        //到终点时减速
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //改变center
        self.calculatorView.center = CGPointMake(self.tableView.frame.size.width / 2 , self.tableView.frame.size.height / 2 - calculatorHeight);
        
        [UIView commitAnimations];
    });
    
    
    //设置文本输入框的键盘的样式
    self.calculatorView.calculateMoney.keyboardType = UIKeyboardTypeDecimalPad;
    self.calculatorView.calculateDays.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.calculatorView.calculateMoney becomeFirstResponder];
}


- (void)closeCalculator:(UIButton *)btn {
    
    CGFloat calculatorHeight;
    
    if (736 == kMainScreenHeight) {
        calculatorHeight = kDistance_Height736;
    }
    else if (667 == kMainScreenHeight) {
        calculatorHeight = kDistance_Height667;
    }
    else if (568 == kMainScreenHeight) {
        calculatorHeight = kDistance_Height568;
    }
    else {
        calculatorHeight = kDistance_Height480;
    }
    
    //计算器出场动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    
    //到终点时减速
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //改变center
    self.calculatorView.center = CGPointMake(self.tableView.frame.size.width / 2 - 30, self.tableView.frame.size.height / 2 - calculatorHeight);
    
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.15];
        //起点时减速
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //改变center
        self.calculatorView.center = CGPointMake(self.tableView.frame.size.width + self.calculatorView.frame.size.width / 2, self.tableView.frame.size.height / 2 - calculatorHeight);
        
        [UIView commitAnimations];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.coverBtn.alpha = 0.0;
        self.tableView.scrollEnabled = YES;
        self.navigationItem.hidesBackButton = NO;
        [self.tableView endEditing:YES];
    });
}


#pragma mark - 监听点击投资按钮
- (void)invest {
    
    InvestController * investDest = [[InvestController alloc] init];
    [self.navigationController pushViewController:investDest animated:YES];
}


#pragma mark - 监听SegmentedControl切换视图
- (void)changeDetailView {
    
    //先清空容器视图上的所有子视图
    for (UIView * view in self.moreDetailView.availableView.subviews) {
        [view removeFromSuperview];
    }
    
    //再判断根据index添加相应子视图
    if (0 == self.moreDetailView.segControl.selectedSegmentIndex) {
        ProductMoreDetailController * moreVc = [[ProductMoreDetailController alloc] init];
        [self.moreDetailView.availableView addSubview:moreVc.view];
    }
    else if (1 == self.moreDetailView.segControl.selectedSegmentIndex) {
        ProductDetailPictureInformation * pictureInfoVc = [[ProductDetailPictureInformation alloc] init];
        pictureInfoVc.requestUrl = self.productModel.pictureInfoUrl;
        [self.moreDetailView.availableView addSubview:pictureInfoVc.view];
    }
    else if (2 == self.moreDetailView.segControl.selectedSegmentIndex) {
        ProductDetailLawBook * lawBook = [[ProductDetailLawBook alloc] init];
        lawBook.requestUrl = self.productModel.lawBookUrl;
        [self.moreDetailView.availableView addSubview:lawBook.view];
    }
    else if (3 == self.moreDetailView.segControl.selectedSegmentIndex) {
        InvestRecordsController * investRocordVc = [[InvestRecordsController alloc] init];
        self.investRecordsController = investRocordVc;
        [self.moreDetailView.availableView addSubview:self.investRecordsController.view];
    }
}



@end
