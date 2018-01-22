//
//  EssayListRequestResult.m
//  YSLove
//
//  Created by zhangxin on 2017/2/25.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "EssayListRequestResult.h"
#import "EssayDetailModel.h"

@implementation EssayListRequestResult

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"results":[EssayDetailModel class]
             };
}
@end
