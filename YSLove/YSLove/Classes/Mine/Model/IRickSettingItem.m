//
//  IRickSettingItem.m
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "IRickSettingItem.h"

@implementation IRickSettingItem
+(instancetype)item{
    return [self new];
}

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    IRickSettingItem *item = [self item];
    item.icon =  icon;
    item.title = title;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithIcon:nil title:title];
}
@end
