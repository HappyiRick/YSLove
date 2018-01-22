//
//  EssayCategoryModel.h
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EssayCategoryModel : NSObject

/**
    分类标题
 */
@property(nonatomic, copy)  NSString *title;
/**
 
 */
@property(nonatomic, copy)  NSString *type;
/**
    数据数组
 */
@property(nonatomic, strong)  NSArray *list;
@end
