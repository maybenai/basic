//
//  SecondViewController.m
//  KVC&KVC&Notification&Delegate
//
//  Created by lisonglin on 16/8/16.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册通知
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initial];
}

- (void)initial
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 120, 30);
    btn.center = self.view.center;
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)dismiss
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:nil  userInfo:@{@"age":@20}];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
