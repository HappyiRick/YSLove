//
//  todayModel.h
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class weather_id;
@interface TodayModel : NSObject
//city = "\U82cf\U5dde";
//"comfort_index" = "";
//"date_y" = "2016\U5e7408\U670819\U65e5";
//"dressing_advice" = "\U5929\U6c14\U708e\U70ed\Uff0c\U5efa\U8bae\U7740\U77ed\U886b\U3001\U77ed\U88d9\U3001\U77ed\U88e4\U3001\U8584\U578bT\U6064\U886b\U7b49\U6e05\U51c9\U590f\U5b63\U670d\U88c5\U3002";
//"dressing_index" = "\U708e\U70ed";
//"drying_index" = "";
//"exercise_index" = "\U8f83\U4e0d\U5b9c";
//temperature = "29\U2103~37\U2103";
//"travel_index" = "\U8f83\U4e0d\U5b9c";
//"uv_index" = "\U4e2d\U7b49";
//"wash_index" = "\U4e0d\U5b9c";
//weather = "\U6674\U8f6c\U591a\U4e91";
//"weather_id" =             {
//    fa = 00;
//    fb = 01;
//};
//week = "\U661f\U671f\U4e94";
//wind = "\U5357\U98ce3-4 \U7ea7";
/**
 *  城市
 */
@property (nonatomic, copy) NSString *city;
/**
 *  日期
 */
@property (nonatomic, copy) NSString *date_y;
/**
 *  穿衣建议
 */
@property (nonatomic, copy) NSString *dressing_advice;
/**
 *  穿衣指数
 */
@property (nonatomic, copy) NSString *dressing_index;
/**
 *  运动指数
 */
@property (nonatomic, copy) NSString *exercise_index;
/**
 *  温度
 */
@property (nonatomic, copy) NSString *temperature;
/**
 *  旅游指数
 */
@property (nonatomic, copy) NSString *travel_index;
/**
 *  紫外线强度
 */
@property (nonatomic, copy) NSString *uv_index;
/**
 *  洗车指数
 */
@property (nonatomic, copy) NSString *wash_index;
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
