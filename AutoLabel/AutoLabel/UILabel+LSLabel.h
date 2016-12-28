//
//  UILabel+LSLabel.h
//  AutoLabel
//
//  Created by lisonglin on 2016/12/28.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AutoAdaptiveDerection) {
    AutoAdaptiveHorizontal, //水平自适应
    AutoAdaptiveVertical    //垂直自适应
};

@interface UILabel (LSLabel)

/**
 实现label自动换行 支持横向和纵向
 
 @param string 文本字符串
 @param size 设置大小
 @param adaptiveDerection 自适应方向
 @return 返回一个CGSize对象
 */
+ (CGSize)stringWithAutoLabel:(NSString *)string size:(CGSize)size options:(AutoAdaptiveDerection)adaptiveDerection font:(UIFont *)font;

/**
 一行代码初始化不带自适应的Label

 @param text text
 @param frame frame
 @param font font
 @param textColor textColor
 @return Label
 */
+ (instancetype)lableWith:(NSString *)text frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment backGroundColor:(UIColor *)backColor;



@end
