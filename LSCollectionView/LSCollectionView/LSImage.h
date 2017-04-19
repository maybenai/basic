//
//  LSImage.h
//  LSCollectionView
//
//  Created by lisonglin on 18/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSImage : UIImage

@property(nonatomic, strong) NSURL * imageUrl;
@property(nonatomic, assign) CGFloat imageW;
@property(nonatomic, assign) CGFloat imageH;


+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic;

@end
