//
//  LockView.h
//  LockView
//
//  Created by lisonglin on 16/1/27.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LockView;

@protocol LockViewDelegate <NSObject>

@required

- (void)lockView:(LockView *)lockView didSelectedPassWord:(NSString *)passWord;

@end

@interface LockView : UIView

@property(nonatomic, weak) id<LockViewDelegate> delegate;



@end
