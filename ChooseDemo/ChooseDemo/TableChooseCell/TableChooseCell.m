//
//  TableChooseCell.m
//  ChooseDemo
//
//  Created by lisonglin on 16/7/25.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "TableChooseCell.h"

#define HorizonGap 15
#define TilteBtnGap 10
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TableChooseCell

- (void)awakeFromNib {
    [self awakeFromNib];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, ColorRGB(0xf7f7f7).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self makView];
    }
    return self;
}

- (void)makView
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(self.contentView.mas_height);
    }];
    
    self.SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
    self.SelectIconBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.SelectIconBtn];
    [self.SelectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_top);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
}

-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
