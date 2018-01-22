//
//  EssayCategoryModel.m
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "EssayCategoryModel.h"
#import "EssayDetailModel.h"

@implementation EssayCategoryModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
                @"list":[EssayDetailModel class]
             };
}
@end
