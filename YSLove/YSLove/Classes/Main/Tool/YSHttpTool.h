//
//  YSHttpTool.h
//  YSLove
//
//  Created by zhangxin on 16/10/27.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSHeaderImageData;

/**
    用户请求头
 */
FOUNDATION_EXPORT NSString *http_user_prefixURL;
/**
    1.用户注册路径
 */
FOUNDATION_EXPORT NSString *http_user_registerURL;
/**
    2.用户登录路径
 */
FOUNDATION_EXPORT NSString *http_user_loginURL;
/**
    3.更改密码验证密码路径
 */
FOUNDATION_EXPORT NSString *http_user_checkPasswordURL;
/**
    4.用户更改密码路径
 */
FOUNDATION_EXPORT NSString *http_user_repasswordURL;
/**
    5.用户绑定手机路径
 */
FOUNDATION_EXPORT NSString *http_user_updatePhoneURL;
/**
    6.用户绑定邮箱路径
 */
FOUNDATION_EXPORT NSString *http_user_updateEmailURL;
/**
    7.搜索用户路径
 */
FOUNDATION_EXPORT NSString *http_user_searchUserURL;
/**
    8.用户账户删除路径
 */
FOUNDATION_EXPORT NSString *http_user_deleteURL;
/**
    9.用户更改昵称路径
 */
FOUNDATION_EXPORT NSString *http_user_updateNicknameURL;
/**
 10.用户更改昵称路径
 */
FOUNDATION_EXPORT NSString *http_user_updateheaderImageURL;
/**
 11.用户添加收藏路径
 */
FOUNDATION_EXPORT NSString *http_user_saveCollectURL;
/**
 12.用户收藏路径
 */
FOUNDATION_EXPORT NSString *http_user_searchCollectURL;
/**
 13.用户删除收藏路径
 */
FOUNDATION_EXPORT NSString *http_user_deleteCollectURL;
/**
    文章前缀
 */
FOUNDATION_EXPORT NSString *http_text_prefixURL;
/**
    1.首页请求文章路径
 */
FOUNDATION_EXPORT NSString *http_text_homeURL;
/**
    2.文章分类请求路径
 */
FOUNDATION_EXPORT NSString *http_text_categoryURL;
/**
    3.分类文章列表URL在上一级数据中
    4.文章详情请求路径
 */
FOUNDATION_EXPORT NSString *http_text_detailURL;
/**
    5.搜索文章请求路径
 */
FOUNDATION_EXPORT NSString *http_text_searchURL;
/*
 * 极速API路径
 */
FOUNDATION_EXPORT NSString *http_API_prefixURL;
/*
 * 查询快递路径
 */
FOUNDATION_EXPORT NSString *http_API_searchMailURL;
/*
 * 周公解梦路径
 */
FOUNDATION_EXPORT NSString *http_API_dreamURL;
/*
 * 星座运势路径
 */
FOUNDATION_EXPORT NSString *http_API_constallationURL;

@interface YSHttpTool : NSObject
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param param  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)postWithURL:(NSString *)url parameter:(NSDictionary *)param  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param param  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)getWithURL:(NSString *)url parameter:(NSDictionary *)param  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个post 文件请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData 照片数组
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)postHeaderImageWithURL:(NSString *)url parameters:(NSDictionary *)params formData:(YSHeaderImageData *)formData success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
