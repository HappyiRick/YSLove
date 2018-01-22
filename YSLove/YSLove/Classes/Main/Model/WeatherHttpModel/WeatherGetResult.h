//
//  WeatherGetResult
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherModel;
@interface WeatherGetResult : NSObject
/**
 *  返回结果码
 */
@property (nonatomic, copy) NSString *resultcode;
/**
 *  原因
 */
@property (nonatomic, copy) NSString *reson;
/**
 *  错误编码
 */
@property (nonatomic, assign) int error_code;
/**
 *  数据
 */
@property (nonatomic, strong) WeatherModel *result;
@end
