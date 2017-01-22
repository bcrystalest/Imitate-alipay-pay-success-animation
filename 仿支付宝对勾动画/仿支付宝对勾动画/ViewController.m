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
    self.successView = [[SuccessView alloc]initWithFrame:CGRectMake(0, 50, 30, 100)];
    [self.successView setCheckShapeLayerColor:[UIColor redColor]];
    [self.successView setCheckShapeLayerWidth:1.0];
    [self.successView setCycleShapeLayerColor:[UIColor redColor]];
    [self.successView setCycleShapeLayerWidth:1.0];
    
    [self.view addSubview:self.successView];
    
    [self.successView startAlarming];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 40, 40, 20)];
    
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    
 
}


- (void)done
{
    [self.successView done];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
