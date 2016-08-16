//
//  ViewController.m
//  KVC&KVC&Notification&Delegate
//
//  Created by lisonglin on 16/8/16.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"

#import "SecondViewController.h"

#import "Person.h"

@interface ViewController ()

@property(nonatomic, strong) Person * person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"name" object:nil];
    
    
    [self testKVC];
    [self testKVO];

}


//KVC test
/**
 *  KVC可以给在.m里面的属性赋值
 */
- (void)testKVC
{
    self.person = [[Person alloc] init];
    
    [self.person setValue:[NSNumber numberWithInt:170] forKey:@"height"];
    
    NSLog(@"height = %@",[self.person valueForKey:@"height"]);
}



- (void)testKVO
{
    self.person = [[Person alloc] init];
    [self.person addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"height"]) {
        NSLog(@"height is changed! new = %@",[change valueForKey:NSKeyValueChangeNewKey]);
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//点击更改height属性的值
- (IBAction)btnClick {
    
    [self.person setValue:[NSNumber numberWithInt:180] forKey:@"height"];
    
    NSLog(@"height = %@",[self.person valueForKey:@"height"]);
    
    
}


#pragma mark  NotificationCenter--=========================================
- (IBAction)jumpClick {
    
    SecondViewController * second = [[SecondViewController alloc] init];
    
    [self presentViewController:second animated:YES completion:nil];
}


- (void)notification:(NSNotification *)notification
{
    NSLog(@"%@",notification.userInfo);
}


@end
