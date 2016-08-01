//
//  MulChooseView.h
//  ChooseDemo
//
//  Created by lisonglin on 16/7/26.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseBlock) (NSString * content,NSMutableArray * array);

@interface MulChooseView : UIView

@property(nonatomic, strong) NSMutableArray * dataArr;

@property(nonatomic, copy) ChooseBlock block;

+ (instancetype)mulChooseViewWithFrame:(CGRect)frame headerTitle:(NSString *)title;


+ (instancetype)mulChooseViewWithFrame:(CGRect)frame;

- (void)ReloadData;

@end
