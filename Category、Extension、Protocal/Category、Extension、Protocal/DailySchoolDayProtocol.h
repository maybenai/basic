//
//  DailySchoolDayProtocol.h
//  Category、Extension、Protocal
//
//  Created by lisonglin on 21/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DailySchoolDayProtocol <NSObject>

@required
- (void)goToClassRoom;

- (void)goToToilet;

@optional
- (void)goToCoffee;

@end
