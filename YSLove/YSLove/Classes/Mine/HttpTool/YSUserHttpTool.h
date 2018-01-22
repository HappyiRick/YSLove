//
//  YSUserHttpTool.h
//  YSLove
//
//  Created by zhangxin on 2017/3/16.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSBaseParam;
@class YSLoginParam;
@class YSLoginResult;
@class YSTagResult;
@class YSRepasswordParam;
@class YSCheckPasswordParam;
@class YSUpdateNicknameParam;
@class YSUpdateUserEmailParam;
@class YSUpdateUserPhoneParam;
@class YSHeaderImageData;
@class YSUpdateHeaderResult;
@class YSUserCollectResult;
@class YSUserDeleteCollectParam;
@interface YSUserHttpTool : NSObject
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)registerWithParameter:(YSLoginParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)loginWithParameter:(YSLoginParam *)param  success:(void (^)(YSLoginResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)checkPasswordWithParameter:(YSCheckPasswordParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)updatePasswordWithParameter:(YSRepasswordParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)updateUserPhoneWithParameter:(YSUpdateUserPhoneParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)updateUserEmailWithParameter:(YSUpdateUserEmailParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)updateNicknameWithParameter:(YSUpdateNicknameParam *)param  success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;

/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)updateUserHeaderWithParameter:(YSBaseParam *)param  formData:(YSHeaderImageData *)formData success:(void (^)(YSUpdateHeaderResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)getUserCollectWithParameter:(YSBaseParam *)param success:(void (^)(YSUserCollectResult *result))success failure:(void (^)(NSError *error))failure;
/**
 首页数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)deleteUserCollectWithParameter:(YSUserDeleteCollectParam *)param success:(void (^)(YSTagResult *result))success failure:(void (^)(NSError *error))failure;
@end
