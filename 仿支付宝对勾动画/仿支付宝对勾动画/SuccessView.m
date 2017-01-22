//
//  SuccessView.m
//  仿支付宝对勾动画
//
//  Created by 陈威利 on 17/1/19.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "SuccessView.h"
@interface SuccessView ()<CAAnimationDelegate>
//圆的画布
@property (nonatomic ,strong)CAShapeLayer *cycleShapeLayer;
//勾的画布
@property (nonatomic ,strong)CAShapeLayer *checkShapeLayer;
@property (nonatomic ,strong)UIView *logoView;
@end
@implementation SuccessView
{
    NSTimer *_timer;
}

#define sWidth self.frame.size.width
#define sWidthSmall (sWidth*4/5)
#define sqrtValue sWidthSmall*sqrt(2)*2/3
#define sqrtValue2 sWidth*sqrt(2)*2/3
#define myWeakSelf __weak typeof(self) weakSelf = self;

//sqrt(sWidth*sWidth - (sWidth - 1)*(sWidth - 1))
+ (CAShapeLayer *)cycleShapeLayer {
    static CAShapeLayer *cycleShapeLayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cycleShapeLayer = [[CAShapeLayer alloc] init];
    });
    return cycleShapeLayer;
}

+ (CAShapeLayer *)checkShapeLayer {
    static CAShapeLayer *checkShapeLayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkShapeLayer = [[CAShapeLayer alloc] init];
        checkShapeLayer.lineWidth = 3.5;
    });
    return checkShapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sWidth, sWidth);
        [self circleBezierPath];
    }
    return self;
}

- (void)startAlarming{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];

}

-(void)circleBezierPath
{
    //创建出CAShapeLayer
    self.cycleShapeLayer = [CAShapeLayer layer];
    self.cycleShapeLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
    //    CGAffineTransformMakeRotation(M_PI/2*3);
    self.cycleShapeLayer.frame = CGRectMake(0, 0, sWidth, sWidth);

    
    self.cycleShapeLayer.position = self.center;
    
    
    //设置线条的宽度和颜色
    self.cycleShapeLayer.lineWidth = 3.0f;
    self.cycleShapeLayer.strokeColor = [UIColor blueColor].CGColor;
    self.cycleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    //设置stroke起始点
    self.cycleShapeLayer.strokeStart = 0;
    self.cycleShapeLayer.strokeEnd = 0;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sWidth, sWidth)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.cycleShapeLayer.path = circlePath.CGPath;
    
    //创建出CAShapeLayer
    self.checkShapeLayer = [CAShapeLayer layer];
    //    self.shapeLayer2.transform = CATransform3DMakeRotation(-M_PI_2, 0, 0, 1);
    //    CGAffineTransformMakeRotation(M_PI/2*3);
    self.checkShapeLayer.frame = CGRectMake(0, 0, sWidthSmall, sWidthSmall);
    self.checkShapeLayer.position = self.center;
    self.checkShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.checkShapeLayer.lineWidth = 1.0f;
    self.checkShapeLayer.strokeColor = [UIColor blueColor].CGColor;
    
    //设置stroke起始点
    self.checkShapeLayer.strokeStart = 0;
    self.checkShapeLayer.strokeEnd = 0;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sWidthSmall, sWidthSmall)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.checkShapeLayer.path = circlePath2.CGPath;
    
    //添加并显示
    [self.layer addSublayer:self.cycleShapeLayer];
    [self.layer addSublayer:self.checkShapeLayer];
}


- (void)circleAnimationTypeOne
{
    if (self.cycleShapeLayer.strokeEnd > 1 && self.cycleShapeLayer.strokeStart < 1) {
        self.cycleShapeLayer.strokeStart += 0.1;
        NSLog(@"start = %f",self.cycleShapeLayer.strokeStart);
        
    }else if(self.cycleShapeLayer.strokeStart == 0){
        self.cycleShapeLayer.strokeEnd += 0.1;
        NSLog(@"end = %f",self.cycleShapeLayer.strokeEnd);
    }
    //重置
    if (self.cycleShapeLayer.strokeEnd == 0) {
        self.cycleShapeLayer.strokeStart = 0;
        NSLog(@"start = %f",self.cycleShapeLayer.strokeStart);
    }
    //重置
    if (self.cycleShapeLayer.strokeStart == self.cycleShapeLayer.strokeEnd) {
        self.cycleShapeLayer.strokeEnd = 0;
        NSLog(@"end = %f",self.cycleShapeLayer.strokeEnd);
    }
}

- (void)done
{
    [_timer invalidate];
    self.cycleShapeLayer.strokeStart = 0;
    self.cycleShapeLayer.strokeEnd = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeDone)
                                            userInfo:nil
                                             repeats:YES];
    UIBezierPath* path = [UIBezierPath bezierPath];
    //对拐角和中点处理
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    //对号第一部分直线的起始
    [path moveToPoint:CGPointMake(sWidthSmall/10,sWidthSmall/1.8)];
    CGPoint p1 = CGPointMake(sWidthSmall/2.5,sqrtValue*0.9);
    [path addLineToPoint:p1];
    
    //对号第二部分起始
    CGPoint p2 = CGPointMake(sWidthSmall*11/12,sWidthSmall*4/12);
    [path addLineToPoint:p2];
    
    //线条宽度
    
    self.checkShapeLayer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fillMode= kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    animation.delegate = self;
    [self.checkShapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        myWeakSelf;
        [weakSelf removeFromSuperview];
    });
    
}

//设置线条的宽度和颜色
//self.checkShapeLayer.lineWidth = 1.0f;
//self.checkShapeLayer.strokeColor = [UIColor blueColor].CGColor;
- (void)setCycleShapeLayerColor:(UIColor *)color
{
    self.cycleShapeLayer.strokeColor = color.CGColor;
}

- (void)setCycleShapeLayerWidth:(CGFloat)width
{
    self.cycleShapeLayer.lineWidth = width;
}

- (void)setCycleShapeLayerFillColor:(UIColor *)color
{
    self.cycleShapeLayer.strokeColor = color.CGColor;
}

- (void)setCheckShapeLayerColor:(UIColor *)color
{
    self.checkShapeLayer.strokeColor = color.CGColor;
}

- (void)setCheckShapeLayerFillColor:(UIColor *)color
{
    self.cycleShapeLayer.fillColor = color.CGColor;
}

- (void)setCheckShapeLayerWidth:(CGFloat)width
{
    self.checkShapeLayer.lineWidth = width;
}
//self.cycleShapeLayer.fillColor = [UIColor clearColor].CGColor;



- (void)circleAnimationTypeDone
{
    if(self.cycleShapeLayer.strokeStart == 0){
        if (self.cycleShapeLayer.strokeEnd <= 1) {
            self.cycleShapeLayer.strokeEnd += 0.1;
            NSLog(@"end = %f",self.cycleShapeLayer.strokeEnd);
            if (self.cycleShapeLayer.strokeEnd > 1) {
                [_timer invalidate];
            }
        }
    }
}



@end


