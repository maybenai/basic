//
//  SingleChooseCollectionView.h
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseBlock) (NSString * chooseContent, NSIndexPath * indexPath);

@interface SingleChooseCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

/**
 *  UICollectionView
 */
@property(nonatomic, strong) UICollectionView * myCollectionView;
/**
 *  数据源
 */
@property(nonatomic, strong) NSMutableArray * dataArr;
/**
 *  选中的元素数组
 */
@property(nonatomic, strong) NSMutableArray * chooseArr;
/**
 *  当前选择的下标
 */
@property(nonatomic, strong) NSIndexPath * currentSelectIndexPath;
/**
 *  选择的输出block
 */
@property(nonatomic, copy) ChooseBlock block;


+ (instancetype)shareCollectionViewWithFrame:(CGRect)frame;

@end
