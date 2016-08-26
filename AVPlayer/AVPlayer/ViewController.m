//
//  ViewController.m
//  AVPlayer
//
//  Created by lisonglin on 16/8/19.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "LSLAVPlayerViewController.h"
#import "LSLMusicViewController.h"
#import "LSLRecordViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUserInterface];
}


- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PLAYER";
    
    //初始化按钮
    //视频按钮
    UIButton * mvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mvBtn setTitle:@"视频播放" forState:UIControlStateNormal];
    mvBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mvBtn];
    [mvBtn addTarget:self action:@selector(mvBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //音频按钮
    UIButton * musicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [musicBtn setTitle:@"音频播放" forState:UIControlStateNormal];
    musicBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:musicBtn];
    [musicBtn addTarget:self action:@selector(musicBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    //录音按钮
    UIButton * recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordBtn setTitle:@"录音" forState:UIControlStateNormal];
    recordBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:recordBtn];
    [recordBtn addTarget:self action:@selector(recordBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    //音频按钮
    [musicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 100);
    }];
    
    //视频按钮
    [mvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-80);
        make.centerX.mas_equalTo(0);
        make.height.equalTo(musicBtn);
        make.width.equalTo(musicBtn);
    }];
    
    //录音按钮
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(80);
        make.centerX.mas_equalTo(0);
        make.height.equalTo(musicBtn);
        make.width.equalTo(musicBtn);
    }];
    
    
}


//视频播放器
- (void)mvBtnClick:(UIButton *)sender
{
    LSLAVPlayerViewController * avPlayer = [[LSLAVPlayerViewController alloc] init];
    
    avPlayer.title = sender.titleLabel.text;
    [self.navigationController pushViewController:avPlayer animated:YES];
    
}

//音乐播放器
- (void)musicBtnClick:(UIButton *)sender
{
    LSLMusicViewController * musicPlayer = [[LSLMusicViewController alloc] init];
    musicPlayer.title = sender.titleLabel.text;

    [self.navigationController pushViewController:musicPlayer animated:YES];
    
}

//录音
- (void)recordBtnClick:(UIButton *)sender
{
    LSLRecordViewController * recordPlayer = [[LSLRecordViewController alloc] init];
    recordPlayer.title = sender.titleLabel.text;

    [self.navigationController pushViewController:recordPlayer animated:YES];
    
                                            
}

@end
