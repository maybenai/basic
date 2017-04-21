//
//  ViewController.m
//  Category、Extension、Protocal
//
//  Created by lisonglin on 21/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "Teacher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    Teacher * teacher = [[Teacher alloc] init];
    
//    [teacher goToCoffee];
//    [teacher goToToilet];
//    [teacher goToClassRoom];
    
    Student * stu = [[Student alloc] init];

    teacher.delegate = stu;
    
     [teacher checkUpHomeWork];
    
//    Student * stu = [[Student alloc] init];

    
    
//    [stu goToClassRoom];
//    [stu goToToilet];
    
}



@end
