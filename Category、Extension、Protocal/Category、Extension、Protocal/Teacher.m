//
//  Teacher.m
//  Category、Extension、Protocal
//
//  Created by lisonglin on 21/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher


- (void)goToToilet
{
    NSLog(@"%s",__func__);
}

- (void)goToClassRoom
{
    NSLog(@"%s",__func__);
}


- (void)goToCoffee
{
    NSLog(@"%s",__func__);
}


- (void)checkUpHomeWork
{
    
    [_delegate pickUpHomeWork];
    
    NSLog(@"%s",__func__);
}

@end
