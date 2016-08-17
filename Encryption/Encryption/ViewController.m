//
//  ViewController.m
//  Encryption
//
//  Created by lisonglin on 16/8/17.
//  Copyright © 2016年 appleLi. All rights reserved.
//  各种加密方法

#import "ViewController.h"

#import "NSString+AES256.h"

#import "NSString+MD5.h"

@interface ViewController ()

@property(nonatomic, copy) NSString * string;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testNSStringEncrypt];
//    [self testNSStringDecrypt];
    
    [self testMD5];
    
}


- (void)testMD5
{
    NSString * str = @"123";
    NSString * md5_str = [NSString md5:str];
    
    NSLog(@"%@",md5_str);
}

- (void)testNSStringEncrypt
{
    NSString * str = @"lsl";
 
    NSString * encrypt = [str aes256_encrypt:@"123"];
    self.string = encrypt;
    NSLog(@"%@",encrypt);
}


- (void)testNSStringDecrypt
{
    NSString * str = [self.string aes256_decrypt:@"123"];
    
    NSLog(@"%@",str);
}



@end
