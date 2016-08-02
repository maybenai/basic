//
//  TableVC_MulChoose.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "TableVC_MulChoose.h"
#import "MulChooseTable.h"
@interface TableVC_MulChoose ()

@property(nonatomic, strong) MulChooseTable * myTable;

@property(nonatomic, strong) NSMutableArray * dataArr;


@end

@implementation TableVC_MulChoose

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0 ; i < 20; i ++) {
        [_dataArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _myTable = [MulChooseTable shareTableWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) headerTitle:@"全选"];
    _myTable.dataArr = _dataArr;
    //选中内容
    _myTable.block = ^(NSString *chooseContent,NSMutableArray *chooseArr){
        NSLog(@"数据：%@ ; %@",chooseContent,chooseArr);
    };
    [self.view addSubview:_myTable];
}


@end
