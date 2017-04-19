//
//  LSImage.m
//  LSCollectionView
//
//  Created by lisonglin on 18/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "LSImage.h"

@implementation LSImage

+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic
{
    LSImage * image = [[LSImage alloc] init];
    image.imageUrl = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image;
}

@end
