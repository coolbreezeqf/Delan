//
//  PercentCircleView.m
//  Delan
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 wdb. All rights reserved.
//

#import "PercentCircleView.h"

#define typePercentViewHeight 80

@implementation PercentCircleView

- (void)setPercent:(CGFloat)percent {
    
    _percent = percent;
    
    //通知更新数据
    [self changePercentLabel];
    
    //通知重绘
    [self setNeedsDisplay];
}


- (void)changePercentLabel {
    
    UILabel * percentLabel = [self.subviews lastObject];
    NSString * percentText = [NSString stringWithFormat:@"%.1lf%%",_percent * 100];
    percentLabel.text = percentText;
}


- (void)drawRect:(CGRect)rect {
    
    UILabel * percentLabel = [self.subviews lastObject];
    UIImage * image;

    if (1 == _type) {
        if (1 == _isVip) {
            image = [UIImage imageNamed:@"ProductDetailCircle-vip"];
        }
        else {
            image = [UIImage imageNamed:@"ProductDetailCircle-normal"];
        }
    }
    else if (2 == _type) {
        image = [UIImage imageNamed:@"ProductDetailCircle-repay"];
        percentLabel.hidden = YES;
    }
    else {
        image = [UIImage imageNamed:@"ProductDetailCircle-full"];
        percentLabel.hidden = YES;
    }
    
    [image drawInRect:CGRectMake(0, 0, typePercentViewHeight, typePercentViewHeight)];
    
    
    //如果是vip或者普通产品
    if (1 == _type) {
        
        //获取上下文
        CGContextRef ctf = UIGraphicsGetCurrentContext();
        
        //指定一个可绘边界
        CGContextAddEllipseInRect(ctf, CGRectMake(2, 2, typePercentViewHeight-4, typePercentViewHeight-4));
        CGContextClip(ctf);
        
        CGContextMoveToPoint(ctf, typePercentViewHeight / 2, typePercentViewHeight-2);
        
        CGFloat finalY = (typePercentViewHeight-4) * (1.0 - _percent);
        
        CGContextAddLineToPoint(ctf, typePercentViewHeight / 2, finalY);
        
        //设置画笔颜色
        if (1 == _isVip) {
            [RGBCOLOR(235, 115, 33) set];
        }
        else {
            [RGBCOLOR(68, 90, 173) set];
        }
        
        //画笔宽度
        CGContextSetLineWidth(ctf, typePercentViewHeight);
        //线头形状
        CGContextSetLineCap(ctf, kCGLineCapButt);
        
        CGContextStrokePath(ctf);
    }
}


@end
