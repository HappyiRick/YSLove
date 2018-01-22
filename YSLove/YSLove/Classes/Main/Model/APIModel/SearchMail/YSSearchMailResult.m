//
//  YSSearchMailResult.m
//  YSLove
//
//  Created by zhangxin on 2017/3/28.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSSearchMailResult.h"
#import "YSMailStaus.h"

@implementation YSSearchMailResult
+(NSDictionary *)mj_objectClassInArray{
    return @{
                @"list":[YSMailStaus class]
             };
}
@end
