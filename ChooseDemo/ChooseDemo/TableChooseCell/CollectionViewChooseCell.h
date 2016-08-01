//
//  CollectionViewChooseCell.h
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewChooseCell : UICollectionViewCell

@property(nonatomic,retain)UILabel * titleLab;
@property(nonatomic,retain)UIButton * SelectIconBtn;
@property (nonatomic,assign)BOOL isSelected;
-(void)UpdateCellWithState:(BOOL)select;

@end
