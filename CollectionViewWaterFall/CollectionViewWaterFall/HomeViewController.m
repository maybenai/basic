//
//  HomeViewController.m
//  CollectionViewWaterFall
//
//  Created by lisonglin on 16/8/4.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "MyViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat x = self.view.center.x;
    CGFloat y = self.view.center.y - 30;
    UIButton * btn1 = [self setUpOneBtnWithCenter:CGPointMake(x, y) Title:@"瀑布流"];
    btn1.tag = 10;
    [self.view addSubview:btn1];

    CGFloat y2 = self.view.center.y + 30;
    UIButton * btn2 = [self setUpOneBtnWithCenter:CGPointMake(x, y2) Title:@"流水布局"];
    btn2.tag = 11;
    [self.view addSubview:btn2];

}

#pragma mark  initial oneBtn--=========================================
- (UIButton *)setUpOneBtnWithCenter:(CGPoint)center  Title:(NSString *)title
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 40);
    btn.center = center;
    btn.backgroundColor = [UIColor grayColor];
    btn.layer.cornerRadius = 10;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClick:(UIButton *)sender
{
    if (sender.tag == 10) {//瀑布流布局
        ViewController * viewVC = [[ViewController alloc] init];
        [self.navigationController pushViewController:viewVC animated:YES];
    }else{
        MyViewController * myVC = [[MyViewController alloc] init];
        [self.navigationController pushViewController:myVC animated:YES];
    }
}

@end
