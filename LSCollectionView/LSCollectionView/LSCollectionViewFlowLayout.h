//
//  LSCollectionViewFlowLayout.h
//  LSCollectionView
//
//  Created by lisonglin on 2017/4/6.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LSCollectionViewFlowLayout;

@protocol LSCollectionViewFlowLayoutDelegate <NSObject>

- (CGFloat)waterfallLayout:(LSCollectionViewFlowLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;


@end

@interface LSCollectionViewFlowLayout : UICollectionViewLayout
//总列数
@property(nonatomic, assign) NSInteger columnCount;
//列间距
@property(nonatomic, assign) NSInteger columnSpacing;
//行间距
@property(nonatomic, assign) NSInteger rowSpacing;
//section到collectionView的边距
@property (nonatomic, assign) UIEdgeInsets sectionInset;



@property(nonatomic, strong) CGFloat(^itemHeightBlock)(CGFloat itemHeight, NSIndexPath * indexPath);

@property (nonatomic, weak) id<LSCollectionViewFlowLayoutDelegate> delegate;

- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset;


+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount;
- (instancetype)initWithColumnCount:(NSInteger)columnCount;

@end
