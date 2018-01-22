//
//  YSUserCollectResult.m
//  YSLove
//
//  Created by zhangxin on 2017/3/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSUserCollectResult.h"

#import "EssayDetailModel.h"
@implementation YSUserCollectResult

+(NSDictionary *)mj_objectClassInArray{
    return @{
                @"datas":[EssayDetailModel class]
             };
}
@end
