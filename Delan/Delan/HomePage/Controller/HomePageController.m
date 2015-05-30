//
//  HomePageController.m
//  Delan
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "HomePageController.h"
#import "UIImageView+WebCache.h"
#import "SVPullToRefresh.h"
#import "ProductDetailController.h"
#import "CircleView.h"
#import "ProductDetail.h"
#import "ProgressCircleView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.m"

/**
 *  定位宏
 */
#define topScrollViewHeight 170
#define dataCenterHeight 35

/**
 *  手机相关
 */
#define iPhoneScreenWidth_small 320
#define iPhoneScreenWidth_middle 375
#define iPhoneScreenWidth_large 414
#define iPhoneScreenHeight_4 480
#define iPhoneScreenHeight_5 568
#define iPhoneScreenHeight_6 667
#define iPhoneScreenHeight_6Plus 736


@interface HomePageController () <UIScrollViewDelegate> {
    
    NSUInteger _advertisementImageCount;
}

/* productDetail模型 */
@property (nonatomic, strong) ProductDetail * productDetail;

/* HomePage滚动view */
@property (nonatomic, strong) UIScrollView * pageScrollView;

/* 广告view */
@property (nonatomic, strong) NSMutableArray * imageUrlArray;
@property (nonatomic, strong) UIScrollView * topScrollView;
@property (nonatomic, strong) UIPageControl * pageControl;

/* 平台数据 */
@property (nonatomic, strong) UILabel * userDataLabel;
@property (nonatomic, strong) UILabel * moneyDataLabel;

/* 动画球View */
@property (nonatomic, strong) CircleView * circleView;
@property (nonatomic, strong) CADisplayLink * CA_Progress;

@end

@implementation HomePageController

#pragma mark - 懒加载
- (NSMutableArray *)imageUrlArray {
    
    if (_imageUrlArray == nil) {
        _imageUrlArray = [NSMutableArray array];
        for (int i = 0; i < _advertisementImageCount; i ++) {
            NSString * imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"rollview_test_%d.png",i+1] ofType:nil];
            [_imageUrlArray addObject:imagePath];
        }
    }
    return _imageUrlArray;
}


#pragma mark - 初始化UI/网络请求
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}


- (void)viewWillAppear:(BOOL)animated {
    
    //设置标题
    self.navigationItem.title = @"首 页";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //设置标题颜色
    NSMutableDictionary * style = [NSMutableDictionary dictionary];
    style[NSForegroundColorAttributeName] = [UIColor blackColor];
    //标题大小
    style[NSFontAttributeName] = kFont16;
    self.navigationController.navigationBar.titleTextAttributes = style;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置不全屏
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    _advertisementImageCount = 5;
    
    UIScrollView * pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    if (iPhoneScreenHeight_6 == kMainScreenHeight || iPhoneScreenHeight_6Plus == kMainScreenHeight) {
        pageScrollView.contentSize = CGSizeMake(0, pageScrollView.frame.size.height + 1);
    }
    else if (iPhoneScreenHeight_5 == kMainScreenHeight) {
        pageScrollView.contentSize = CGSizeMake(0, pageScrollView.frame.size.height + 50);
    }
    else {
        pageScrollView.contentSize = CGSizeMake(0, pageScrollView.frame.size.height + 138);
    }
    
    pageScrollView.backgroundColor = RGBCOLOR(240, 240, 240);
    self.pageScrollView = pageScrollView;
    
    [self setTopScrollView];
    
    [self setDataCenter];
    
    [self addPullToRefreshView];
    
    [self setCircleView];
    
    [self.view addSubview:self.pageScrollView];
    
    [self updateModel];
}


//请求-精品推荐
- (void)updateModel {
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * requestUrl = @"localhost/192.168.1.110:8080/mobile/offer/prooffer.json";
    NSDictionary * requestDict = @{@"token":@"delan168"};
    
    [manager POST:requestUrl parameters:requestDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * resultDict = responseObject[@"data"][@"proInfo"];
        ProductDetail * model = [ProductDetail ProductDetailWithDict:resultDict];
        self.productDetail = model;
        
        //初始化动画线程
        [self.CA_Progress invalidate];
        self.CA_Progress = nil;
        //求动画进度清零
        self.circleView.progressCircleView.percent = 0.0;
        //刷新动画球上的数据
        [self updateCircleView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常,请稍后再试"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];
}


//请求-平台数据
- (void)updateModel2 {
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * requestUrl = @"localhost/192.168.1.110:8080/mobile/offer/getTotal.json";
    NSDictionary * requestDict = @{@"token":@"delan168"};
    
    [manager POST:requestUrl parameters:requestDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * resultDict = responseObject[@"data"][@"info"];
        NSMutableDictionary * dataDict = [NSMutableDictionary dictionary];
        [dataDict setValue:resultDict[@"sumMoney"] forKey:@"moneyData"];
        [dataDict setValue:resultDict[@"sumUser"] forKey:@"userData"];
        //刷新平台数据
        [self updateCenterDataWithDict:dataDict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常,请稍后再试"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];
}


//请求-广告图片
- (void)updateModel3 {
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSString * requestUrl = @"localhost/192.168.1.110:8080/mobile/offer/image.json";
    NSDictionary * requestDict = @{@"token":@"delan168"};
    
    [manager POST:requestUrl parameters:requestDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * resultDict = responseObject[@"data"][@"img"];
        for (NSString * imageUrlString in resultDict) {
            [self.imageUrlArray addObject:imageUrlString];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常,请稍后再试"];
    }];
}


//设置广告view
- (void)setTopScrollView {
    
    UIScrollView * topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, topScrollViewHeight)];
    
    //(原理：5-1-2-3-4-5-1，所以要7个宽度的contentSize)
    topScrollView.contentSize = CGSizeMake((_advertisementImageCount + 2) * topScrollView.frame.size.width,0);
    
    //填充图片
    for (int i = 0; i < _advertisementImageCount; i ++) {
        
        UIImageView * imageView = [[UIImageView alloc] init];
        
        [imageView setImage:[UIImage imageWithContentsOfFile:self.imageUrlArray[i]]];
        imageView.frame = CGRectMake((i+1) * topScrollView.frame.size.width, 0,topScrollView.frame.size.width, topScrollView.frame.size.height);
        
        [topScrollView addSubview:imageView];
    }
    
    //将数组中最后一个图片填充到第一页
    UIImageView * forwardImageView = [[UIImageView alloc] init];
    
    [forwardImageView setImage:[UIImage imageWithContentsOfFile:[self.imageUrlArray lastObject]]];
    
    forwardImageView.frame = CGRectMake(0, 0, topScrollView.frame.size.width,topScrollView.frame.size.height);
    [topScrollView addSubview:forwardImageView];
    
    
    //将数组中第一个图片填充到最后一页
    UIImageView * lastImageView = [[UIImageView alloc] init];

    [lastImageView setImage:[UIImage imageWithContentsOfFile:[self.imageUrlArray firstObject]]];
    
    lastImageView.frame = CGRectMake((_advertisementImageCount+1) * topScrollView.frame.size.width, 0, topScrollView.frame.size.width, topScrollView.frame.size.height);
    [topScrollView addSubview:lastImageView];
    
    //将一开始的视图移动到第2页(一共有advertisementImageCount+2页)
    [topScrollView setContentOffset:CGPointMake(topScrollView.frame.size.width, 0)];

    topScrollView.showsHorizontalScrollIndicator = NO;

    topScrollView.pagingEnabled = YES;
    
    //创建分页控制器
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    
    pageControl.center = CGPointMake(topScrollView.frame.size.width / 2, topScrollViewHeight - 10);
    
    pageControl.bounds = CGRectMake(0, 0, 100, 20);
    
    pageControl.currentPage = 0;

    pageControl.numberOfPages = _advertisementImageCount;
    
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:193.0/255 green:197.0/255 blue:215.0/255 alpha:0.3];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    //禁用交互
    pageControl.enabled = NO;
    
    //设置代理
    topScrollView.delegate = self;
    topScrollView.backgroundColor = [UIColor grayColor];
    
    self.topScrollView = topScrollView;
    self.pageControl = pageControl;
    
    [self.pageScrollView addSubview:self.topScrollView];
    [self.pageScrollView addSubview:self.pageControl];
}


//设置中央数据
- (void)setDataCenter {
    
    UIView * dataView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topScrollView.bottom, kMainScreenWidth, dataCenterHeight)];
    dataView.backgroundColor = [UIColor whiteColor];
    CGFloat bigMargin = dataCenterHeight;
    CGFloat smallMargin = 8;
    CGFloat iconViewWidth = 20;
    CGFloat iconViewHeight = iconViewWidth;
    CGFloat dataLabelWidth = (kMainScreenWidth/2 - iconViewWidth - bigMargin - 1);
    
    //用户数据
    UIImageView * userIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomePageUser"]];
    userIconView.frame = CGRectMake(bigMargin,smallMargin , iconViewWidth + smallMargin, iconViewHeight);
    
    UILabel * userDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIconView.right + 10, 0, dataLabelWidth - smallMargin, dataCenterHeight)];
    userDataLabel.font = [UIFont fontWithName:@"Zapf Dingbats" size:16.0];
    userDataLabel.textColor = [UIColor grayColor];
    userDataLabel.textAlignment = NSTextAlignmentLeft;
    userDataLabel.text = @"1318305";
    self.userDataLabel = userDataLabel;
    
    //分割线
    UIView * spView = [[UIView alloc] init];
    spView.center = CGPointMake(kMainScreenWidth/2, dataCenterHeight/2);
    spView.bounds = CGRectMake(0, 0, 1, dataCenterHeight - 7);
    spView.backgroundColor = [UIColor grayColor];
    spView.alpha = 0.15;
    
    //资金数据
    UIImageView * moneyIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomePageMoney"]];
    moneyIconView.frame = CGRectMake(spView.right + bigMargin, smallMargin, iconViewWidth, iconViewHeight);
    
    UILabel * moneyDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyIconView.right + 10, 0, dataLabelWidth, dataCenterHeight)];
    moneyDataLabel.font = [UIFont fontWithName:@"Zapf Dingbats" size:16.0];
    moneyDataLabel.textColor = [UIColor grayColor];
    moneyDataLabel.textAlignment = NSTextAlignmentLeft;
    moneyDataLabel.text = @"2165759063";
    self.moneyDataLabel = moneyDataLabel;
    
    [dataView addSubview:userIconView];
    [dataView addSubview:self.userDataLabel];
    [dataView addSubview:moneyIconView];
    [dataView addSubview:self.moneyDataLabel];
    [dataView addSubview:spView];
    [self.pageScrollView addSubview:dataView];
}


- (void)updateCenterDataWithDict:(NSDictionary *)dict {
    
    self.userDataLabel.text = [NSString stringWithFormat:@"%@",dict[@"userData"]];
    self.moneyDataLabel.text = [NSString stringWithFormat:@"%@",dict[@"moneyData"]];
}

- (void)setCircleView {
    
    CircleView * circleView = [[CircleView alloc] init];
    if (320 == kMainScreenWidth) {
        circleView.frame = CGRectMake(0, 205, kMainScreenWidth, 300);
    }
    else if (375 == kMainScreenWidth) {
        circleView.frame = CGRectMake(0, 205, kMainScreenWidth, 350);
    }
    else {
        circleView.frame = CGRectMake(0, 205, kMainScreenWidth, 418);
    }
    circleView.progressCircleView.centerColor = RGBACOLOR(128, 163, 248, 1.0);
    circleView.progressCircleView.arcBackColor = RGBACOLOR(237, 237, 237, 1.0);
    circleView.progressCircleView.arcUnfinishColor = RGBACOLOR(152, 179, 87, 0.8);
    circleView.progressCircleView.arcFinishColor = RGBACOLOR(128, 163, 248, 1.0);
    circleView.progressCircleView.width = 13.0;
    [circleView.purchaseBtn addTarget:self action:@selector(purchase) forControlEvents:UIControlEventTouchUpInside];
    self.circleView = circleView;
    [self.pageScrollView addSubview:self.circleView];
}



- (void)updateCircleView {
    
    self.circleView.progressCircleView.yearRate = self.productDetail.yearRate;
    self.circleView.deadlineLabel.text = [NSString stringWithFormat:@"限期%d天",self.productDetail.deadline];
    
    CADisplayLink * CA_Progress = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
    [CA_Progress addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.CA_Progress = CA_Progress;
}


#pragma mark - 监听投资按钮
- (void)purchase {
    
    ProductDetailController * productDetailDest = [[ProductDetailController alloc] init];
    [self.navigationController pushViewController:productDetailDest animated:YES];
}


#pragma mark - 球动画
- (void)updateProgress {
    
    self.circleView.progressCircleView.percent += self.productDetail.saledPercent / 60.0;
    if (self.circleView.progressCircleView.percent >= self.productDetail.saledPercent) {
        self.circleView.progressCircleView.percent = self.productDetail.saledPercent;
        [self.CA_Progress invalidate];
        self.CA_Progress = nil;
    }
}


#pragma mark - 辅助功能
//添加下拉刷新
- (void)addPullToRefreshView {
    
    __weak typeof(self) block_SELF = self;
    [self.pageScrollView addPullToRefreshWithActionHandler:^{
        [block_SELF updateModel];
        [block_SELF.pageScrollView.pullToRefreshView stopAnimating];
    }];
    self.pageScrollView.pullToRefreshView.textColor = [UIColor grayColor];
    [self.pageScrollView.pullToRefreshView setTitle:@"下拉可以刷新" forState:SVPullToRefreshStateStopped];
    [self.pageScrollView.pullToRefreshView setTitle:@"正在帮你刷新" forState:SVPullToRefreshStateLoading];
    [self.pageScrollView.pullToRefreshView setTitle:@"松开立即刷新" forState:SVPullToRefreshStateTriggered];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/(_advertisementImageCount+2))/pageWidth)+1;
    page --;  // 默认从第二页开始
    
    [UIView animateWithDuration:0.5 animations:^{
        self.pageControl.currentPage = page;
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth/ (_advertisementImageCount+2)) / pageWidth) + 1;
    
    
    //如果视线在第1页(数组中最后一张图片,在contentsize的第一张),则自动将视线移动到倒数第2页
    if (0 == currentPage) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (_advertisementImageCount), 0)];
    }
    //如果视线在最后1页(数组中第一张图片，在contentsize的最后一张),则自动将实现移动到第2页
    else if (currentPage == (_advertisementImageCount + 1)) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
    }
}

@end
