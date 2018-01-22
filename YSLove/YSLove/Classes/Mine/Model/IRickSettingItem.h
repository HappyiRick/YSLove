//
//  IRickSettingItem.h
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^IRickSettingItemOperation)();

@interface IRickSettingItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, copy)  IRickSettingItemOperation operation;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+(instancetype)itemWithTitle:(NSString *)title;
+(instancetype)item;
@end
