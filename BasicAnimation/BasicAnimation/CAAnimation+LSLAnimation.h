//
//  CAAnimation+LSLAnimation.h
//  BasicAnimation
//
//  Created by lisonglin on 16/9/5.
//  Copyright © 2016年 appleLi. All rights reserved.
//  CAAnimation

#import <QuartzCore/QuartzCore.h>


typedef NS_ENUM(NSUInteger, LAxis)
{
    LAxisX = 0,//x轴
    LAxisY,    //y轴
    LAxisZ     //z轴
};


@interface CAAnimation (LSLAnimation)

/**
 *  放大缩小动画
 *
 *  @param fromScale   原大小
 *  @param toScale     目标大小
 *  @param time        用时时间
 *  @param repeatTimes 重复次数
 *
 *  @return CABasicAnimation
 */
+ (CABasicAnimation *)scaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale duringTimes:(float)time repeat:(float)repeatTimes;


/**
 *  移动动画
 *
 *  @param fromPoint   源点
 *  @param endPoint    终点
 *  @param time        用时时间
 *  @param repeatTimes 重复次数
 *
 *  @return CABasicAnimation
 */
+ (CABasicAnimation *)moveFrom:(CGPoint)fromPoint endPoint:(CGPoint)endPoint duringTime:(float)time repeat:(float)repeatTimes;


/**
 *  旋转动画
 *
 *  @param during 持续时间
 *  @param degree 转的角度
 *  @param axis   旋转方向
 *
 *  @return CABasicAnimation
 */
+ (CABasicAnimation *)rotation:(float)during degree:(float)degree direction:(LAxis)axis repeatCount:(float)repeatCount;









@end
