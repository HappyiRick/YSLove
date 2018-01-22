//
//  DateWeahterModel.m
//  IRickWeather
//
//  Created by zhangxin on 16/8/19.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "FutureModel.h"

@implementation FutureModel
-(NSString *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSDate *today = [fmt dateFromString:_date];
    fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt stringFromDate:today];
}
@end
