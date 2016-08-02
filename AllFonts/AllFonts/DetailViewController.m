//
//  DetailViewController.m
//  AllFonts
//
//  Created by appleLi on 15/7/19.
//  Copyright (c) 2015年 appleLi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    NSString * _str;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _str = self.fontName;
    self.navigationItem.title = [NSString stringWithFormat:@"%@",_str];
    [self initializInterface];
}

- (void)initializInterface
{
    UILabel * label = [[UILabel alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:label];
    label.text = [NSString stringWithFormat:@"%@",_str];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@",_str] size:20];
}

@end
