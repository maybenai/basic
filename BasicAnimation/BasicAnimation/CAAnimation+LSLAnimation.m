//
//  CAAnimation+LSLAnimation.m
//  BasicAnimation
//
//  Created by lisonglin on 16/9/5.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "CAAnimation+LSLAnimation.h"
#import <UIKit/UIKit.h>

@implementation CAAnimation (LSLAnimation)

+ (CABasicAnimation *)scaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale duringTimes:(float)time repeat:(float)repeatTimes
{
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    //起始状态
    scaleAnimation.fromValue = [NSNumber numberWithFloat:fromScale];
    
    //终了状态
    scaleAnimation.toValue = [NSNumber numberWithFloat:toScale];
    
    //是否执行逆动画
    scaleAnimation.autoreverses = YES;
    
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    scaleAnimation.removedOnCompletion = NO;
    
    scaleAnimation.repeatCount = repeatTimes;
    
    scaleAnimation.duration = time;
    
    return scaleAnimation;
}


+ (CABasicAnimation *)moveFrom:(CGPoint)fromPoint endPoint:(CGPoint)endPoint duringTime:(float)time repeat:(float)repeatTimes
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //动画选项的设定
    animation.duration = 2.5;
    animation.repeatCount = repeatTimes;
    
    //设置起始帧和终了帧
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:endPoint];
    animation.autoreverses = YES;
    
    return animation;
}

+ (CABasicAnimation *)rotation:(float)during degree:(float)degree direction:(LAxis)axis repeatCount:(float)repeatCount
{
    ;
    NSArray *axisArr = @[@"transform.rotation.x", @"transform.rotation.y", @"transform.rotation.z"];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:axisArr[axis]];
    
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    
    animation.toValue = [NSNumber numberWithFloat:degree * M_PI];
    
    animation.autoreverses = YES;
    
    animation.repeatCount = repeatCount;
    
    animation.duration = during;
    
    
    return animation;

}
@end
