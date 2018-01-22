//
//  WeatherModel.m
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "WeatherModel.h"
#import "FutureModel.h"

@implementation WeatherModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"future" : [FutureModel class]};
}
@end
