//
//  YSAPIHttpTool.h
//  YSLove
//
//  Created by zhangxin on 2017/3/28.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSSearchMailAPIParam;
@class YSDreamAPIParam;
@class YSSearchMailAPIResult;
@class YSDreamAPIResult;
@interface YSAPIHttpTool : NSObject
+(void)searchMailWithparameter:(YSSearchMailAPIParam *)param success:(void (^)(YSSearchMailAPIResult *result))success failure:(void (^)(NSError *error))failure;

+(void)getDreamWithparameter:(YSDreamAPIParam *)param success:(void (^)(YSDreamAPIResult *result))success failure:(void (^)(NSError *error))failure;

@end
