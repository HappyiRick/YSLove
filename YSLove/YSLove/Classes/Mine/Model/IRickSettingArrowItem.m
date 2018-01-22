//
//  IRickSettingArrowItem.m
//  IRickWeibo
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "IRickSettingArrowItem.h"

@implementation IRickSettingArrowItem
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass{
    IRickSettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
@end

