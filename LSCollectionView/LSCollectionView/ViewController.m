//
//  ViewController.m
//  LSCollectionView
//
//  Created by lisonglin on 2017/4/6.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "ViewController.h"
#import "LSCollectionViewCell.h"
#import "LSCollectionViewFlowLayout.h"
#import "LSImage.h"

#define collectionCellID  @"COLLECTIONCELLID"

@interface ViewController ()<UICollectionViewDataSource,LSCollectionViewFlowLayoutDelegate>

@property(nonatomic, weak) UICollectionView * collectionView;
@property(nonatomic, strong) NSMutableArray<LSImage *> * images;

@property(nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController

#pragma mark -- 懒加载
- (NSMutableArray<LSImage *> *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray * imageDics = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary * dic in imageDics) {
            LSImage * image = [LSImage imageWithImageDic:dic];
            [_images addObject:image];
        }
    }
    return _images;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 40; i ++) {
            [_dataSource addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _dataSource;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [self initializeUserInterface];
}



- (void)initializeUserInterface
{
    LSCollectionViewFlowLayout * layout = [LSCollectionViewFlowLayout waterFallLayoutWithColumnCount:3];
    layout.delegate = self;
    [layout setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
        
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    
    self.collectionView = collectionView;
    
    [self.view addSubview:collectionView];
    
//    [self.collectionView registerClass:[LSCollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
    
    UINib * nib = [UINib nibWithNibName:@"LSCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:collectionCellID];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    cell.imageUrl = self.images[indexPath.item].imageUrl;
    return cell;
}


- (CGFloat)waterfallLayout:(LSCollectionViewFlowLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    
    LSImage * image = self.images[indexPath.item];
    
    return image.imageH / image.imageW * itemWidth;
    
    
//    return (arc4random_uniform(100) + 100);
    
}



@end
