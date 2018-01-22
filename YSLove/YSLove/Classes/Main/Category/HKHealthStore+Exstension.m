//
//  HKHealthStore+Exstension.m
//  YSLove
//
//  Created by zhangxin on 2017/3/23.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "HKHealthStore+Exstension.h"

@implementation HKHealthStore (Exstension)
-(void)ys_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion {
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        if (completion) {
            NSLog(@"results ---- > = %@",results);
            completion(results, error);
        }
    }];
    
    [self executeQuery:query];
}
@end
