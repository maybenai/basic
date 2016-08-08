//
//  FlowLayout.m
//  CollectionViewWaterFall
//
//  Created by lisonglin on 16/8/2.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "FlowLayout.h"

/**
 *  表示3列
 */
static NSUInteger const kColCount = 3;

@interface FlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *attributes;
/**
 *  用来存放相邻的3个item的高度
 */
@property (nonatomic, strong) NSMutableArray *colArr;
/**
 *  约束
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;

@end

@implementation FlowLayout

#pragma mark  准备布局--=========================================

- (void)prepareLayout
{

    [super prepareLayout];
    
    //获取总个数
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    if (!itemCount) {
        return;
    }
    
    //初始化
    self.attributes = [NSMutableDictionary dictionary];
    self.colArr = [NSMutableArray arrayWithCapacity:kColCount];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    CGFloat top = 0;
    for (int i = 0; i < kColCount; i ++) {
        [self.colArr addObject:[NSNumber numberWithFloat:top]];
    }
    
    //遍历所有item,重新布局
    for (int i = 0; i < itemCount; i ++) {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
}

#pragma mark  重新布局--=========================================
- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取collectionView的edgeInsets
    UIEdgeInsets edgeInsets = self.sectionInset;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    }
    self.edgeInsets = edgeInsets;
    
    //获取collectionView的itemSize
    CGSize itemSize = self.itemSize;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    //遍历相邻3个高度获得最小高度
    NSUInteger col = 0;
    CGFloat shortHeight = [[self.colArr firstObject] floatValue];
    
    
    for (NSUInteger i = 0; i < self.colArr.count; i ++) {
        CGFloat height = [self.colArr[i] floatValue];
        if (height < shortHeight) {
            shortHeight = height;
            col = i;
        }
    }
    
    //得到最小高度的当前Y坐标起始高度
    float top = [self.colArr[col] floatValue];
    //设置当前cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width),top + edgeInsets.top , itemSize.width, itemSize.height);
    
    [self.attributes setObject:indexPath forKey:NSStringFromCGRect(frame)];
    
    //更新colArr数组中的高度
    [self.colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
    
}



#pragma mark  系统方法--=========================================
//获取当前可视界面显示的UICollectionViewLayoutAttributes数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //把能显示在当前可视界面的所有对象加入到indexPaths中
    NSMutableArray * indexPaths = [NSMutableArray array];
    for (NSString * recStr in self.attributes) {
        CGRect cellRect = CGRectFromString(recStr);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath * indexPath = self.attributes[recStr];
            [indexPaths addObject:indexPath];
        }

    }
    
    //返回更新对应的UICollectionViewLayoutAttributes数组
    NSMutableArray * attributes = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath * indexPath in indexPaths) {
        UICollectionViewLayoutAttributes * attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
    }
    return attributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    for (NSString * frame in self.attributes) {
        if (self.attributes[frame] == indexPath) {
            attributes.frame = CGRectFromString(frame);
        }
    }
    return attributes;
    
}

#pragma mark  重新设置contentSize--=========================================
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.frame.size;
    CGFloat maxHeight = [[self.colArr firstObject] floatValue];
    
    //查找最高的列的高度
    for (NSUInteger i = 0; i < self.colArr.count; i ++) {
        CGFloat colHeight = [self.colArr[i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    
    size.height = maxHeight + self.edgeInsets.bottom;
    
    return size;
}




@end

