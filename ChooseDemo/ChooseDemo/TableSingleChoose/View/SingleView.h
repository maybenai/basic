//
//  SingleView.h
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseBlock) (NSString * chooseContent,NSIndexPath * indexPath);
@interface SingleView : UIView<UITableViewDataSource,UITableViewDelegate>
/**
 *  数据源
 */
@property(nonatomic, strong) NSArray * dataArr;
@property(nonatomic, strong) UITableView * myTable;
@property(nonatomic, strong) NSIndexPath * currentSelectIndex;

@property(nonatomic, copy) ChooseBlock  block;

+ (SingleView *)shareTableViewWithFrame:(CGRect)frame;

- (void)ReloadData;

@end
