//
//  SingleChooseCollectionView.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "SingleChooseCollectionView.h"
#import "CollectionViewChooseCell.h"

#define ItemHeight 70
#define HeaderHeight 50
static NSString *CellId = @"CellId";
static NSString *HeaderId = @"HeaderId";

@implementation SingleChooseCollectionView

+ (instancetype)shareCollectionViewWithFrame:(CGRect)frame
{
    SingleChooseCollectionView * collect = [[SingleChooseCollectionView alloc] initWithFrame:frame];
    return collect;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatCollectionView];
    }
    return self;
}



- (void)creatCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //列距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];

    self.myCollectionView.backgroundColor = ColorRGB(0xf7f7f7);
    [self.myCollectionView registerClass:[CollectionViewChooseCell class] forCellWithReuseIdentifier:CellId];
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    self.myCollectionView.scrollEnabled = YES;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self addSubview:self.myCollectionView];
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3,ItemHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * reuseIdentify = CellId;
    CollectionViewChooseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.titleLab.text = self.dataArr[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentSelectIndexPath != nil && _currentSelectIndexPath != indexPath) {
        CollectionViewChooseCell * cell = (CollectionViewChooseCell *)[collectionView cellForItemAtIndexPath:_currentSelectIndexPath];
        [cell UpdateCellWithState:NO];
    }
    
    CollectionViewChooseCell * cell = (CollectionViewChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    _currentSelectIndexPath = indexPath;
    
    _block(cell.titleLab.text,indexPath);
}

-(void)ReloadData{
    [self.myCollectionView reloadData];
}


@end
