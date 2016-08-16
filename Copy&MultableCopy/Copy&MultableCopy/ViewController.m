//
//  ViewController.m
//  Copy&MultableCopy
//
//  Created by lisonglin on 16/8/16.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
/**
 *  1.__NSArrayI是NSArray的真正类型
 *  2.__NSArrayM是NSMutableArray的真正类型
 */


- (void)viewDidLoad {
    [super viewDidLoad];

//    [self test1];
//    [self test2];
}

- (void)test1
{
    //移可辨的NSMutableArray作为对象源
    NSMutableArray * arrayM = [NSMutableArray arrayWithObjects:@"copy",@"mutabltCopy", nil];
    
    NSLog(@"内容:%@ 对象地址:%p,对象所属类:%@",arrayM,arrayM,arrayM.class);
    
    //通过copy复制可变对象。地址改变，结果为一个不可变对象
    NSMutableArray * array1 = [arrayM copy];
    NSLog(@"内容:%@ 对象地址:%p,对象所属类:%@",array1,array1,array1.class);

    //通过mutableCopy复制可变对象。地址改变，结果为可变对象
    NSMutableArray * array2 = [arrayM mutableCopy];
    NSLog(@"内容:%@ 对象地址:%p,对象所属类:%@",array2,array2,array2.class);
    
    /**
     *  通过copy复制一个不可变对象。结果为不可变对象。
     */
    NSArray *array3 = [arrayM copy];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array3,array3,array3.class);
    
    /**
     *  将mutableCopy复制一个不可变对象。生成一个可变对象
     */
    NSArray *array4 = [arrayM mutableCopy];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array4,array4,array4.class);
    
    NSLog(@"------------------------------------");
    [arrayM addObject:@"test"];
    
    
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",arrayM,arrayM,arrayM.class);
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array1,array1,array1.class);
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array2,array2,array2.class);
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array3,array3,array3.class);
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array4,array4,array4.class);
}

-(void)test2{
    // 以不可变的NSArray作为对象源
    NSArray  *arrayM = [NSArray arrayWithObjects:@"copy",@"mutableCopy",nil];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",arrayM,arrayM,arrayM.class);
    
    // 将对象源copy到可变对象
    NSMutableArray *array1 = [arrayM copy];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array1,array1,array1.class);
    
    // 将对象源mutableCopy到可变对象
    NSMutableArray *array2 = [arrayM mutableCopy];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array2,array2,array2.class);
    
    // 将对象源copy到不可变对象
    NSArray *array3 = [arrayM copy];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array3,array3,array3.class);
    
    // 将对象源mutablCopy到不可变对象
    NSArray *array4 = [arrayM mutableCopy];
    NSLog(@"内容：%@ 对象地址：%p 对象所属类：%@",array4,array4,array4.class);
}
@end
