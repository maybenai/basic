//
//  ViewController.m
//  QRCodeDemo
//
//  Created by lisonglin on 2017/4/10.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "ViewController.h"
#import "QRScanView.h"

#import "ResultViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) AVCaptureSession * session;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@property(nonatomic, strong) QRScanView * scanningView;


#define ScreenWidth self.view.frame.size.width
#define ScreenHigh  self.view.frame.size.height

@end

@implementation ViewController


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setUpQRScan];
    
    [self.view addSubview:self.scanningView];
    
    [self.scanningView addTimer];
}


- (QRScanView *)scanningView
{
    if (!_scanningView) {
        _scanningView = [QRScanView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
    }
    return _scanningView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"QRCode Scan";

}

//initial
- (void)setUpQRScan
{
    //device
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //input
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //output
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    //session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    [output setRectOfInterest:CGRectMake(0.05, 0.2, 0.7, 0.6)];
    
    //添加扫描动画
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    [_session startRunning];
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描成功之后的提示音
    [self scanSuccessPlaysound:@"sound.caf"];
    
    //停止扫描
    [self.session stopRunning];
    
    //删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    
    NSString * stringValue;
    if ([metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        ResultViewController * vc = [[ResultViewController alloc] init];
        vc.string = stringValue;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


#pragma mark -- 扫描成功之后播放音频
- (void)scanSuccessPlaysound:(NSString *)name
{
    //获取音效
    NSString * audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL * fileUrl = [NSURL fileURLWithPath:audioFile];
    
    //1.获取系统声音ID
    SystemSoundID soundId = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundId);
    
    AudioServicesAddSystemSoundCompletion(soundId, NULL, NULL, soundCompleteCallBack, NULL);
    
}

void soundCompleteCallBack(SystemSoundID soundID, void *clientData){
    //播放完成
}



- (void)dealloc
{
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

@end
