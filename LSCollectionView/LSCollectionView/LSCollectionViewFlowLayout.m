//
//  LSCollectionViewFlowLayout.m
//  LSCollectionView
//
//  Created by lisonglin on 2017/4/6.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "LSCollectionViewFlowLayout.h"

@interface LSCollectionViewFlowLayout()
//保存每一列最大y值的数组
@property(nonatomic, strong) NSMutableDictionary * maxYDic;
//保存每一个item的attributes的数组
@property(nonatomic, strong) NSMutableArray * attributesArray;

@end


@implementation LSCollectionViewFlowLayout


- (NSMutableDictionary *)maxYDic
{
    if (!_maxYDic) {
        _maxYDic = [NSMutableDictionary dictionary];
    }
    return _maxYDic;
}

- (NSMutableArray *)attributesArray
{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.columnCount = 2;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount {
    if (self = [super init]) {
        self.columnCount = columnCount;
    }
    return self;
}

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount {
    return [[self alloc] initWithColumnCount:columnCount];
}

#pragma mark- 相关设置方法

- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset
{
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSepacing;
    self.sectionInset = sectionInset;
}


- (void)prepareLayout
{
    [super prepareLayout];
    //初始化字典。有几列就有几个键值对 value为列的y值
    for (int i = 0; i < self.columnCount; i ++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    
    //根据collectionView获取总共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    [self.attributesArray removeAllObjects];
    
    //为每一个item创建一个attributes并存入数组
    for (int i = 0; i < itemCount; i ++) {
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attributesArray addObject:attributes];
    }
    
}

//计算collectionView的contentSize
- (CGSize)collectionViewContentSize
{
    //假设第0列是最长的那列
    __block NSNumber * maxIndex = @0;
    
    //遍历字典，找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

//用来设置每个item的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    //self.sectionInset.left: 左边距 self.sectionInset.right: 右边距
    //(self.columnCount - 1 ) * _columnSpacing : 一行中所有的列边距
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    
    CGFloat itemHeight = 0;
    if (self.itemHeightBlock){
        itemHeight = self.itemHeightBlock(itemWidth,indexPath);
    }else{
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)]) {
            itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
        }
    }
    
    //接下来计算item的坐标
    __block NSNumber * minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[minIndex] floatValue] > [obj floatValue]) {
            minIndex = key;
        }
    }];
    
    //根据最短列的列数计算item的x值
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
    
    //item的y值 = 最短列的最大y值+ 行间距
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
    
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}






@end
