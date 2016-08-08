//
//  MyViewController.m
//  CollectionViewWaterFall
//
//  Created by lisonglin on 16/8/4.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "MyViewController.h"
#import "MyCollectionViewCell.h"
#import "MyFlowLayout.h"

static NSString * cellID = @"cellID";

@interface MyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong) MyFlowLayout * layout;
@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MyCollectionFlowLayout";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initCollectionView];

}
- (void)initCollectionView
{
    MyFlowLayout * layout = [[MyFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width * 0.6) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    _collectionView = collectionView;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    cell.label.text = [NSString stringWithFormat:@"%zi", indexPath.row];
    cell.label.frame = cell.bounds;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",indexPath.row);
}


@end
