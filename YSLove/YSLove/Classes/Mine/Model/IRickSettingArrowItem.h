//
//  IRickSettingArrowItem.h
//  IRickWeibo
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "IRickSettingItem.h"

@interface IRickSettingArrowItem : IRickSettingItem
@property (nonatomic, assign) Class destVcClass;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+(instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;
@end
