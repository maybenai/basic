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

    
    UILabel * label = [UILabel lableWith:str frame:CGRectMake(10, 100, size.width, size.height) font:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] alignment:NSTextAlignmentLeft backGroundColor:[UIColor greenColor]];
    
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:label];
    

}




@end
