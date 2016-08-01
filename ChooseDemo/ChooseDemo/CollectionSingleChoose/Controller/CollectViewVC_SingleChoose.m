//
//  CollectViewVC_SingleChoose.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "CollectViewVC_SingleChoose.h"
#import "SingleChooseCollectionView.h"

@interface CollectViewVC_SingleChoose ()

@property(nonatomic, strong) SingleChooseCollectionView * myCollectionView;

@property(nonatomic, strong) NSMutableArray * dataArr;


@end

@implementation CollectViewVC_SingleChoose

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    _dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _myCollectionView = [SingleChooseCollectionView shareCollectionViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    _myCollectionView.dataArr = self.dataArr;
    //选中内容
    _myCollectionView.block = ^(NSString *chooseContent,NSIndexPath *indexPath){
        NSLog(@"数据：%@ ；第%ld行",chooseContent,indexPath.row);
    };
    [self.view addSubview:_myCollectionView];
}



@end
