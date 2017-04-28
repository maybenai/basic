//
//  LSCityChooseView.h
//  LSCityChoose
//
//  Created by lisonglin on 26/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedHandle)(NSString * province, NSString * city, NSString * area);

@interface LSCityChooseView : UIView

@property(nonatomic, copy) SelectedHandle selectedBlock;

@end
