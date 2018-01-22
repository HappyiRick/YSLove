//
//  WeatherGetParam
//  IRickWeather
//
//  Created by zhangxin on 16/8/19.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherGetParam : NSObject
/**
 *  城市名
 */
@property (nonatomic, copy) NSString *cityname;
/**
 * shuju
 */
@property (nonatomic, copy) NSString *dtype;
/**
 *  未来6天预报
 */
@property (nonatomic, assign) int format;
/**
 *  接口密钥
 */
@property (nonatomic, copy) NSString *key;
@end
