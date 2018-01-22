//
//  YSSaveCollectParam.h
//  YSLove
//
//  Created by zhangxin on 2017/3/21.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSBaseParam.h"

@interface YSSaveCollectParam : YSBaseParam
/**
 简介
 */
@property(nonatomic, copy)  NSString *jianjie;
/**
 缩略图路径
 */
@property(nonatomic, copy)  NSString *thumb;
/**
 文章ID
 */
@property(nonatomic, copy)  NSString *ID;
/**
 标题
 */
@property(nonatomic, copy)  NSString *title;
/**
 发布时间
 */
@property(nonatomic, copy)  NSString *edittime;
/**
 views
 */
@property(nonatomic, copy)  NSString *views;
/**
 catename
 */
@property(nonatomic, copy)  NSString *catename;
/**
 类型
 */
@property(nonatomic, copy)  NSString *subcatename;
/**
 tags
 */
@property(nonatomic, copy)  NSString *tags;
@end
