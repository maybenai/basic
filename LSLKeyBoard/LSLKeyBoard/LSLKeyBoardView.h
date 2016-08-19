//
//  LSLKeyBoardView.h
//  LSLKeyBoard
//
//  Created by lisonglin on 16/8/18.
//  Copyright © 2016年 appleLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSLKeyBoardView;
@protocol keyBoardBtnClickDelegate <NSObject>

@optional
- (void)keyBoardBtnClick:(LSLKeyBoardView *)keyBoardView clickBtn:(UIButton *)sender;

@end

@interface LSLKeyBoardView : UIView

@property(nonatomic, weak) id<keyBoardBtnClickDelegate> delegate ;

@end
