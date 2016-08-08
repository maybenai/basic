//
//  ViewController.m
//  CollectionViewWaterFall
//
//  Created by lisonglin on 16/8/2.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "FlowLayout.h"

static NSString * cellID = @"cellID";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong) FlowLayout * layout;
/**
 *  用来存放item的尺度
 */
@property(nonatomic, strong) NSMutableArray * dataList;


@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CollectionViewWaterFall";
    
    [self initCollectionView];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * 10) / 3;
    self.dataList = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        CGFloat height = 70 + arc4random() % 100;
        NSValue * value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        [self.dataList addObject:value];
    }

}

- (void)initCollectionView
{
    FlowLayout * layout = [[FlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    _collectionView = collectionView;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    cell.label.text = [NSString stringWithFormat:@"%zi", indexPath.row];
    cell.label.frame = cell.bounds;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self.dataList[indexPath.row] CGSizeValue];
    return size;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    
}


@end
