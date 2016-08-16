//
//  SecondViewController.m
//  Copy&MultableCopy
//
//  Created by lisonglin on 16/8/16.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property(nonatomic, retain) NSString * myRetainStr;
@property(nonatomic, copy) NSString * myCopyStr;
@property(nonatomic, strong) NSString * myStrongStr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testNSMutableStringCopyRetain];
//    [self testNSStringCopyRetain];
    
//    [self testNSStringStrongRetain];
    [self testNSMutableStringStrongRetain];
    
    
    //结论:对于NSString和NSMutableString而言，不管是retain还是strong、copy都是浅复制，只增加引用计数
    //    对于NSString而言，copy是浅复制;对于NSMutableString而言,copy是深复制
}


//NSMutableString的retain和copy区别
- (void)testNSMutableStringCopyRetain
{
    NSMutableString * mStr = [NSMutableString stringWithFormat:@"abc"];
    self.myRetainStr = mStr;
    self.myCopyStr = mStr;
    NSLog(@"mStr:%p,%p",mStr,&mStr);
    NSLog(@"retainStr:%p,%p",_myRetainStr,&_myRetainStr);
    NSLog(@"copyStr:%p,%p",_myCopyStr,&_myCopyStr);
    
    
//    2016-08-16 10:29:27.434 Copy&MultableCopy[15323:1086651] mStr:0x7fa62251c840,0x7fff5556aa08
//    2016-08-16 10:29:27.435 Copy&MultableCopy[15323:1086651] retainStr:0x7fa62251c840,0x7fa622718830
//    2016-08-16 10:29:27.435 Copy&MultableCopy[15323:1086651] copyStr:0xa000000006362613,0x7fa622718838
    
    //从运行结果来看，对于mutableString，retain是增加引用计数，copy是深复制
}


//NSString的retain和copy区别
- (void)testNSStringCopyRetain
{
    NSString * mStr = [NSString stringWithFormat:@"abc"];
    self.myRetainStr = mStr;
    self.myCopyStr = mStr;
    NSLog(@"mStr:%p,%p",mStr,&mStr);
    NSLog(@"retainStr:%p,%p",_myRetainStr,&_myRetainStr);
    NSLog(@"copyStr:%p,%p",_myCopyStr,&_myCopyStr);
    
//    2016-08-16 10:36:10.131 Copy&MultableCopy[15339:1092465] mStr:0xa000000006362613,0x7fff5eaf5a08
//    2016-08-16 10:36:10.131 Copy&MultableCopy[15339:1092465] retainStr:0xa000000006362613,0x7fcae95ab6d0
//    2016-08-16 10:36:10.151 Copy&MultableCopy[15339:1092465] copyStr:0xa000000006362613,0x7fcae95ab6d8
    
    //从运行结果来看,对于NSString,retain是增加引用计数,copy也是增加引用计数(浅复制)，之间没有任何区别
}


//NSString的retain和strong区别
- (void)testNSStringStrongRetain
{
    NSString * mStr = [NSString stringWithFormat:@"abc"];
    self.myRetainStr = mStr;
    self.myStrongStr = mStr;
    NSLog(@"mStr:%p,%p",mStr,&mStr);
    NSLog(@"strongStr:%p,%p",_myStrongStr,&_myStrongStr);
    NSLog(@"retainStr:%p,%p",_myRetainStr,&_myRetainStr);
    
    
//    2016-08-16 10:39:15.433 Copy&MultableCopy[15350:1094290] mStr:0xa000000006362613,0x7fff51d70a08
//    2016-08-16 10:39:15.433 Copy&MultableCopy[15350:1094290] strongStr:0x0,0x7ff059d20ec0
//    2016-08-16 10:39:15.433 Copy&MultableCopy[15350:1094290] retainStr:0xa000000006362613,0x7ff059d20eb0
    
    //从结果来看,对于NSString而言，retain是增加引用计数，strong是浅复制,没有任何区别

}


//NSMutableString的retain和strong区别
- (void)testNSMutableStringStrongRetain
{
    NSMutableString * mStr = [NSMutableString stringWithFormat:@"abc"];
    self.myRetainStr = mStr;
    self.myStrongStr = mStr;
    NSLog(@"mStr:%p,%p",mStr,&mStr);
    NSLog(@"retainStr:%p,%p",_myRetainStr,&_myRetainStr);
    NSLog(@"strongStr:%p,%p",_myStrongStr,&_myStrongStr);
    
//    2016-08-16 10:42:56.360 Copy&MultableCopy[15372:1097934] mStr:0x7fb429fb7f00,0x7fff58110a08
//    2016-08-16 10:42:56.361 Copy&MultableCopy[15372:1097934] retainStr:0x7fb429fb7f00,0x7fb429fb5b70
//    2016-08-16 10:42:56.362 Copy&MultableCopy[15372:1097934] strongStr:0x7fb429fb7f00,0x7fb429fb5b80
    
    //从结果来看，对于NSMutableString而言,retain是增加引用计数,strong是浅复制，也是增加引用计数，没有任何区别
}






@end
