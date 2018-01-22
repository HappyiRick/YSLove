//
//  WeatherCollectionViewCell.h
//  IRickWeather
//
//  Created by zhangxin on 16/8/20.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FutureModel;
@interface YSWeatherCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (strong, nonatomic) IBOutlet UILabel *temperatureView;
@property (strong, nonatomic) IBOutlet UILabel *weatherView;
@property (strong, nonatomic) IBOutlet UILabel *weekView;
@property (strong, nonatomic) IBOutlet UILabel *windView;
@property (nonatomic, strong) FutureModel *future;
@end
