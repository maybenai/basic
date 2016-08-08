//
//  MyFlowLayout.m
//  CollectionViewWaterFall
//
//  Created by lisonglin on 16/8/4.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
}

/**
 *  当collectionView的显示范围发生改变时，是否需要重新刷新布局
 *
 *  刷新布局就会重新调用
 *  1.prepareLayout
 *  2.layoutAttributesForElementsInRect
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  这个方法返回的是存放rect范围内所有元素的布局属性
 *
 *  这个方法的返回值决定了rect范围内所有元素的排布(frame)
 *
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
   //让父类布局好样式
    NSArray * arra = [super layoutAttributesForElementsInRect:rect];
    
    //计算出collectionView的中心位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    NSLog(@"%f",centerX);
    
    for (UICollectionViewLayoutAttributes * attributes in arra) {
        //cell的中心点距离
        CGFloat delta = ABS(attributes.center.x - centerX);
        
        //设置缩放比例
        CGFloat scale = 1.1 - delta / self.collectionView.frame.size.width;
        
        //设置cell滚动的时候缩放的比例
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return arra;
}

#pragma mark  collectionView滚动时调用的方法--=========================================
//这个方法的返回值决定了collectionView停止滚动时的偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    //获得super已经计算好的布局的属性
    NSArray * arr = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionView最中心点的值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in arr) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}


@end
