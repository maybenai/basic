//
//  Teacher.h
//  Category、Extension、Protocal
//
//  Created by lisonglin on 21/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DailySchoolDayProtocol.h"

#import "Student.h"

#import "HomeWorkDelegate.h"

@interface Teacher : NSObject<DailySchoolDayProtocol,HomeWorkDelegate>

//- (void)goToClassRoom;
//- (void)goToToilet;
//- (void)goToCoffee;

@property(nonatomic, weak) id<HomeWorkDelegate> delegate;

- (void)checkUpHomeWork;

@end
