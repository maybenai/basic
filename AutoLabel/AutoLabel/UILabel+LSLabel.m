//
//  UILabel+LSLabel.m
//  AutoLabel
//
//  Created by lisonglin on 2016/12/28.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "UILabel+LSLabel.h"

@implementation UILabel (LSLabel)

+ (CGSize)stringWithAutoLabel:(NSString *)string size:(CGSize)size options:(AutoAdaptiveDerection)adaptiveDerection font:(UIFont *)font
{
    CGSize tempSize = {0,0};

    if (adaptiveDerection == 0) {//水平自适应

        tempSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT,size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
    }else{//垂直自适应
        tempSize = [string boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }

    return tempSize;
}


+ (instancetype)lableWith:(NSString *)text frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment backGroundColor:(UIColor *)backColor
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text;
    
    label.font = font;
    
    label.textColor = textColor;
    
    label.textAlignment = alignment;
    
    label.backgroundColor = backColor;
    
    return label;
}

@end
