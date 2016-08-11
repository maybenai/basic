//
//  LSLView.h
//  LSLScrollView
//
//  Created by lisonglin on 16/8/11.
//  Copyright © 2016年 appleLi. All rights reserved.
//  scrollView封装

#import <UIKit/UIKit.h>

@interface LSLView :UIView

/**
 *  用来存放图片的名字
 */
@property(nonatomic, strong) NSMutableArray * imageNames;

/**
 *  定时器开启
 */
- (void)timerOpen;
/**
 *  pageControl开启
 */
- (void)pageControlOpen;

@end
