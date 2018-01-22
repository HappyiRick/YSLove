//
//  YSDreamAPIResult.m
//  YSLove
//
//  Created by zhangxin on 2017/3/29.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSDreamAPIResult.h"
#import "YSDreamContent.h"
@implementation YSDreamAPIResult

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"result":[YSDreamContent class]
             };
}
@end
