//
//  EssayListRequestResult.h
//  YSLove
//
//  Created by zhangxin on 2017/2/25.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EssayListRequestResult : NSObject
//resultCount	Integer	20
//results	Array
//totalCount	String	1656
//pagesize	Integer	20
//totalpage	Integer	83
//nowpage	Integer	1
@property(nonatomic, assign) int resultCount;
@property(nonatomic, strong) NSArray *results;
@property(nonatomic, copy)  NSString *totalCount;
@property(nonatomic, assign) int pagesize;
@property(nonatomic, assign) int totalpage;
@property(nonatomic, assign) int nowpage;
@end
