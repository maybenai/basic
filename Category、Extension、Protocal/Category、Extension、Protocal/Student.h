//
//  Student.h
//  Category、Extension、Protocal
//
//  Created by lisonglin on 21/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DailySchoolDayProtocol.h"
#import "HomeWorkDelegate.h"

@interface Student : NSObject<DailySchoolDayProtocol,HomeWorkDelegate>

//- (void)goToClassRoom;
//- (void)goToToilet;



@end
