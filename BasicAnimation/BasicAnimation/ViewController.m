//
//  ViewController.m
//  BasicAnimation
//
//  Created by lisonglin on 16/9/4.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "CAAnimation+LSLAnimation.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CALayer * layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.frame = CGRectMake(60, 100, 50, 50);
    layer.cornerRadius = 10;
    
    [self.view.layer addSublayer:layer];
    
    
    //旋转
    [self testRotateAnimation:layer];
    
    //移动动画
    [self testMoveAnimation:layer];
    
    //放大缩小
    [self testScaleAnimation:layer];
}

//旋转
- (void)testRotateAnimation:(CALayer *)layer
{
    CABasicAnimation * animation = [CABasicAnimation rotation:2.0 degree:6.0 direction:0 repeatCount:MAXFLOAT];
    
    [layer addAnimation:animation forKey:@"rotate"];
}


//移动
- (void)testMoveAnimation:(CALayer *)layer
{

    CABasicAnimation * animation = [CABasicAnimation moveFrom:layer.position endPoint:CGPointMake(250, layer.position.y) duringTime:1.0 repeat:MAXFLOAT];
    
    [layer addAnimation:animation forKey:@"move"];
}


//放大缩小
- (void)testScaleAnimation:(CALayer *)layer;
{
    CABasicAnimation * scaleAnimation = [CABasicAnimation scaleFrom:1.0 toScale:1.5 duringTimes:1.0 repeat:MAXFLOAT];
    
    [layer addAnimation:scaleAnimation forKey:@"scale"];
}


@end
