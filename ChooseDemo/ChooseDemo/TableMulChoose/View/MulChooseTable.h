//
//  MulChooseTable.h
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseBlock) (NSString * chooseContent, NSMutableArray *array);

@interface MulChooseTable : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView * myTable;

@property(nonatomic, strong) NSMutableArray * dataArr;

@property(nonatomic, strong) NSMutableArray * choosedArr;

@property(nonatomic, copy) ChooseBlock block;

@property(nonatomic, assign) BOOL ifAllSelected;

@property(nonatomic, assign) BOOL ifAllSelecteSwitch;

+ (MulChooseTable *)shareTableWithFrame:(CGRect)frame headerTitle:(NSString *)title;

+ (instancetype)shareTableWithFrame:(CGRect)frame;

- (void)ReloadData;
@end
