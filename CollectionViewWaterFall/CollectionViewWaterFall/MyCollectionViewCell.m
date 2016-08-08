//
//  MyCollectionViewCell.m
//  CollectionViewWaterFall
//
//  Created by lisonglin on 16/8/2.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

#pragma mark -
#pragma mark init methods
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:25];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
