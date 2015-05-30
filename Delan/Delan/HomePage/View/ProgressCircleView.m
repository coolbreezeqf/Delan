//
//  ProgressCircleView.m
//  微贷宝
//
//  Created by apple on 15/4/14.
//  Copyright (c) 2015年 WDB. All rights reserved.
//

#import "ProgressCircleView.h"

@implementation ProgressCircleView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _percent = 0;
        
        _width = 0;
        
    }
    
    return self;
    
}


- (void)setPercent:(float)percent{
    
    _percent = percent;
    
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect{
    
    [self addArcBackColor];
    
    [self drawArc];
    
    [self addCenterBack];
    
    [self addCenterLabel];
    
}


//设置未填充的进度条背景色
- (void)addArcBackColor{
    
    CGColorRef color = (_arcBackColor == nil) ? [UIColor lightGrayColor].CGColor : _arcBackColor.CGColor;
    
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGSize viewSize = self.bounds.size;
    
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    
    CGFloat radius = viewSize.width / 2;
    
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, center.x, center.y);
    
    CGContextAddArc(contextRef, center.x, center.y, radius, 0,2*M_PI, 0);
    
    CGContextSetFillColorWithColor(contextRef, color);
    
    CGContextFillPath(contextRef);
    
}


//填充已完成的进度及颜色
- (void)drawArc{
    
    if (_percent == 0 || _percent > 1) {
        
        return;
        
    }
    
    if (_percent == 1) {
        
        CGColorRef color = (_arcFinishColor == nil) ? [UIColor greenColor].CGColor : _arcFinishColor.CGColor;
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGSize viewSize = self.bounds.size;
        
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        
        
        CGFloat radius = viewSize.width / 2;
        
        CGContextBeginPath(contextRef);
        
        CGContextMoveToPoint(contextRef, center.x, center.y);
        
        CGContextAddArc(contextRef, center.x, center.y, radius, 0,2*M_PI, 0);
        
        CGContextSetFillColorWithColor(contextRef, color);
        
        CGContextFillPath(contextRef);
        
    }else{
        
        float endAngle = -M_PI_2 + 2*M_PI*_percent;
        
        CGColorRef color = (_arcUnfinishColor == nil) ? [UIColor blueColor].CGColor : _arcUnfinishColor.CGColor;
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGSize viewSize = self.bounds.size;
        
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        
        
        CGFloat radius = viewSize.width / 2;
        
        CGContextBeginPath(contextRef);
        
        CGContextMoveToPoint(contextRef, center.x, center.y);
        
        CGContextAddArc(contextRef, center.x, center.y, radius, - M_PI_2,endAngle, 0);
        
        CGContextSetFillColorWithColor(contextRef, color);
        
        CGContextFillPath(contextRef);
        
    }
    
}


-(void)addCenterBack{
    
    float width = (_width == 0) ? 5 : _width;
    
    CGColorRef color = (_centerColor == nil) ? [UIColor whiteColor].CGColor : _centerColor.CGColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGSize viewSize = self.bounds.size;
    
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    
    CGFloat radius = viewSize.width / 2 - width;
    
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, center.x, center.y);
    
    CGContextAddArc(contextRef, center.x, center.y, radius, 0,2*M_PI, 0);
    
    CGContextSetFillColorWithColor(contextRef, color);
    
    CGContextFillPath(contextRef);
    
}


- (void)addCenterLabel{
    
    NSString *percent = @"";
    
    
    float fontSize = 14;
    
    UIColor *arcColor = [UIColor blueColor];
    
    
    fontSize = 30.0;
    
    arcColor = [UIColor whiteColor];
    
    percent = [NSString stringWithFormat:@"%0.1f%%",self.yearRate * 100];
    
    CGSize viewSize = self.bounds.size;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName ,arcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize) withAttributes:attributes];
    
}


@end
