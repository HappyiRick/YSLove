//
//  YSAccountTool.h
//  YSLove
//
//  Created by zhangxin on 2017/3/16.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSLoginResult;
@interface YSAccountTool : NSObject
/**
 *  存储帐号信息
 
 *  @param account 需要存储的帐号
 */
+(void)savaAccount:(YSLoginResult *)account;

/**
 *  返回存储的帐号信息
 */
+(YSLoginResult *)account;
/**
 *  注销
 */
+(void)exit;
@end
