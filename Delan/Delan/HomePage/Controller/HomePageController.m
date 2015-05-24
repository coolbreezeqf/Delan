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

/**
 *  定位宏
 */
#define topScrollViewHeight 170
#define dataCenterHeight 35

@interface HomePageController () <UIScrollViewDelegate> {
    
    NSUInteger _advertisementImageCount;
}


/* HomePage滚动view */
@property (nonatomic, strong) UIScrollView * pageScrollView;

/* 广告view */
@property (nonatomic, strong) NSMutableArray * imageUrlArray;
@property (nonatomic, strong) UIScrollView * topScrollView;
@property (nonatomic, strong) UIPageControl * pageControl;

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
    
//    [self.pageScrollView triggerPullToRefresh];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置不全屏
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    _advertisementImageCount = 5;
    
    //设置标题
    self.navigationItem.title = @"首 页";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIScrollView * pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    pageScrollView.contentSize = CGSizeMake(0, pageScrollView.frame.size.height + 1);
    pageScrollView.backgroundColor = RGBCOLOR(240, 240, 240);
    self.pageScrollView = pageScrollView;
    
    [self setTopScrollView];
    
    [self setDataCenter];
    
    [self addPullToRefreshView];
    
    [self.view addSubview:self.pageScrollView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(200, 300, 100, 100);
    button.tintColor = [UIColor redColor];
    [button setTitle:@"ssss" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor redColor];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(tiao) forControlEvents:UIControlEventTouchUpInside];
    [self.pageScrollView addSubview:button];
    
}

- (void)tiao {
    
    [self.navigationController pushViewController:[[ProductDetailController alloc] init] animated:YES];
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
    
    UILabel * userDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIconView.right, 0, dataLabelWidth - smallMargin, dataCenterHeight)];
    userDataLabel.font = [UIFont fontWithName:@"Bradley Hand" size:16.0];
    userDataLabel.textAlignment = NSTextAlignmentCenter;
    userDataLabel.text = @"1318305";
    
    //分割线
    UIView * spView = [[UIView alloc] init];
    spView.center = CGPointMake(kMainScreenWidth/2, dataCenterHeight/2);
    spView.bounds = CGRectMake(0, 0, 1, dataCenterHeight - 7);
    spView.backgroundColor = [UIColor grayColor];
    spView.alpha = 0.15;
    
    //资金数据
    UIImageView * moneyIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomePageMoney"]];
    moneyIconView.frame = CGRectMake(spView.right + bigMargin, smallMargin, iconViewWidth, iconViewHeight);
    
    UILabel * moneyDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyIconView.right, 0, dataLabelWidth, dataCenterHeight)];
    moneyDataLabel.font = [UIFont fontWithName:@"Bradley Hand" size:16.0];
    moneyDataLabel.textAlignment = NSTextAlignmentCenter;
    moneyDataLabel.text = @"2165759063";
    
    [dataView addSubview:userIconView];
    [dataView addSubview:userDataLabel];
    [dataView addSubview:moneyIconView];
    [dataView addSubview:moneyDataLabel];
    [dataView addSubview:spView];
    [self.pageScrollView addSubview:dataView];
}


#pragma mark - 辅助功能
//添加下拉刷新
- (void)addPullToRefreshView {
    
    __weak typeof(self) block_SELF = self;
    [self.pageScrollView addPullToRefreshWithActionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [block_SELF.pageScrollView.pullToRefreshView stopAnimating];
        });
    }];
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
