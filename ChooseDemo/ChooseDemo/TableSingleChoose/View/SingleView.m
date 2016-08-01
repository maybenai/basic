//
//  SingleView.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "SingleView.h"
#import "TableChooseCell.h"
#define HeaderHeight 50
#define CellHeight 50
@implementation SingleView

+ (SingleView *)shareTableViewWithFrame:(CGRect)frame
{
    SingleView * table = [[SingleView alloc] initWithFrame:frame];
    return table;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatTable];
    }
    return self;
}

- (void)creatTable
{
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    _myTable.dataSource = self;
    _myTable.delegate = self;
    _myTable.separatorStyle = UITableViewStylePlain;
    [self addSubview:_myTable];
}

#pragma mark  UITableViewDelegate UITableViewDataSource--=========================================
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    TableChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TableChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.titleLabel.text = self.dataArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentSelectIndex != nil && _currentSelectIndex != indexPath) {
        TableChooseCell * cell = [tableView cellForRowAtIndexPath:_currentSelectIndex];
        [cell UpdateCellWithState:NO];

    }
    TableChooseCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    _currentSelectIndex = indexPath;
    
    _block(cell.titleLabel.text,indexPath);
}

-(void)ReloadData{
    [self.myTable reloadData];
}
@end
