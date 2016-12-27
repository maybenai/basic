//
//  ViewController.m
//  AppVersionDemo
//
//  Created by lisonglin on 2016/12/20.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "AppVersionUpdate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor blueColor];
    
    btn.frame = CGRectMake(0, 0, 120, 30);
    
    btn.center = self.view.center;
    
    [btn setTitle:@"check" forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(checkVersion) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkVersion
{
    BOOL flag = [AppVersionUpdate checkoutAppVersionWithAppId:@"1174276117"];
    
    if (flag) {
        //发现新版本
    }else{
        //没有发现新版本
    }
}


@end
