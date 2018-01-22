//
//  YSSettingGroup.h
//  YSLove
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSSettingGroup : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSArray *items;

+(instancetype)group;
@end
