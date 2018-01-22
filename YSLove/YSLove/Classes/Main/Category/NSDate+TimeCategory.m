//
//  NSDate+TimeCategory.m
//  LvChengApp
//
//  Created by zhangxin on 16/9/15.
//  Copyright © 2016年 zhisolution. All rights reserved.
//

#import "NSDate+TimeCategory.h"


static NSDateFormatter *dateFormatter;

@implementation NSDate (TimeCategory)
+(NSDateFormatter *)defaultFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
    });
    return dateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDate defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

+ (NSInteger)cTimestampFromDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}


+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    return [NSDate cTimestampFromDate:date];
}

+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format
{
    NSString *timeStr = [NSString stringWithFormat:@"%li",(long)timeStamp];
    if (timeStr.length > 10) {
        timeStr = [timeStr substringToIndex:10];
    }
    timeStamp = [timeStr doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate datestrFromDate:date withDateFormat:format];
}

+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter* dateFormat = [NSDate defaultFormatter];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

+ (NSString *)restTimeToNowWithStampTime:(NSString *)stampTime {
    
    NSString *nowStampTime = [NSString stringWithFormat:@"%lf", [[NSDate date] timeIntervalSince1970] * 1000];
    int restSeconds = ([stampTime doubleValue] - [nowStampTime doubleValue]) / 1000;
    
    NSString *restTimeString;
    if (restSeconds > 0) {
        
        if (restSeconds < 60) {
            
            restTimeString = [NSString stringWithFormat:@"还剩%d秒", restSeconds];
        } else if (restSeconds >= 60 && restSeconds < 3600) {
            
            int restMinutes  = restSeconds / 60;
            int otherSeconds = restSeconds % 60;
            restTimeString   = [NSString stringWithFormat:@"还剩%d分%d秒", restMinutes, otherSeconds];
        } else if (restSeconds >= 3600 && restSeconds < 86400) {
            
            int restMinutes  = restSeconds / 60;
            int restHours    = restMinutes / 60;
            int otherMinutes = restMinutes % 60;
            restTimeString   = [NSString stringWithFormat:@"还剩%d时%d分", restHours, otherMinutes];
        } else if (restSeconds >= 86400) {
            
            int restMinutes  = restSeconds / 60;
            int restHours    = restMinutes / 60;
            int restDays     = restHours   / 24;
            int otherHours   = restHours   % 24;
            restTimeString   = [NSString stringWithFormat:@"还剩%d天%d时", restDays, otherHours];
        }
    } else {
        
        restTimeString = @"已结束";
    }
    
    return restTimeString;
}

+ (NSString *)timeBetweenStampTime:(NSString *)stampTime afterStampTime:(NSString *)afterStampTime {
    
    int restSeconds = ([afterStampTime doubleValue] - [stampTime doubleValue]) / 1000;
    
    NSString *restTimeString;
    if (restSeconds > 0) {
        
        if (restSeconds < 60) {
            
            restTimeString = [NSString stringWithFormat:@"%d秒", restSeconds];
        } else if (restSeconds >= 60 && restSeconds < 3600) {
            
            int restMinutes  = restSeconds / 60;
            int otherSeconds = restSeconds % 60;
            restTimeString   = [NSString stringWithFormat:@"%d分%d秒", restMinutes, otherSeconds];
        } else if (restSeconds >= 3600 && restSeconds < 86400) {
            
            int restMinutes  = restSeconds / 60;
            int restHours    = restMinutes / 60;
            int otherMinutes = restMinutes % 60;
            restTimeString   = [NSString stringWithFormat:@"%d时%d分", restHours, otherMinutes];
        } else if (restSeconds >= 86400) {
            
            int restMinutes  = restSeconds / 60;
            int restHours    = restMinutes / 60;
            int restDays     = restHours   / 24;
            int otherHours   = restHours   % 24;
            restTimeString   = [NSString stringWithFormat:@"%d天%d时", restDays, otherHours];
        }
    } else {
        
        restTimeString = @"－－";
    }
    
    return restTimeString;
}

@end
