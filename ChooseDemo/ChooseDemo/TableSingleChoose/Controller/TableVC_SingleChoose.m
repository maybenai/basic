//
//  TableVC_SingleChoose.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "TableVC_SingleChoose.h"
#import "SingleView.h"
@interface TableVC_SingleChoose ()

@property(nonatomic, strong) SingleView * singleView;

@end

@implementation TableVC_SingleChoose

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    self.singleView = [SingleView shareTableViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    
    self.singleView.dataArr = dataArr;
    
    [self.singleView ReloadData];
    
    //选中内容
    self.singleView.block = ^(NSString * chooseContent, NSIndexPath * indexPath){
        NSLog(@"数据:%@, 第%ld行",chooseContent,indexPath.row);
    };
    [self.view addSubview:self.singleView];
    
}



@end
