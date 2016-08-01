//
//  TableChooseCell.h
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableChooseCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic, strong)UIButton *SelectIconBtn;
@property (nonatomic,assign)BOOL isSelected;


-(void)UpdateCellWithState:(BOOL)select;

@end
