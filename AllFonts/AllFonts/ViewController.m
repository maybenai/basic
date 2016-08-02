//
//  ViewController.m
//  AllFonts
//
//  Created by appleLi on 15/7/19.
//  Copyright (c) 2015年 appleLi. All rights reserved.
//

#import "ViewController.h"

#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableDictionary * _dataSource;
    NSMutableArray * _keys;
    
}

- (void)inilizitionUserInterface;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"FontList";
    [self inilizitionUserInterface];
}

- (void)inilizitionUserInterface
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setTintColor:[UIColor redColor]];
    [self.view addSubview:_tableView];
    
    _dataSource = [[NSMutableDictionary alloc]init];
    _keys = [[NSMutableArray alloc]init];
    NSArray * fonts = [UIFont familyNames];
    NSMutableArray * otherList = [NSMutableArray array];
    //按首字母分类
    for (int i = 'A'; i <= 'Z'; i++) {
        NSMutableArray * fontsArr = [NSMutableArray array];
        for (NSString *font in fonts) {
            char character = [[font substringToIndex:1]UTF8String][0];
            if (character == i || character == i + 32) {
                [fontsArr addObject:font];
            }else if (character < 'A' || character > 'z' || (character > 'Z' && character < 'a')){
                [otherList addObject:font];
            }

        }
        //添加到数组作为数据源
        if ([fontsArr count] > 0) {
            [_dataSource setObject:fontsArr forKey:[NSString stringWithFormat:@"%c",i]];
        }
    }
    NSMutableArray * keys = [[_dataSource allKeys] mutableCopy];
    //自动排序
    [keys sortUsingSelector:@selector(caseInsensitiveCompare:)];
    [keys addObject:@"#"];
    [_keys addObjectsFromArray:keys];
    
    UIView * view = [[UIView alloc]init];
    _tableView.tableFooterView = view;

}


#pragma mark  UITableViewDelegate UITableViewDataSource--====================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_dataSource[_keys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [_dataSource[_keys[indexPath.section]]objectAtIndex:indexPath.row];
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _keys[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController * detail = [[DetailViewController alloc]init];
    detail.fontName = [_dataSource[_keys[indexPath.section]]objectAtIndex:indexPath.row];
    detail.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
