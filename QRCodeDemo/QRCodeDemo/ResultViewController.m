//
//  ResultViewController.m
//  QRCodeDemo
//
//  Created by lisonglin on 2017/4/10.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)setString:(NSString *)string
{
    _string = string;
    
    NSLog(@"%@",string);
    
    self.title = string;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
@end
