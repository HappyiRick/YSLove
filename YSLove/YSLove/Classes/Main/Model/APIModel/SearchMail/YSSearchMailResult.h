//
//  YSSearchMailResult.h
//  YSLove
//
//  Created by zhangxin on 2017/3/28.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSSearchMailResult : NSObject

@property(nonatomic, assign) int deliverystatus;
@property(nonatomic, assign) int issign;
@property(nonatomic, strong) NSArray *list;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *type;


@end
