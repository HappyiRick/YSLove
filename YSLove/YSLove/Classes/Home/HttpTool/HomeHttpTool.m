//
//  HomeHttpTool.m
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "HomeHttpTool.h"
#import "YSHttpTool.h"
#import "HomeRequestParam.h"
#import "HomeRequestResult.h"
#import "EssayCategoryModel.h"
#import "EssayDetailModel.h"
#import "YSEssayClassModel.h"
#import "YSEssayClassDetailModel.h"
#import "CategoryRequestParam.h"
#import "CategoryRequestResult.h"
#import "EssaySearchRequestParam.h"
#import "YSSaveCollectParam.h"
#import "YSTagResult.h"

@implementation HomeHttpTool
/**
    首页数据
    @param param 请求参数
    @param success 成功参数
    @param failure 失败参数
 */
+(void)getHomeDataWithParameter:(HomeRequestParam *)param success:(void (^)(HomeRequestResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",http_text_prefixURL,http_text_homeURL];
    
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        HomeRequestResult *result = [HomeRequestResult mj_objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
    分组数据
    @param param 请求参数
    @param success 成功参数
    @param failure 失败参数
 */
+(void)getCategoryDataWithParameter:(CategoryRequestParam *)param success:(void (^)(CategoryRequestResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_text_prefixURL,http_text_categoryURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        CategoryRequestResult *result = [CategoryRequestResult new];
        result.result = [NSArray mj_objectArrayWithKeyValuesArray:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}



+(void)saveCollectDataWithParameter:(YSSaveCollectParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_saveCollectURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
