//
//  AppVersionUpdate.m
//  AppVersionDemo
//
//  Created by lisonglin on 2016/12/20.
//  Copyright © 2016年 appleLi. All rights reserved.
//
//1174276117
#import "AppVersionUpdate.h"

#define APP_URL @"https://itunes.apple.com/lookup?id="

@implementation AppVersionUpdate

+ (BOOL)checkoutAppVersionWithAppId:(NSString *)appid
{
    __block BOOL flag = NO;//是否有新版本的标志
    //获取本地的版本号
    NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    //获取应用的版本号
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",APP_URL,appid];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionTask * task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if ([dataDic[@"resultCount"] boolValue]) {
            if ([dataDic[@"results"] isKindOfClass:[NSArray class]]) {
                NSString * appVersion = dataDic[@"results"][0][@"version"];
                if ([appVersion floatValue] > [currentVersion floatValue]) {//如果appStore上的版本号比本地的版本号大,则发现新版本
                    flag = YES;
                }else{
                    flag = NO;
                }
            }
        }
    }];
    
    [task resume];
    
    return flag;
}

@end
