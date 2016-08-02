//
//  ViewController.m
//  LockView
//
//  Created by lisonglin on 16/1/27.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
@interface ViewController ()<LockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    //初始化一个view，用来显示
    LockView * lockView = [[LockView alloc] init];
    lockView.backgroundColor = [UIColor clearColor];
    CGFloat screenW = self.view.frame.size.width;
    lockView.frame = CGRectMake(0, 0, screenW, screenW);
    lockView.center = self.view.center;
    [self.view addSubview:lockView];
    lockView.delegate = self;
    
    
}

- (void)lockView:(LockView *)lockView didSelectedPassWord:(NSString *)passWord
{
    NSLog(@"%@",passWord);
}


@end
