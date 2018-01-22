//
//  YSEssayClassModel.m
//  YSLove
//
//  Created by zhangxin on 2017/2/25.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSEssayClassModel.h"
#import "YSEssayClassDetailModel.h"
@implementation YSEssayClassModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"items":[YSEssayClassDetailModel class]
             };
}
@end
