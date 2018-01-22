//
//  YSUserHttpTool.m
//  YSLove
//
//  Created by zhangxin on 2017/3/16.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSUserHttpTool.h"
#import "YSHttpTool.h"

#import "YSCheckPasswordParam.h"
#import "YSUpdateNicknameParam.h"
#import "YSLoginParam.h"
#import "YSLoginResult.h"
#import "YSTagResult.h"
#import "YSUpdateUserEmailParam.h"
#import "YSUpdateUserPhoneParam.h"
#import "YSRepasswordParam.h"
#import "YSHeaderImageData.h"
#import "YSUpdateHeaderResult.h"
#import "YSUserCollectResult.h"
#import "YSUserDeleteCollectParam.h"

@implementation YSUserHttpTool
/**
 分组数据
 @param param 请求参数
 @param success 成功参数
 @param failure 失败参数
 */
+(void)registerWithParameter:(YSLoginParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_registerURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)loginWithParameter:(YSLoginParam *)param success:(void (^)(YSLoginResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_loginURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        NSArray *array = [NSArray mj_objectArrayWithKeyValuesArray:json];
        YSLoginResult *result = [YSLoginResult mj_objectWithKeyValues:[array firstObject]];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)checkPasswordWithParameter:(YSCheckPasswordParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_checkPasswordURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)updatePasswordWithParameter:(YSRepasswordParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_repasswordURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)updateUserEmailWithParameter:(YSUpdateUserEmailParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_updateEmailURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)updateUserPhoneWithParameter:(YSUpdateUserPhoneParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_updatePhoneURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)updateNicknameWithParameter:(YSUpdateNicknameParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_updateNicknameURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json) {
        
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)updateUserHeaderWithParameter:(YSBaseParam *)param formData:(YSHeaderImageData *)formData success:(void (^)(YSUpdateHeaderResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_updateheaderImageURL];
    [YSHttpTool postHeaderImageWithURL:requestURL parameters:param.mj_keyValues formData:formData success:^(id json) {
        YSUpdateHeaderResult *result = [YSUpdateHeaderResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)getUserCollectWithParameter:(YSBaseParam *)param success:(void (^)(YSUserCollectResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_searchCollectURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json){
        YSUserCollectResult *result = [YSUserCollectResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}

+(void)deleteUserCollectWithParameter:(YSUserDeleteCollectParam *)param success:(void (^)(YSTagResult *))success failure:(void (^)(NSError *))failure{
    NSString *requestURL= [NSString stringWithFormat:@"%@%@",http_user_prefixURL,http_user_deleteCollectURL];
    [YSHttpTool getWithURL:requestURL parameter:param.mj_keyValues success:^(id json){
        YSTagResult *result = [YSTagResult mj_objectWithKeyValues:json];
        if(success){
            success(result);
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
