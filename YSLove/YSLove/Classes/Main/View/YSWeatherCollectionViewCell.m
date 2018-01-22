//
//  WeatherCollectionViewCell.m
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSWeatherCollectionViewCell.h"
#import "FutureModel.h"
#import "weather_id.h"

@implementation YSWeatherCollectionViewCell


-(void)setFuture:(FutureModel *)future{
    _future = future;
    NSString *imageName = @"weather_cloud";
    switch (future.weather_id.fb) {
        case 00:
            imageName = @"weather_sun";
            break;
        case 1:
            imageName = @"weather_sunTocloud";
            break;
        case 2:
            imageName = @"weather_cloud";
            break;
        case 7:
            imageName = @"weather_rain";
            break;
        case 14:
            imageName = @"weather_snow";
            break;
        case 53:
            imageName = @"weather_morecloud";
            break;
        default:
            break;
    }
    self.weatherImage.image = [UIImage imageNamed:imageName];
    self.dateView.text = future.date;
    self.temperatureView.text = future.temperature;
    self.weatherView.text = future.weather;
    self.windView.text = future.wind;
    self.weekView.text = future.week;
}

@end
