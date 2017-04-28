//
//  ViewController.m
//  LSCityChoose
//
//  Created by lisonglin on 26/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "ViewController.h"
#import "LSCityChooseView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews
{
    self.resultLable.layer.borderColor = [UIColor blackColor].CGColor;
    self.resultLable.layer.cornerRadius = 10;
    self.resultLable.layer.borderWidth = 0.5;
}

- (IBAction)selectBtnClick {
    
    LSCityChooseView * view = [[LSCityChooseView alloc] initWithFrame:self.view.frame];
    view.selectedBlock = ^(NSString * province, NSString * city, NSString * area){
        self.resultLable.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    };
    [self.view addSubview:view];
}



@end
