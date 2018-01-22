//
//  CategoryRequestResult.m
//  YSLove
//
//  Created by zhangxin on 2017/2/25.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "CategoryRequestResult.h"
#import "YSEssayClassModel.h"

@implementation CategoryRequestResult
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"result":[YSEssayClassModel class]
             };
}
@end
