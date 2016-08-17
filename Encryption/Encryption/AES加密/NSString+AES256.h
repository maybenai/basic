//
//  NSString+AES256.h
//  Encryption
//
//  Created by lisonglin on 16/8/17.
//  Copyright © 2016年 appleLi. All rights reserved.
//  NSString的加密解密

#import <Foundation/Foundation.h>

@interface NSString (AES256)

/**
 *  加密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)aes256_encrypt:(NSString *)key;
/**
 *  解密
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)aes256_decrypt:(NSString *)key;
@end
