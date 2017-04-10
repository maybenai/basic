//
//  ViewController.m
//  AutoLabel
//
//  Created by lisonglin on 2016/12/27.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+LSLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    NSString * str = @"这是labelOne的高度自适应这是labelOne的高度自适应这是labelOne的高度自适应这是labelOne的高度自适应";

    CGSize size = [UILabel stringWithAutoLabel:str size:CGSizeMake(200, MAXFLOAT) options:AutoAdaptiveVertical font:[UIFont systemFontOfSize:14]];

    
    UILabel * label = [UILabel lableWith:str frame:CGRectMake(10, 100, size.width, size.height) font:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] alignment:NSTextAlignmentLeft backGroundColor:[UIColor grayColor]];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    
    NSString * str1 = @"这是labelOne的宽度自适应这是labelOne的宽度自适应";
    CGSize sizeW = [UILabel stringWithAutoLabel:str1 size:CGSizeMake(self.view.frame.size.width, 30) options:AutoAdaptiveHorizontal font:[UIFont systemFontOfSize:14]];
    
    UILabel * labelW = [UILabel lableWith:str1 frame:CGRectMake(10, 300, self.view.frame.size.width - 20, sizeW.height) font:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] alignment:NSTextAlignmentLeft backGroundColor:[UIColor grayColor]];
    labelW.numberOfLines = 0;
    [self.view addSubview:labelW];
}




@end
