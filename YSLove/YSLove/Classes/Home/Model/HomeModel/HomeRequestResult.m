//
//  HomeRequestResult.m
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "HomeRequestResult.h"
#import "EssayCategoryModel.h"

@implementation HomeRequestResult
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[EssayCategoryModel class]
             };
}
@end
