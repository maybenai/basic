//
//  GCD.h
//  GCD
//
//  Created by lisonglin on 19/07/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#ifndef GCD_h
#define GCD_h


/*
 1.GCD简介
 Grand Central Dispath 是Apple开发的一个多核编辑的较新的解决办法。它主要用于优化应用程序以支持多核处理器以及其他对称
    多处理系统。它是一个在线程池模式的基础上执行的并行任务。
 
 GCD的优点：
    GCD可用于多核的并行运算
    GCD会自动利用更多的CPU内核
    GCD会自动管理线程的生命周期(创建线程、调度任务、销毁线程)
    只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
 */

/*
 2.GCD中的任务和队列
 GCD中两个核心概念： 任务和队列
 
 任务:
    就是执行操作的意思，换句话说就是你在线程中执行的那段代码。在GCD中是放在block中的。执行任务有两种方式： 同步执行和
    异步执行。 两者的主要区别是： 是否具备看起新线程的能力。
 
    a.同步执行(sync)： 只能在当前线程中执行任务，不具备开启新线程的能力
    b.异步执行(async)：可以在新的线程中执行任务，具备开启新线程的能力
 
 队列:
    这里的队列指任务队列，即用来存放任务的队列。队列是一种特殊的线性表，采用FIFO(先进先出)的原则，即新任务总是被插入到
    队列的末尾，而读取任务的时候总是从队列的头部开始读取。每读取一个任务，则从队列中释放一个任务。在GCD中有两种队列：
    
    串行队列和并发队列
 
        并发队列：可以让多个任务并发(同时)执行(自动开启多个线程同时执行任务)    并发功能直邮在异步函数下才有效
        串行队列：让任务一个接着一个地执行(一个任务执行完毕后，再执行下一个任务)
 
 3.GCD的使用步骤
    
    a.创建一个队列(串行队列或者并发队列)
    b.将任务添加到队列中，然后系统就会根据任务类型执行任务（同步执行或异步执行）
 
 
    (1).队列的创建方法
        可以使用 dispatch_queue_create 来创建对象，需要传入两个参数，第一个参数表示队列的唯一标识符，用于DEBUG；
        第二个参数用来识别是串行队列还是并发队列。  DISPATCH_QUEUE_SERIAL表示串行队列  DISPATCH_QUEUE_CONCURRENT
        表示并行队列
        
        串行队列的创建方法:
        dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
 
        并发队列的创建方法:
        dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

        对于并发还可以用 dispatch_get_global_queue 来创建全局并发队列。GCD默认提供了全局的并发队列，需要传入两个
        参数。第一个表示队列优先级，一般用 DISPATCH_QUEUE_PRIORITY_DEFAULT 。第二个参数暂时没用，用0即可。
        dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

 
    (2).任务的创建方法
        // 同步执行任务创建方法
        dispatch_sync(queue, ^{
            NSLog(@"%@",[NSThread currentThread]);    // 这里放任务代码
        });
 
        // 异步执行任务创建方法
        dispatch_async(queue, ^{
            NSLog(@"%@",[NSThread currentThread]);    // 这里放任务代码
        });
    
                        并发队列                串行队列                    主队列
    
        同步    没有开启新线程，串行执行任务     没有开启新线程 串行执行任务     没有开启新线程 串行执行任务
        
        异步    有开启新线程 并发执行任务       有开启新线程 串行执行任务       没有开启新线程 串行执行任务
 
 
  
 
 
  4. GCD的基本使用
 
    1.并发+同步
 
 
    2.并发+异步
 
    3.串行+同步
 
    4.串行+异步
    
 
 
    主队列： GCD自带的一种特殊的串行队列
        所有放在主队列中的任务，都会放到主线程中执行
        可使用dispatch_get_main_queue()获得主队列
 
    5.主队列+同步
 
    6.主队列+异步
 

 
 
  5.GCD线程之间的通信
 
    我们一般在主线程里进行UI刷新，例如：点击、滚动、拖拽等事件。我们通常把一些耗时的操作放在其他线程，比如说图片下载、文件上传等耗时操作。
    而当我们有时候在其他线程完成了耗时操作时，需要回到主线程，那么久用到了线程之间的通讯。
 
 
 
 
  6.GCD的其他方法
     a.延时方法
     b.GCD的一次性代码(只执行一次)
     c.GCD的快速迭代方法
 
 */






#endif /* GCD_h */
