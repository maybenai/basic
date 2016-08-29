//
//  ViewController.m
//  NetworkStatus
//
//  Created by lisonglin on 16/8/26.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@property(nonatomic, strong)Reachability * hostReach;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    self.hostReach =[Reachability reachabilityWithHostName:@"www.google.com"];//可以以多种形式初始化
    [self.hostReach startNotifier]; //开始监听,会启动一个run loop
    [self updateInterfaceWithReachability: self.hostReach];

}


// 连接改变

- (void)reachabilityChanged: (NSNotification*)note
{
    Reachability*curReach = [note object];
    
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    [self updateInterfaceWithReachability:curReach];
}
//处理连接改变后的情况

- (void)updateInterfaceWithReachability: (Reachability*)curReach
{
    //对连接改变做出响应的处理动作。
    NetworkStatus status=[curReach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
            NSLog(@"当前网络不可用");
            break;
        case ReachableViaWiFi:
            NSLog(@"当前网络为wifi");
            break;
        case ReachableViaWWAN:
            NSLog(@"当前网络状态为3g");
            break;
        default:
            break;
    }
    
    
}













@end
