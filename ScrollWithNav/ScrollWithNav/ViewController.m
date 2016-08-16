//
//  ViewController.m
//  ScrollWithNav
//
//  Created by lisonglin on 16/8/16.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic, weak) UIScrollView * scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initialize];
}

- (void)initialize
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.contentOffset = CGPointZero;
    scrollView.contentSize = CGSizeMake(0, 1.5 * self.view.frame.size.height);
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.delegate = self;
}

#pragma mark  UIScrollViewDelegate--=========================================
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
