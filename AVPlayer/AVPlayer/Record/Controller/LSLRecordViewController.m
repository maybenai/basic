//
//  LSLRecordViewController.m
//  AVPlayer
//
//  Created by lisonglin on 16/8/19.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "LSLRecordViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kRecordAudioFile @"myRecord.caf"
@interface LSLRecordViewController ()<AVAudioRecorderDelegate>
/**
 *  音频录音机
 */
@property(nonatomic, strong) AVAudioRecorder * audioRecorder;
/**
 *  音频播放器
 */
@property(nonatomic, strong) AVAudioPlayer * audioPlayer;
/**
 *  计时器
 */
@property(nonatomic, strong) NSTimer * timer;

/**
 *  音量条
 */
@property(nonatomic, strong) UIProgressView * progress;

@end

@implementation LSLRecordViewController
//懒加载
- (AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder) {
        //创建录音保存路径
        NSURL * url = [self getSavePath];
        //创建录音格式设置
        NSDictionary * setting = [self getAudioSetting];
        
        //创造录音机
        NSError * error = nil;
        
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        //如果要监控声波必须设置为YES
        _audioRecorder.meteringEnabled = YES;
        
        if (error) {
            NSLog(@"%@",error.localizedDescription);
            return nil;
        }
        
    }
    return _audioRecorder;
}

//创建播放器
- (AVAudioPlayer *)audioPlayer
{
    if (!_audioPlayer) {
        NSURL * url = [self getSavePath];
        NSError * error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops = 0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadSubViews];
    
    [self setAudioSession];
}

- (void)audioPowerChange
{
    //更新测量值
    [self.audioRecorder updateMeters];
    
    float power = [self.audioRecorder averagePowerForChannel:0];
    
    CGFloat progress = (1.0/160.0) * (power + 160);
    [self.progress setProgress:progress];
    
}

//取得录音文件保存路径
- (NSURL *)getSavePath
{
    NSString * urlStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    urlStr = [urlStr stringByAppendingPathComponent:kRecordAudioFile];
    
    NSURL * url = [NSURL fileURLWithPath:urlStr];
    
    return url;
}
//取得录音文件设置
- (NSDictionary *)getAudioSetting
{
    NSMutableDictionary * dicM = [NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采集率
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道，这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    return dicM;
}
- (void)loadSubViews
{
    UIProgressView * progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame = CGRectMake(50, self.view.center.y - 130, CGRectGetWidth(self.view.bounds) - 100, 20);
    progress.progressTintColor = [UIColor grayColor];
    progress.trackTintColor = [UIColor blueColor];
    self.progress = progress;
    [self.view addSubview:progress];
    
    //开始
    UIButton * startBtn = [self setUpOneBtnWithTitle:@"开始"];
    startBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    //暂停
    UIButton * pauseBtn = [self setUpOneBtnWithTitle:@"暂停"];
    pauseBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 25);
    [pauseBtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];

    //恢复录音
    UIButton * reStartBtn = [self setUpOneBtnWithTitle:@"恢复录音"];
    reStartBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 25);
    [reStartBtn addTarget:self action:@selector(reStart) forControlEvents:UIControlEventTouchUpInside];

    //停止录音
    UIButton * stopBtn = [self setUpOneBtnWithTitle:@"停止"];
    stopBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 80);
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark --设置音频会话

- (void)setAudioSession
{
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以再录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}



//开始
- (void)start
{
    NSLog(@"%s",__func__);
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];
        self.timer.fireDate = [NSDate distantPast];
    }
}
//暂停
- (void)pause
{
    NSLog(@"%s",__func__);

    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}
//恢复
- (void)reStart
{
    NSLog(@"%s",__func__);

    [self start];
}
//停止
- (void)stop
{
    NSLog(@"%s",__func__);

    [self.audioRecorder stop];
    self.timer.fireDate = [NSDate distantFuture];
    self.progress.progress = 0.0;
    
}


#pragma mark  AVAudioRecorderDelegate--=========================================
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    
    NSLog(@"finish");
}

#pragma mark  initial btn--=========================================

- (UIButton *)setUpOneBtnWithTitle:(NSString *)title
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 120, 30);
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

@end
