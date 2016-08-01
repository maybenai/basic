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

@property(nonatomic, strong) UICollectionView * myCollectionView;
@property(nonatomic, strong) NSMutableArray * dataArr;
@property(nonatomic, strong) NSMutableArray * chooseArr;
@property(nonatomic, strong) NSIndexPath * currentSelectIndexPath;
@property(nonatomic, copy) ChooseBlock block;


+ (instancetype)shareCollectionViewWithFrame:(CGRect)frame;

@end
