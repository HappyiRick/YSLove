//
//  WeatherTool.h
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherGetParam;
@class WeatherGetResult;

@interface WeatherTool : NSObject

+(void)getWeatherWithparameter:(WeatherGetParam *)param success:(void (^)(WeatherGetResult *result))success failure:(void (^)(NSError *error))failure;
@end
