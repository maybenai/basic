//
//  ViewController.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "CollectViewVC_Mulchoose.h"
#import "CollectViewVC_SingleChoose.h"
#import "TableVC_MulChoose.h"
#import "TableVC_SingleChoose.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton * TableChooseBtn = [self createBtnTitle:@"TableView多选" Selector:@selector(TableMulChooseBtn:)];
    [self.view addSubview:TableChooseBtn];
    [TableChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(50);
    }];
    
    UIButton * TableSingleChooseBtn = [self createBtnTitle:@"TableView单选" Selector:@selector(TableSigleChooseBtn:)];
    [self.view addSubview:TableSingleChooseBtn];
    [TableSingleChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TableChooseBtn.mas_left);
        make.right.equalTo(TableChooseBtn.mas_right);
        make.top.equalTo(TableChooseBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    
    UIButton * CollectMulChooseBtn = [self createBtnTitle:@"CollectView多选" Selector:@selector(CollectViewChooseBtn:)];
    [self.view addSubview:CollectMulChooseBtn];
    [CollectMulChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TableChooseBtn.mas_left);
        make.right.equalTo(TableChooseBtn.mas_right);
        make.top.equalTo(TableSingleChooseBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    UIButton * CollectSingleChooseBtn = [self createBtnTitle:@"CollectView单选" Selector:@selector(CollectViewSingleChooseBtn:)];
    [self.view addSubview:CollectSingleChooseBtn];
    [CollectSingleChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TableChooseBtn.mas_left);
        make.right.equalTo(TableChooseBtn.mas_right);
        make.top.equalTo(CollectMulChooseBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
}


-(UIButton *)createBtnTitle:(NSString *)title Selector:(SEL)selector{
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor lightGrayColor];
    return  btn;
}

-(void)TableMulChooseBtn:(UIButton *)btn{
    TableVC_MulChoose * tableChoose = [[TableVC_MulChoose alloc]init];
    tableChoose.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:tableChoose animated:YES];
}

-(void)TableSigleChooseBtn:(UIButton *)btn{
    TableVC_SingleChoose* tableSingleChoose = [[TableVC_SingleChoose alloc]init];
    tableSingleChoose.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController pushViewController:tableSingleChoose animated:YES];
    
}

-(void)CollectViewChooseBtn:(UIButton *)btn{
    CollectViewVC_Mulchoose * collectChoose = [[CollectViewVC_Mulchoose alloc]init];
    collectChoose.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController pushViewController:collectChoose animated:YES];
}

-(void)CollectViewSingleChooseBtn:(UIButton *)btn{
    CollectViewVC_SingleChoose * collectSingleChoose = [[CollectViewVC_SingleChoose alloc]init];
    [self.navigationController pushViewController:collectSingleChoose animated:YES];
}

@end
