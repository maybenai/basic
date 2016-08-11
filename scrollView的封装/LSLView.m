//
//  LSLView.m
//  LSLScrollView
//
//  Created by lisonglin on 16/8/11.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "LSLView.h"

@interface LSLView ()<UIScrollViewDelegate>
/**
 *  scrollView
 */
@property(nonatomic, strong) UIScrollView * scrollView;
/**
 *  添加imageView
 */
@property(nonatomic, strong) NSMutableArray * imageViews;
/**
 *  定时器
 */
@property(nonatomic, strong) NSTimer * timer;
/**
 *  pageControll
 */
@property(nonatomic, strong) UIPageControl * pageControl;

@end


@implementation LSLView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加一个scrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.userInteractionEnabled = YES;
        CGSize size = self.frame.size;
        self.scrollView.contentOffset = CGPointMake(size.width, 0);
        self.scrollView.contentSize = CGSizeMake(3 * size.width, size.height);
        self.scrollView.backgroundColor = [UIColor grayColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        if ([self.scrollView.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [self.scrollView.delegate scrollViewDidScroll:self.scrollView];
        }
        
        self.imageViews = [NSMutableArray array];
        for (int i = 0; i < 3; i ++) {
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
            [self.scrollView addSubview:imageView];
            [self.imageViews addObject:imageView];
        }

        
    }
    return self;
}

#pragma mark --打开定时器
- (void)timerOpen
{
    //初始化一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeToScroll) userInfo:nil repeats:YES];
    [self.timer fireDate];
}

- (void)pageControlOpen
{
    //初始化pageControl
    UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30)];
    pageControl.center = CGPointMake(self.center.x, CGRectGetMaxY(self.scrollView.frame) - 20);
    self.pageControl = pageControl;
    [self addSubview:pageControl];

    

}

#pragma mark  设置图片--=========================================
- (void)setImageNames:(NSMutableArray *)imageNames
{
    _imageNames = imageNames;

    self.pageControl.numberOfPages = self.imageNames.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];

    [self setImageToImage];
        
}

//设置图片
- (void)setImageToImage
{
    int i = 0;
    for (UIImageView * image in self.imageViews) {
        [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageNames[i]]]];
        i ++;
    }
    
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x <= 0) {//滑到最左边,再滑显示最后一张,取出最后一张，然后移除最后一张，再把最后一张插入到首位置
        NSString * lastImage = self.imageNames.lastObject;
        [self.imageNames removeObject:self.imageNames.lastObject];
        [self.imageNames insertObject:lastImage atIndex:0];
        self.pageControl.currentPage = (self.pageControl.currentPage == 0) ? (self.imageNames.count - 1) : --self.pageControl.currentPage;
    }else if(self.scrollView.contentOffset.x >= CGRectGetWidth(self.scrollView.bounds) * 2){//滑到最右边，再滑就显示第一张
        NSString * firstImage = self.imageNames.firstObject;
        [self.imageNames removeObject:self.imageNames.firstObject];
        [self.imageNames addObject:firstImage];
        self.pageControl.currentPage = (self.pageControl.currentPage == self.imageNames.count - 1) ? 0 : ++self.pageControl.currentPage;
        
    }else{
        return;
    }
    [self setImageToImage];
    
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0);

}

//
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}

//计时器实现方法
- (void)timeToScroll
{
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame) * 2, 0) animated:YES];
}



@end
