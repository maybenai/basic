//
//  CollectViewVC_Mulchoose.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "CollectViewVC_Mulchoose.h"
#import "MulChooseView.h"
@interface CollectViewVC_Mulchoose ()

@property(nonatomic, strong) MulChooseView * mulChooseView;

@property(nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation CollectViewVC_Mulchoose

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
//    _dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    
    for (int i = 0; i < 20; i ++) {
        [_dataArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
//    self.mulChooseView = [MulChooseView mulChooseViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) headerTitle:@"全选"];
    
    self.mulChooseView = [MulChooseView mulChooseViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    
    self.mulChooseView.dataArr = self.dataArr;
    
    self.mulChooseView.block = ^(NSString * content,NSMutableArray * array){
        NSLog(@"%@,%@",content,array);
    };
    
    [self.view addSubview:self.mulChooseView];

}


@end
