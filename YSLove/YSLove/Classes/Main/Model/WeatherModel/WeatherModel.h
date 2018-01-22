//
//  WeatherModel.h
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TodayModel;
@class SKWeatherModel;
@interface WeatherModel : NSObject
/**
 *  实况
 */
@property (nonatomic, strong) SKWeatherModel *sk;
/**
 *  今日天气
 */
@property (nonatomic, strong) TodayModel *today;
/**
 *  未来几日的天气
 */
@property (nonatomic, strong) NSArray *future;
@end
