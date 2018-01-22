//
//  YSEssayClassModel.h
//  YSLove
//
//  Created by zhangxin on 2017/2/25.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSEssayClassModel : NSObject
/**
 title
 */
@property(nonatomic, copy)  NSString *title;

/**
 items
 */
@property(nonatomic, strong) NSArray *items;

@end
