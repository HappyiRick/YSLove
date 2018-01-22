//
//  SKWeatherModel.h
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKWeatherModel : NSObject
//humidity = "71%";
//temp = 32;
//time = "19:18";
//"wind_direction" = "\U4e1c\U5357\U98ce";
//"wind_strength" = "1\U7ea7";
/**
 *  当前湿度
 */
@property (nonatomic, copy) NSString *humidity;
/**
 *  温度
 */
@property (nonatomic, copy) NSString *temp;
/**
 *  风力等级
 */
@property (nonatomic, copy) NSString *wind_strength;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  风向
 */
@property (nonatomic, copy) NSString *wind_direction;
@end
