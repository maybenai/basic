//
//  ViewController.m
//  Button
//
//  Created by lisonglin on 19/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+TitleImgEdgeInsets.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"jinnang"] forState:UIControlStateNormal];
    [btn setTitle:@"这是按钮" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 120, 100);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn layoutButtonTitleImageEdgeInsetsWithStyle:3 titleImgSpace:10];
}

@end
