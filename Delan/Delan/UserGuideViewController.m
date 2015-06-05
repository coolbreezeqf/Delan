//
//  UserGuideViewController.m
//  Delan
//
//  Created by apple on 15/5/31.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "UserGuideViewController.h"
#import "RootTabBarController.h"

#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width

#define guideImageCount 4

@interface UserGuideViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray * imageViewArray;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIButton * coverBtn;

@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) UIButton * enterBtn;

@end

@implementation UserGuideViewController

#pragma mark - 懒加载
- (NSMutableArray *)imageViewArray {
    
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self imageViewCreate];
    
    [self coverBtnCreate];
    
    [self scrollViewCreate];
    
    [self guideImageCreate];
    
    [self pageControlCreate];
    
    [self enterBtnCreate];
    
    self.scrollView.delegate = self;
}



//创建UIImageView
- (void)imageViewCreate {
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DLGuideBg"]];
    
    imageView.frame = self.view.frame;
    
    [self.view addSubview:imageView];
}


//创建UIScrollView
- (void)scrollViewCreate {
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(guideImageCount * self.view.frame.size.width, self.view.frame.size.height);
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.bounces = YES;
    
    self.scrollView = scrollView;
    
    [self.view addSubview:self.scrollView];
}



- (void)guideImageCreate {
    
    for (int i = 0; i < guideImageCount; i ++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"DLGuide%d",i + 1]]];
        
        imageView.frame = CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self.scrollView addSubview:imageView];
    }
}


//创建可变蒙层按钮
- (void)coverBtnCreate {
    
    UIButton * coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    coverBtn.frame = self.view.frame;
    
    coverBtn.backgroundColor = RGBCOLOR(184, 230, 254);
    
    coverBtn.alpha = 0.0;
    
    self.coverBtn = coverBtn;
    
    [self.view addSubview:self.coverBtn];
}



//创建enterBtn
- (void)enterBtnCreate {
    
    UIButton * enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    enterBtn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - (135 * kMainScreenHeight / 667));
    
    enterBtn.bounds = CGRectMake(0, 0, 200, 40);
    
    [enterBtn setTitle:@"立 即 体 验" forState:UIControlStateNormal];
    
    enterBtn.layer.borderWidth = 1.0;
    
    enterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    enterBtn.alpha = 0.0;
    
    [enterBtn addTarget:self action:@selector(enterMain:) forControlEvents:UIControlEventTouchUpInside];
    
    self.enterBtn = enterBtn;
    
    [self.view addSubview:self.enterBtn];
}



//创建分页控制器
- (void)pageControlCreate {
    
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    
    pageControl.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 15);
    
    pageControl.bounds = CGRectMake(0, 0, 200, 44);
    
    pageControl.currentPageIndicatorTintColor = RGBCOLOR(86, 112, 187);
    
    pageControl.pageIndicatorTintColor = RGBCOLOR(180, 180, 180);
    
    pageControl.numberOfPages = guideImageCount;
    
    pageControl.currentPage = 0;
    
    self.pageControl = pageControl;
    
    [self.view addSubview:self.pageControl];
}



#pragma mark - UIScrollViewDelegate协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat touchX = scrollView.contentOffset.x;
    
    int page = touchX / self.view.frame.size.width;
    
    
    //设置coverBtn透明度
    
    //1.如果超出左侧的弹簧范围
    if (touchX <= 0.0) {
        CGFloat alpha = - (touchX / self.view.frame.size.width);
        
        [self.coverBtn setAlpha:alpha];
    }
    
    //2.如果在弹簧范围内
    if (touchX > 0.0 && touchX < (guideImageCount-1) * self.view.frame.size.width) {
        
        //2.1如果小于等于中点的x
        if ((touchX - page * self.view.frame.size.width) <= self.view.frame.size.width / 2) {
            //设置透明度
            CGFloat alpha = ((touchX - page * self.view.frame.size.width) / self.view.frame.size.width) * 0.8;
            
            [self.coverBtn setAlpha:alpha];
        }
        //2.2如果大于中点的x
        else {
            //设置透明度
            CGFloat alpha = ((((page+1) * self.view.frame.size.width) - touchX) / self.view.frame.size.width) * 0.8;
            
            [self.coverBtn setAlpha:alpha];
        }
        
    }
    
    //3.如果超出了右侧的弹簧范围
    if (touchX >= (guideImageCount-1) * self.view.frame.size.width) {
        CGFloat alpha = (touchX - page * self.view.frame.size.width) / self.view.frame.size.width;
        
        [self.coverBtn setAlpha:alpha];
    }
    
    
    //设置分页控制器的当前页
    [UIView animateWithDuration:0.4 animations:^{
        
        int currentPage = (touchX + self.view.frame.size.width / 2) / self.view.frame.size.width;
        
        self.pageControl.currentPage = currentPage;
    }];
    
    
    //最后页淡出文字
    if (page >= guideImageCount-1) {
        
        //隐藏分页控制器
        self.pageControl.alpha = 0.0;
        
        [UIView animateWithDuration:1.0 animations:^{
            self.enterBtn.alpha = 1.0;
        }];
        
    }
    else {
        self.pageControl.alpha = 1.0;
        self.enterBtn.alpha = 0.0;
    }
}



//监听enterBtn的点击事件
- (void)enterMain:(UIButton *)btn {
    
    RootTabBarController * tabBarController = [[RootTabBarController alloc] init];
    
    //设置跳转模态视图的动画样式
    tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:tabBarController animated:YES completion:nil];
    
}

@end
