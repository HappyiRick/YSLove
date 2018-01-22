//
//  YSSearchMailAPIResult.h
//  YSLove
//
//  Created by zhangxin on 2017/3/28.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSBaseAPIResult.h"

@class YSSearchMailResult;

@interface YSSearchMailAPIResult : YSBaseAPIResult

@property(nonatomic, strong) YSSearchMailResult *result;
@end
