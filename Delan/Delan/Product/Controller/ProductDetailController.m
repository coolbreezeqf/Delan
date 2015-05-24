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

@interface ProductDetailController () {
    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.navigationItem.title = @"项目详情";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGBACOLOR(68, 90, 173, 0.4);
    
    [self setTableViewHeader];
    
    [self updateModel];
}


- (void)updateModel {
    
    self.productModel.saledPercent = 0.54;
    self.productModel.type = 0;
    
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


@end
