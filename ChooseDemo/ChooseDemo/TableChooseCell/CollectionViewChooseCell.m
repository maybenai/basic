//
//  CollectionViewChooseCell.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "CollectionViewChooseCell.h"



@implementation CollectionViewChooseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithView];
    }
    return self;
}

- (void)initWithView
{
    _SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _SelectIconBtn.userInteractionEnabled = NO;
    [_SelectIconBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_SelectIconBtn setImage:[UIImage imageNamed:@"collectview_Unselect"] forState:UIControlStateNormal];
    [_SelectIconBtn setImage:[UIImage imageNamed:@"collectview_Selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:_SelectIconBtn];
    [_SelectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = [UIColor darkTextColor];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

@end
