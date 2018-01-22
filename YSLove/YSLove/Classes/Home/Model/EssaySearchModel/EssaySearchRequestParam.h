//
//  EssaySearchRequestParam.h
//  YSLove
//
//  Created by zhangxin on 2017/3/16.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EssaySearchRequestParam : NSObject

@property(nonatomic, copy)  NSString *catename;
@property(nonatomic, copy)  NSString *keywords;
@property(nonatomic, assign) int p;
@property(nonatomic, assign) int pagesize;
@end
