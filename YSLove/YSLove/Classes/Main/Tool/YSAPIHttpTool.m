//
//  YSAPIHttpTool.m
//  YSLove
//
//  Created by zhangxin on 2017/3/28.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSAPIHttpTool.h"
#import "YSHttpTool.h"

#import "YSSearchMailAPIParam.h"
#import "YSDreamAPIParam.h"
#import "YSSearchMailAPIResult.h"
#import "YSDreamAPIResult.h"

@implementation YSAPIHttpTool
+(void)searchMailWithparameter:(YSSearchMailAPIParam *)param success:(void (^)(YSSearchMailAPIResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",http_API_prefixURL,http_API_searchMailURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        debuglog(@"%@",json);
        YSSearchMailAPIResult *result = [YSSearchMailAPIResult mj_objectWithKeyValues:json];
        if (success){
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+(void)getDreamWithparameter:(YSDreamAPIParam *)param success:(void (^)(YSDreamAPIResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",http_API_prefixURL,http_API_dreamURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        debuglog(@"dream---%@",json);
        YSDreamAPIResult *result = [YSDreamAPIResult mj_objectWithKeyValues:json];
        if (success){
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
