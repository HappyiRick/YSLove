//
//  WeatherTool.m
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "WeatherTool.h"
#import "WeatherGetResult.h"
#import "WeatherGetParam.h"
#import "YSHttpTool.h"

@implementation WeatherTool
+(void)getWeatherWithparameter:(WeatherGetParam *)param success:(void (^)(WeatherGetResult *))success failure:(void (^)(NSError *))failure{
    [YSHttpTool getWithURL:@"http://v.juhe.cn/weather/index" parameter:param.mj_keyValues success:^(id json) {
        WeatherGetResult *result = [WeatherGetResult mj_objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
