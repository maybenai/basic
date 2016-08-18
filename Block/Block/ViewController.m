//
//  ViewController.m
//  Block
//
//  Created by lisonglin on 16/8/18.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
/**
 *  block是一种数据类型，封装代码
    函数不能在方法内部或者函数内部，但是block可以
 
 
    block的种类:
        1.无参无返回值
        2.有参有返回值
        3.有参无返回值
 
        4.作为函数参数  返回类型(^)(参数)block名
        5.作为属性     返回类型(^(block名)(参数))
        
        在block里面调用带有self字样的会造成循环利用,处理的办法:
        
        在ARC中
        
        __weak typeof(self) weakSelf = self;
 
 
        在MRC中
        
        __block type(self) weakSelf = self;
 */


@interface ViewController ()


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //无参数返回值
    [self testBlock1];
    
    //有参无返回值
    [self testBlock2];
    
    //有参有返回值
    [self testBlock3];
    
    //在block里面修改变量的值必须在变量前面加__block
    [self testBlock4];
    
    //block传值
    [self test];
    
    
    //block作为方法的参数
    [self testBlock5];
    
    

    int sum = [self test:^int(int x, int y) {
        return x + y;
    }];
    
    NSLog(@"%d",sum);
}


//block传值
- (void)test
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 120, 30);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"send" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
}

- (void)send
{
    NextViewController * next = [[NextViewController alloc] init];
    next.myBlock = ^(NSString * test){
        NSLog(@"%@",test);
    };
    [self presentViewController:next animated:YES completion:nil];
                                
}

//无参数无返回值
- (void)testBlock1
{
    void (^block)() = ^(){
        
        NSLog(@"hello");
    };
    
    block();
}


//有参无返回值
- (void)testBlock2
{
    void(^block)(NSString *) = ^(NSString * name){
        NSLog(@"name = %@",name);
    };
    
    block(@"123");
}

//有参有返回值
- (void)testBlock3
{
    int (^block)(int ,int) = ^(int x, int y){
        return x + y;
    };
    
    block(5,6);
}

//要在block里面修改外面的变量的值，必须在变量前面加__block
- (void)testBlock4
{
    __block int m = 10;
    void(^test)() = ^{
        m = 20;
        NSLog(@"%p",&m);
        NSLog(@"m = %d",m);
    };
    
    test();
}

//block作为参数
- (void)testBlock5
{
    int (^testBlock)(int a,int) = ^(int a,int b){
        return a * b;
    };
    
    [self testBlockPragram:testBlock];
    
}

- (void)testBlockPragram:(int(^)(int a, int b))block
{
    NSLog(@"%d",block(20,10));
}


- (int)test:(int (^)(int x, int y))sum
{
    return sum(30,30);
}


@end
