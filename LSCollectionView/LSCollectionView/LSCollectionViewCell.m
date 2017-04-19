//
//  LSCollectionViewCell.m
//  LSCollectionView
//
//  Created by lisonglin on 2017/4/6.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "LSCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface LSCollectionViewCell ()
@property(nonatomic, weak) UIImageView * imageView;
@property(nonatomic, weak) UILabel * label;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation LSCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self.contentView addSubview:label];
//        self.label = label;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    self.label.text = text;
}

- (void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    
//    NSData * data = [NSData dataWithContentsOfURL:imageUrl];
//    NSString * imageStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
//    self.imageView.image = [UIImage imageNamed:imageStr];
    
//    [self.image sd_setImageWithURL:imageUrl];
}

@end
