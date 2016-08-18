//
//  NextViewController.h
//  Block
//
//  Created by lisonglin on 16/8/18.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^MyBlock)(NSString *text);
@interface NextViewController : UIViewController

/*
    block作为属性的语法:    返回值(^block名)(参数);
 */
/**
 *  block属性
 */
@property(nonatomic, assign) void (^myBlock)(NSString *text);


@end
