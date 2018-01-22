//
//  YSHttpTool.m
//  YSLove
//
//  Created by zhangxin on 16/10/27.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSHttpTool.h"
#import "AFNetWorking.h"
#import "YSHeaderImageData.h"

/**
用户请求头
*/
NSString *http_user_prefixURL = @"http://47.94.163.146:3000/users/";
/**
 1.用户注册路径
 */
NSString *http_user_registerURL = @"userRegister";
/**
 2.用户登录路径
 */
NSString *http_user_loginURL = @"userlogin";
/**
 3.更改密码验证密码路径
 */
NSString *http_user_checkPasswordURL = @"userCheckPassword";
/**
 4.用户更改密码路径
 */
NSString *http_user_repasswordURL = @"userrepassword";
/**
 5.用户绑定手机路径
 */
NSString *http_user_updatePhoneURL = @"userUpdatePhone";
/**
 6.用户绑定邮箱路径
 */
NSString *http_user_updateEmailURL = @"userUpdateEmail";
/**
 7.搜索用户路径
 */
NSString *http_user_searchUserURL = @"userByname";
/**
 8.用户账户注销路径
 */
NSString *http_user_deleteURL = @"userDelete";
/**
 9.用户账户注销路径
 */
NSString *http_user_updateNicknameURL = @"userUpdateUserNickname";
/**
 10.用户更新头像路径
 */
NSString *http_user_updateheaderImageURL = @"userUpdateheaderImage";
/**
 11.用户添加收藏路径
 */
NSString *http_user_saveCollectURL = @"usersaveCollect";
/**
 12.用户收藏路径
 */
NSString *http_user_searchCollectURL = @"usersearchCollect";
/**
 13.用户删除收藏路径
 */
NSString *http_user_deleteCollectURL = @"userDeleteCollect";
/**
 文章前缀
 */
NSString *http_text_prefixURL = @"http://iapi.ipadown.com/api/yangshen/";
/**
 1.首页请求文章路径
 */
NSString *http_text_homeURL = @"index.api.php";
/**
 2.文章分类请求路径
 */
NSString *http_text_categoryURL = @"left.category.api.php";
/**
 3.分类文章列表URL在上一级数据中
 4.文章详情请求路径
 */
NSString *http_text_detailURL = @"detail.show.api.php";
/**
 5.搜索文章请求路径
 */
NSString *http_text_searchURL = @"page.list.api.php";
/*
 * 极速API路径
 */
NSString *http_API_prefixURL = @"http://api.jisuapi.com/";
/*
 * 1.查询快递路径
 */
NSString *http_API_searchMailURL = @"express/query";
/*
 * 2.周公解梦路径
 */
NSString *http_API_dreamURL = @"dream/search";
/*
 * 3.星座运势路径
 */
NSString *http_API_constallationURL = @"astro/fortune";


@implementation YSHttpTool
/**
 *  发送一个post请求
 */
+(void)postWithURL:(NSString *)url parameter:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [mgr POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        debuglog(@"%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  发送一个get请求
 */
+(void)getWithURL:(NSString *)url parameter:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [mgr GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        debuglog(@"%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  发送一个post 文件请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData 照片数组
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)postHeaderImageWithURL:(NSString *)url parameters:(NSDictionary *)params formData:(YSHeaderImageData *)formData success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    // 1. 创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2. 发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalformData) {// 在发送请求之前调用这个Block
        /**
         //         *  appendPartWithFileURL   //  指定上传的文件
         //         *  name                    //  指定在服务器中获取对应文件或文本时的key
         //         *  fileName                //  指定上传文件的原始文件名
         //         *  mimeType                //  指定商家文件的MIME类型
         //         */
            [totalformData appendPartWithFileData:formData.data name:formData.name fileName:formData.fileName mimeType:formData.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
