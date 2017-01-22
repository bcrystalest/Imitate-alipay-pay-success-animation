//
//  SuccessView.h
//  仿支付宝对勾动画
//
//  Created by 陈威利 on 17/1/19.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessView : UIView
- (void)startAlarming;
//结束时调用
- (void)done;

- (void)failure;

- (void)setCycleShapeLayerColor:(UIColor *)color;

- (void)setCycleShapeLayerWidth:(CGFloat)width;

- (void)setCycleShapeLayerFillColor:(UIColor *)color;

- (void)setCheckShapeLayerColor:(UIColor *)color;

- (void)setCheckShapeLayerWidth:(CGFloat)width;

- (void)setCheckShapeLayerFillColor:(UIColor *)color;
@end
