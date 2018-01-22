//
//  HomeHttpTool.h
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeRequestParam;
@class HomeRequestResult;
@class EssaySearchRequestParam;
@class CategoryRequestParam;
@class CategoryRequestResult;
@class YSSaveCollectParam;
@class YSTagResult;
@interface HomeHttpTool : NSObject
/**
    首页数据
    @param param 请求参数
    @param success 成功参数
    @param failure 失败参数
 */
+(void)getHomeDataWithParameter:(HomeRequestParam *)param  success:(void (^)(HomeRequestResult *result))success failure:(void (^)(NSError *error))failure;
/**
    分组数据
    @param param 请求参数
    @param success 成功参数
    @param failure 失败参数
 */
+(void)getCategoryDataWithParameter:(CategoryRequestParam *)param  success:(void (^)(CategoryRequestResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)saveCollectDataWithParameter:(YSSaveCollectParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
@end
