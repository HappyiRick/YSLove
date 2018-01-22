//
//  YSBaseAPIParam.m
//  YSLove
//
//  Created by zhangxin on 2017/3/28.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSBaseAPIParam.h"

@implementation YSBaseAPIParam

+(instancetype)param{
    return [[self alloc] init];
}

-(NSString *)appkey{
    return myAppkey;
}
@end
