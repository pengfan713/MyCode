//
//  DrawView.m
//  testt
//
//  Created by PengFan on 16/6/24.
//  Copyright © 2016年 PengFan. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self ;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, ScreenWidth);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.5);
    //起始点
    CGContextMoveToPoint(context, self.center.x, 0);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, self.center.x, ScreenHeight);
    //连接上面定义的坐标点
    CGContextStrokePath(context);
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
//    path.lineWidth = 1.5;
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineJoinBevel;
//    
//    // 设置填充颜色
//    UIColor *fillColor = [UIColor colorWithWhite:0.5 alpha:0.5];
//    [fillColor set];
//    [path fill];
//    
//    // 设置画笔颜色
//    UIColor *strokeColor = [UIColor clearColor];
//    [strokeColor set];
//    
//    // 根据我们设置的各个点连线
//    [path stroke];
//    
//    
//    
    CGFloat width = ScreenWidth-120;
    CGFloat y = ScreenHeight/2-width/2-64;
    CGRect cropRect = CGRectMake(60, y, width, width);
    
    CGContextRef Context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:Context];
    CGContextClearRect(Context,cropRect);
    
}


@end
