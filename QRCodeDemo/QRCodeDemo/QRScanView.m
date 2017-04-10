//
//  QRScanView.m
//  QRCodeDemo
//
//  Created by lisonglin on 2017/4/10.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "QRScanView.h"
#import <AVFoundation/AVFoundation.h>
#import "QRScanConst.h"

/** 扫描内容的Y值 */
#define scanContent_Y self.frame.size.height * 0.24
/** 扫描内容的X值 */
#define scanContent_X self.frame.size.width * 0.15

@interface QRScanView ()

@property(nonatomic, strong) AVCaptureDevice * device;
@property(nonatomic, strong) CALayer * tempLayer;
@property(nonatomic, strong) UIImageView * scanningLine;
@property(nonatomic, strong) NSTimer * timer;

@end


@implementation QRScanView

/** 扫描动画线(冲击波) 的高度 */
static CGFloat const scanninglineHeight = 12;
/** 扫描内容外部View的alpha值 */
static CGFloat const scanBorderOutsideViewAlpha = 0.4;

- (CALayer *)tempLayer
{
    if (!_tempLayer) {
        _tempLayer = [[CALayer alloc] init];
    }
    return _tempLayer;
}

+ (instancetype)scanningViewWithFrame:(CGRect)frame layer:(CALayer *)layer
{
    return [[self alloc] initWithFrame:frame layer:layer];
}


- (instancetype)initWithFrame:(CGRect)frame layer:(CALayer *)layer
{
    if (self = [super initWithFrame:frame]) {
        
        self.tempLayer = layer;
        
        //布局扫描界面
        [self setupSubViews];
        
    }
    return self;
}

- (void)setupSubViews
{
    //扫描内容的创建
    CALayer * scanContent_layer = [[CALayer alloc] init];
    CGFloat scanContent_layerX = scanContent_X;
    CGFloat scanContent_layerY = scanContent_Y;
    CGFloat scanContent_layerW = self.frame.size.width - 2 * scanContent_X;
    CGFloat scanContent_layerH = scanContent_layerW;
    scanContent_layer.frame = CGRectMake(scanContent_layerX, scanContent_layerY, scanContent_layerW, scanContent_layerH);
    scanContent_layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6].CGColor;
    scanContent_layer.borderWidth = 0.7;
    scanContent_layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.tempLayer addSublayer:scanContent_layer];
    
    
#pragma mark ---扫描外部view的创建
    //顶部layer的创建
    CALayer * top_layer = [[CALayer alloc] init];
    CGFloat top_layerX = 0;
    CGFloat top_layerY = 0;
    CGFloat top_layerW = self.frame.size.width;
    CGFloat top_layerH = scanContent_layerY;
    top_layer.frame = CGRectMake(top_layerX, top_layerY, top_layerW, top_layerH);
    top_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.layer addSublayer:top_layer];
    
    //左边layer的创建
    CALayer * left_layer = [[CALayer alloc] init];
    CGFloat left_layerX = 0;
    CGFloat left_layerY = top_layerH;
    CGFloat left_layerW = scanContent_X;
    CGFloat left_layerH = scanContent_layerH;
    left_layer.frame = CGRectMake(left_layerX, left_layerY, left_layerW, left_layerH);
    left_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.layer addSublayer:left_layer];
    
    //右边layer的创建
    CALayer * right_layer = [[CALayer alloc] init];
    CGFloat right_layerX = CGRectGetMaxX(scanContent_layer.frame);
    CGFloat right_layerY = top_layerH;
    CGFloat right_layerW = scanContent_X;
    CGFloat right_layerH = scanContent_layerH;
    right_layer.frame = CGRectMake(right_layerX, right_layerY, right_layerW, right_layerH);
    right_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.layer addSublayer:right_layer];
    
    //下面layer的创建
    CALayer * bottom_layer = [[CALayer alloc] init];
    CGFloat bottom_layerX = 0;
    CGFloat bottom_layerY = CGRectGetMaxY(scanContent_layer.frame);
    CGFloat bottom_layerW = self.frame.size.width;
    CGFloat bottom_layerH = self.frame.size.height - CGRectGetMaxY(scanContent_layer.frame);
    bottom_layer.frame = CGRectMake(bottom_layerX, bottom_layerY, bottom_layerW, bottom_layerH);
    bottom_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.layer addSublayer:bottom_layer];
    
    //提示label
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.backgroundColor = [UIColor clearColor];
    CGFloat promptLabelX = 0;
    CGFloat promptLabelY = CGRectGetMaxY(scanContent_layer.frame) + 30;
    CGFloat promptLabelW = self.frame.size.width;
    CGFloat promptLabelH = 25;
    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
    promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    [self addSubview:promptLabel];
    
    // 添加闪光灯按钮
    UIButton *light_button = [[UIButton alloc] init];
    CGFloat light_buttonX = 0;
    CGFloat light_buttonY = CGRectGetMaxY(promptLabel.frame) + scanContent_X * 0.5;
    CGFloat light_buttonW = self.frame.size.width;
    CGFloat light_buttonH = 25;
    light_button.frame = CGRectMake(light_buttonX, light_buttonY, light_buttonW, light_buttonH);
    [light_button setTitle:@"打开照明灯" forState:UIControlStateNormal];
    [light_button setTitle:@"关闭照明灯" forState:UIControlStateSelected];
    [light_button setTitleColor:promptLabel.textColor forState:(UIControlStateNormal)];
    light_button.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [light_button addTarget:self action:@selector(lightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:light_button];
    
#pragma mark --扫描边角imageView的创建
    //左上侧的image
    CGFloat margin = 7;
    UIImage * leftImage = [UIImage imageNamed:@"QRCodeLeftTop"];
    UIImageView * left_imageView = [[UIImageView alloc] init];
    CGFloat left_imageViewX = CGRectGetMinX(scanContent_layer.frame) - leftImage.size.width * 0.5 + margin;
    CGFloat left_imageViewY = CGRectGetMinY(scanContent_layer.frame) - leftImage.size.width * 0.5 + margin;
    CGFloat left_imageViewW = leftImage.size.width;
    CGFloat left_imageViewH = leftImage.size.height;
    left_imageView.frame = CGRectMake(left_imageViewX, left_imageViewY, left_imageViewW, left_imageViewH);
    left_imageView.image = leftImage;
    [self.tempLayer addSublayer:left_imageView.layer];
    
    //右上侧的image
    UIImage * rightImage = [UIImage imageNamed:@"QRCodeRightTop"];
    UIImageView * right_imageView = [[UIImageView alloc] init];
    CGFloat right_imageViewX = CGRectGetMaxX(scanContent_layer.frame) - rightImage.size.width * 0.5 - margin;
    CGFloat right_imageViewY = left_imageView.frame.origin.y;
    CGFloat right_imageViewW = rightImage.size.width;
    CGFloat right_imageViewH = rightImage.size.height;
    right_imageView.frame = CGRectMake(right_imageViewX, right_imageViewY, right_imageViewW, right_imageViewH);
    right_imageView.image = rightImage;
    [self.tempLayer addSublayer:right_imageView.layer];
    
    //左下侧的image
    UIImage * left_down_image = [UIImage imageNamed:@"QRCodeLeftBottom"];
    UIImageView * left_down_imageView = [[UIImageView alloc] init];
    CGFloat left_down_imageViewX = left_imageView.frame.origin.x;
    CGFloat left_down_imageViewY = CGRectGetMaxY(scanContent_layer.frame) - left_down_image.size.width / 2 - margin;
    CGFloat left_down_imageViewW = leftImage.size.width;
    CGFloat left_down_imageViewH = leftImage.size.height;
    left_down_imageView.frame = CGRectMake(left_down_imageViewX, left_down_imageViewY, left_down_imageViewW, left_down_imageViewH);
    left_down_imageView.image = left_down_image;
    [self.tempLayer addSublayer:left_down_imageView.layer];
    
    //右下侧的image
    UIImage *right_down_image = [UIImage imageNamed:@"QRCodeRightBottom"];
    UIImageView *right_down_imageView = [[UIImageView alloc] init];
    CGFloat right_down_imageViewX = right_imageView.frame.origin.x;
    CGFloat right_down_imageViewY = left_down_imageView.frame.origin.y;
    CGFloat right_down_imageViewW = leftImage.size.width;
    CGFloat right_down_imageViewH = leftImage.size.height;
    right_down_imageView.frame = CGRectMake(right_down_imageViewX, right_down_imageViewY, right_down_imageViewW, right_down_imageViewH);
    right_down_imageView.image = right_down_image;
    [self.tempLayer addSublayer:right_down_imageView.layer];
    
    
}

#pragma mark -- 照明灯点击时间
- (void)lightBtnClick:(UIButton *)sender
{
    if (sender.selected == NO) {//打开照明灯
        [self turnOnLight:YES];
        sender.selected = YES;
    }else{//关闭照明灯
        [self turnOnLight:NO];
        sender.selected = NO;
    }
}

- (void)turnOnLight:(BOOL)on
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasTorch]) {
        [_device lockForConfiguration:nil];
        if (on) {
            [_device setTorchMode:AVCaptureTorchModeOn];
        }else{
            [_device setTorchMode:AVCaptureTorchModeOff];
        }
        
        [_device unlockForConfiguration];
    }
}

#pragma mark -- 扫描线
- (UIImageView *)scanningLine
{
    if (!_scanningLine) {
        _scanningLine = [[UIImageView alloc] init];
        _scanningLine.image = [UIImage imageNamed:@"QRCodeScanningLine"];
        _scanningLine.frame = CGRectMake(scanContent_X * 0.5, scanContent_Y, self.frame.size.width - scanContent_X, scanninglineHeight);
    }
    return _scanningLine;
}

//扫描动画添加
- (void)addScanningLine
{
    [self.tempLayer addSublayer:self.scanningLine.layer];
}

#pragma mark -- 添加定时器
- (void)addTimer
{
    [self addScanningLine];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:SGQRCodeScanningLineAnimation target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


#pragma mark -- 移除定时器
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self.scanningLine removeFromSuperview];
    self.scanningLine = nil;
}

#pragma mark -- 定时器方法
- (void)timeAction
{
    __block CGRect frame = _scanningLine.frame;
    
    static BOOL flag = YES;
    
    if (flag) {
        frame.origin.y = scanContent_Y;
        flag = NO;
        
        [UIView animateWithDuration:SGQRCodeScanningLineAnimation animations:^{
            frame.origin.y += 5;
            _scanningLine.frame = frame;
        }];
    }else{
        if (_scanningLine.frame.origin.y >= scanContent_Y) {
            CGFloat scanContent_MaxY = scanContent_Y + self.frame.size.width - 2 * scanContent_X;
            if (_scanningLine.frame.origin.y >= scanContent_MaxY - 10) {
                frame.origin.y = scanContent_Y;
                _scanningLine.frame = frame;
                flag = YES;
            }else{
                [UIView animateWithDuration:SGQRCodeScanningLineAnimation animations:^{
                    frame.origin.y += 5;
                    _scanningLine.frame = frame;
                }];
            }
        }else{
            flag = !flag;
        }
    }
    
}











@end
