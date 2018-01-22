//
//  HKHealthStore+Exstension.h
//  YSLove
//
//  Created by zhangxin on 2017/3/23.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <HealthKit/HealthKit.h>

@interface HKHealthStore (Exstension)
-(void)ys_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion;
@end
