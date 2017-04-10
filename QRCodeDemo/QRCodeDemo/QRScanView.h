//
//  QRScanView.h
//  QRCodeDemo
//
//  Created by lisonglin on 2017/4/10.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScanView : UIView

- (instancetype)initWithFrame:(CGRect)frame layer:(CALayer *)layer;

+ (instancetype)scanningViewWithFrame:(CGRect)frame layer:(CALayer *)layer;


- (void)addTimer;

- (void)removeTimer;

@end
