//
//  NextViewController.m
//  Block
//
//  Created by lisonglin on 16/8/18.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@property(nonatomic, strong) NSString * text;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 120, 30);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)dismiss
{
    
#warning 如果用self这里会导致block与NextViewController循环引用

    //在MRC下用__block
    //在ARC下用__weak
    
    __weak typeof(self) weakSelf = self;

    self.text = @"123";
    if (self.myBlock) {
        weakSelf.myBlock(weakSelf.text);
        
    }
    

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
