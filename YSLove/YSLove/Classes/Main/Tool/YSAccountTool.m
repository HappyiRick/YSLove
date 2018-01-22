//
//  YSAccountTool.m
//  YSLove
//
//  Created by zhangxin on 2017/3/16.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSAccountTool.h"
#import "YSLoginResult.h"

#define LCAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"account.data"]
@implementation YSAccountTool
+(void)savaAccount:(YSLoginResult *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:LCAccountFile];
}

+(YSLoginResult *)account
{
    // 取出帐号
    YSLoginResult *account = [NSKeyedUnarchiver unarchiveObjectWithFile:LCAccountFile];
    return account;
}

+(void)exit{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:LCAccountFile error:nil];
}
@end
