//
//  DateWeahterModel.h
//  IRickWeather
//
//  Created by zhangxin on 16/8/19.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class weather_id;
@interface FutureModel : NSObject
//"day_20160819" =             {
//    date = 20160819;
//    temperature = "29\U2103~37\U2103";
//    weather = "\U6674\U8f6c\U591a\U4e91";
//    "weather_id" =                 {
//        fa = 00;
//        fb = 01;
//    };
//    week = "\U661f\U671f\U4e94";
//    wind = "\U5357\U98ce3-4 \U7ea7";
//};
/**
 *  日期
 */
@property (nonatomic, copy) NSString *date;
/**
 *  温度
 */
@property (nonatomic, copy) NSString *temperature;
/**
 *  天气
 */
@property (nonatomic, copy) NSString *weather;
/**
 *  星期
 */
@property (nonatomic, copy) NSString *week;
/**
 *  风力
 */
@property (nonatomic, copy) NSString *wind;
/**
 天气代码
 */
@property(nonatomic, strong) weather_id *weather_id;
@end
