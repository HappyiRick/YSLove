//
//  SKWeatherModel.m
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "SKWeatherModel.h"

@implementation SKWeatherModel
-(NSString *)temp{
    return [NSString stringWithFormat:@"%@℃",_temp];
}
@end
