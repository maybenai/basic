//
//  ViewController.m
//  LSLKeyBoard
//
//  Created by lisonglin on 16/8/18.
//  Copyright © 2016年 appleLi. All rights reserved.
//  Custorm Number KeyBoard

#import "ViewController.h"

#import "LSLKeyBoardView.h"

@interface ViewController ()<keyBoardBtnClickDelegate>

@property(nonatomic, strong) UITextField * textField ;

@property(nonatomic, weak) LSLKeyBoardView * keyBoardView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialize];
    
    //注册键盘通知
    //键盘将要显示出来
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

//初始化
- (void)initialize
{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [self.view addSubview:self.textField];
    self.textField.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    self.textField.layer.cornerRadius = 5;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.placeholder = @"请输入数字";
    self.textField.layer.borderWidth = 0.5;
    self.textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //让键盘自动弹出
    [self.textField becomeFirstResponder];
    
    //关闭键盘联想功能
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;

    
    //自定义键盘
    LSLKeyBoardView * keyBoardView = [[LSLKeyBoardView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),216)];
    self.keyBoardView = keyBoardView;
    keyBoardView.delegate = self;
    keyBoardView.backgroundColor = [UIColor lightGrayColor];
    self.textField.inputView = keyBoardView;
    
    //给键盘添加工具条
//    UIView * keyBoardToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
//    keyBoardToolBar.backgroundColor = [UIColor lightGrayColor];
//    //将工具条加到键盘上面
//    self.textField.inputAccessoryView = keyBoardToolBar;
    
}


#pragma mark  keyBoardBtnClickDelegate--=========================================
- (void)keyBoardBtnClick:(LSLKeyBoardView *)keyBoardView clickBtn:(UIButton *)sender
{
        if (sender.tag == 3) {//删除按钮,每次都删除最后一位
            if (self.textField.text.length > 0) {
                
                self.textField.text = [self.textField.text substringWithRange:NSMakeRange(0 , self.textField.text.length - 1)];
            }else{
                return;
            }
        }else if (sender.tag == 11){//完成按钮
            [self.view endEditing:YES];
        }else{//其余数字按钮
            self.textField.text = [self.textField.text stringByAppendingString:sender.titleLabel.text];
        }
}




//键盘显示
- (void)keyBoardShow:(NSNotification *)notification
{
    
    //获取键盘的高度
    NSDictionary * userInfo = notification.userInfo;
    
    CGRect rect = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
}

//键盘隐藏
- (void)keyBoardHidden:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





@end
