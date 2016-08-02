//
//  LockView.m
//  LockView
//
//  Created by lisonglin on 16/1/27.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "LockView.h"

@interface LockView ()
/**
 *  选中的所有按钮
 */
@property(nonatomic, strong) NSMutableArray * selectedBtns;
/**
 *  最后一个触摸点
 */
@property(nonatomic, assign) CGPoint lastPoint;

@end

@implementation LockView

- (NSMutableArray *)selectedBtns
{
    if (!_selectedBtns) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}

//重写init方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpBtns];
    }
    return self;
}


//设置9个按钮
- (void)setUpBtns
{
    for (int i = 0; i < 9; i ++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        //设置按钮不可用
        btn.userInteractionEnabled = NO;
        btn.tag = i;
        
        [self addSubview:btn];
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

//判断当前的触摸点是否在按钮的范围内，如果在范围内，设置按钮为选中状态
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取当前的触摸点
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    //判断当前的触摸点是否在按钮的范围内
    //遍历所有的按钮
    for (UIButton * btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, touchPoint)) {
            NSLog(@"YES...");

            //添加到数组里面
            if (btn.selected == NO) {
                [self.selectedBtns addObject:btn];
            }
            
            //设置选中状态
            btn.selected = YES;
        }else{
            self.lastPoint = touchPoint;
        }
        
    }
    //重绘
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%ld",self.selectedBtns.count);
    
    NSMutableString * passWord = [NSMutableString string];
    
    for (UIButton * selectedBtn in self.selectedBtns) {
        
        [passWord appendFormat:@"%ld",selectedBtn.tag];
    }
    
    
    //绘制完了将密码传出去
    if ([self.delegate respondsToSelector:@selector(lockView:didSelectedPassWord:)]) {
        
        [self.delegate lockView:self didSelectedPassWord:passWord];
    }
    
    
    //手指放开取消连线
    //取消按钮的状态为no
//    [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@"NO"];
    for (UIButton * btn in self.selectedBtns) {
        btn.selected = NO;
    }
        
    //移除所有选中的按钮
    [self.selectedBtns removeAllObjects];
    //重绘
    [self setNeedsDisplay];
    
}

#pragma mark --绘制按钮间的连线
- (void)drawRect:(CGRect)rect
{
    //遍历所有选中的按钮
    NSInteger selectedCount = self.selectedBtns.count;
    
    if (selectedCount == 0) {
        return;
    }
    
    //创建一个路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < selectedCount; i ++) {
        CGPoint btnCenter = [self.selectedBtns[i] center];
        if (i == 0) {
            [path moveToPoint:btnCenter];
        }else{
            [path addLineToPoint:btnCenter];
        }
    }
    
    //追加一个路径
    [path addLineToPoint:self.lastPoint];
    
    //设置线宽和颜色
    path.lineWidth = 8;
    [[UIColor greenColor] set];
    //设置连接点的样式
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    //渲染
    [path stroke];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //重新布局9个按钮
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    //间距
    CGFloat margin = (self.frame.size.width - 3 * btnW) / 4;
    
    NSInteger btnCount = self.subviews.count;
    for (int i = 0; i < btnCount; i ++) {
        UIButton * btn = self.subviews[i];
        
        //计算每一个按钮的位置
        //列
        NSInteger column = i % 3;
        //行
        NSInteger row = i / 3;
        
        CGFloat btnX = margin + (margin + btnW) * column;
        CGFloat btnY = margin + (margin + btnH) * row;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    

}


@end
