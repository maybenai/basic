//
//  AppVersionUpdate.h
//  AppVersionDemo
//
//  Created by lisonglin on 2016/12/20.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppVersionUpdate : NSObject

//是否发现新版本
//appid : appStore里面的appId
+ (BOOL)checkoutAppVersionWithAppId:(NSString *)appid;

@end
