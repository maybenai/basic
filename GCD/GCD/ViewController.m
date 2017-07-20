//
//  ViewController.m
//  GCD
//
//  Created by lisonglin on 19/07/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //并发队列+同步执行
//    [self syncConcurrent];
    
    
    //并发+异步
//    [self asyncConcurrent];
    
    
    //串行+同步
//    [self syncSerial];
    
    //串行+异步
//    [self asyncSerial];
    
    //主队列+同步
//    [self syncMain];
    
    //主队列+异步
//    [self asyncMain];
    
    
    
    //线程之间通信
//    [self communicateThread];
    
    
    //延时方法
    [self afterTime];
    
//    GCD的一次性代码(只执行一次)
    [self once];
    
//    GCD的快速迭代方法
    [self quickApply];
    
}



#pragma mark -- 并发队列+同步执行
/*
 从结果看:  1.所有任务都是在主线程中执行的。由于只有一个线程，所以任务只能一个一个的执行
           2.所有任务都在打印 syncConcurrent ------ begin 和 syncConcurrent ------ end 之间，这说明任务是添加到
                队列中马上执行的
 */

- (void) syncConcurrent {
    
    NSLog(@"syncConcurrent ------ begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"1---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"2----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"3---------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncConcurrent ------ end");
    
}

#pragma mark -- 并发+异步
/*
 从结果看： 1.除了主线程，又开启了3个线程，并且任务是交替着同时执行的。
          2.所有任务是在打印 syncConcurrent ------ begin 和 syncConcurrent ------ end之后才开始执行的，
            说明任务不是马上执行，而是将所有任务添加到队列之后才开始异步执行
 */
- (void) asyncConcurrent {
    NSLog(@"syncConcurrent ------ begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"1---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"2----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"3---------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncConcurrent ------ end");

}



#pragma mark -- 串行+同步
/*
 从结果看： 1.所有任务都是在主线程中执行的，并没有开启新的线程。而且由于串行队列，所有按顺序一个一个执行
          2.所有任务都在打印的 syncSerial---begin 和 syncSerial---end 之间，这说明任务是添加到队列马上执行的。
 */
- (void) syncSerial {
    NSLog(@"syncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"1----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"2----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"3----------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncSerial---end");
}


#pragma mark -- 串行+异步
/*
 从结果看，1.开启了一条新线程，但是任务还是串行，所以任务是一个一个执行。
         2.所有任务都在 asyncSerial---begin 和 asyncSerial---end 之后开始执行的。说明任务不是马上执行，而是将
            所有任务添加到队列之后才开始同步执行。
 */
- (void) asyncSerial {
    NSLog(@"asyncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"1----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"2----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"3----------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncSerial---end");
}

#pragma mark -- 主队列+同步
/*
 从结果看，任务不再执行了，而且 syncMain------end也没有打印。
 
        这是因为我们在主线程中执行这段代码。我们把任务放倒了主队列中，也就是放倒了主线程的队列中。而同步执行有个特点，就是对于任务是立马执行
        的。那么当我们把第一个任务放进主队列中，它就会立马执行。但是主线程现在正在处理syncMain方法，所以任务需要等syncMain执行完才执行。
        而syncMain执行到第一个任务的时候，又要等第一个任务执行完之后才能往下执行第二个和第三个任务。
        
        那么，现在的情况是syncMain方法和第一个任务都在等对方执行完毕，这样互相等待，所有就执行不了。
 */
- (void)syncMain {
    NSLog(@"syncMain------begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"1---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"2---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"3---------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncMain------end");
}

#pragma mark -- 主队列+异步
/*
 从结果看出，所有的任务都在主线程中，虽然是异步执行有开辟新线程的能力，但是因为是主队列，所以所有任务都在主线程中，并且一个接一个执行。
            另一方面看出，所有任务是在打印 asyncMain------begin 和 asyncMain------end 之后才开始执行的。说明任务不是马上执行，
            而是将所有任务添加到队列之后才开始同步执行。
 */
- (void)asyncMain {
    NSLog(@"asyncMain------begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"1---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"2---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            NSLog(@"3---------%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMain------end");
}


#pragma mark -- 线程之间通信
/*
 从结果看，可以看到在其他线程中先执行操作，执行完了之后回到主线程执行主线程的相应操作
 */
- (void)communicateThread {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2;  ++ i) {
            NSLog(@"1------------%@",[NSThread currentThread]);
        }
    });
    
    //回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2----------%@",[NSThread currentThread]);
    });
}

#pragma mark -- 延时方法
- (void) afterTime {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //2s后异步执行这里的代码
        NSLog(@"run------");
    });
}

#pragma mark -- GCD的一次性代码(只执行一次)
- (void) once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //只执行1次的代码(默认线程安全)
    });
}

#pragma mark --  GCD的快速迭代方法
- (void) quickApply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---------%@",index, [NSThread currentThread]);
    });
}



@end
