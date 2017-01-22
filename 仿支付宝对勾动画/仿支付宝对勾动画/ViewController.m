//
//  ViewController.m
//  仿支付宝对勾动画
//
//  Created by 陈威利 on 17/1/19.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "ViewController.h"
#import "SuccessView.h"
@interface ViewController ()
@property (nonatomic ,strong)CAShapeLayer *shapeLayer;
@property (nonatomic ,strong)CAShapeLayer *shapeLayer2;
@property (nonatomic ,strong)SuccessView *successView;
@end

@implementation ViewController
{
    NSTimer *_timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.successView = [[SuccessView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.successView setCheckShapeLayerColor:[UIColor redColor]];
    [self.successView setCheckShapeLayerWidth:3.0];
    [self.successView setCycleShapeLayerColor:[UIColor redColor]];
    [self.successView setCycleShapeLayerWidth:3.0];
    
    [self.view addSubview:self.successView];
    //开始旋转
    [self.successView startAlarming];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 40, 40, 20)];
    
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(300, 40, 40, 20)];
    
    btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(failure) forControlEvents:UIControlEventTouchDown];
}



- (void)done
{
    //结束并成功
    [self.successView done];
}

- (void)failure
{
    //结束并失败
    [self.successView failure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
