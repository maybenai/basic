//
//  LSLKeyBoardView.m
//  LSLKeyBoard
//
//  Created by lisonglin on 16/8/18.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "LSLKeyBoardView.h"

@interface LSLKeyBoardView ()


@end

@implementation LSLKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //
        [self setUpBtns:frame];
    }
    return self;
}

//初始化btn
- (void)setUpBtns:(CGRect)frame
{
    //3列4行
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = frame.size.width / 3;
    CGFloat btnH = frame.size.height / 4;
    
    int tag = 0;
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 4; j ++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX + i * btnW ,btnY + j * btnH,btnW,btnH);
            btn.backgroundColor = [UIColor redColor];
            [self addSubview:btn];
            btn.tag = tag;
            if (btn.tag == 3) {
                [btn setTitle:@"x" forState:UIControlStateNormal];
                
            }
            if (btn.tag == 11) {
                [btn setTitle:@"完成" forState:UIControlStateNormal];
            }
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            tag ++;
            
        }
    }
    
    //给剩下的btn赋值
    [self setUpRestBtnTitle];

    
    //画水平的view
    for (int i = 0; i < 3; i ++) {
        UIView * columnView = [[UIView alloc] initWithFrame:CGRectMake(0, btnH * (i + 1), frame.size.width, 0.5)];
        columnView.backgroundColor = [UIColor blackColor];
        [self addSubview:columnView];
    }
    
    
    //画垂直的view
    for (int i = 0; i < 2; i ++) {
        UIView * rowView = [[UIView alloc] initWithFrame:CGRectMake(btnW * (i + 1), 0, 0.5,frame.size.height)];
        rowView.backgroundColor = [UIColor blackColor];
        [self addSubview:rowView];
    }
        
}

- (void)btnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(keyBoardBtnClick:clickBtn:)]) {
        [self.delegate keyBoardBtnClick:self clickBtn:sender];
    }
}

- (void)setUpRestBtnTitle
{
    NSMutableArray * titleArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];

    for (UIButton * btn in self.subviews) {
        if (btn.titleLabel.text == nil) {
            int random = arc4random() % titleArray.count;
            [btn setTitle:titleArray[random] forState:UIControlStateNormal];
            [titleArray removeObjectAtIndex:random];
        }
    }
}

@end
