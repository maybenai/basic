//
//  NSData+AES256.h
//  Encryption
//
//  Created by lisonglin on 16/8/17.
//  Copyright © 2016年 appleLi. All rights reserved.
//  NSData的加密解密

#import <Foundation/Foundation.h>

@interface NSData (AES256)

/**
 *  加密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSData *)aes256_encrypt:(NSString *)key;

/**
 *  解密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSData *)aes256_decrypt:(NSString *)key;

@end
