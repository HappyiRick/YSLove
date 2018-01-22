//
//  UIBarButtonItem+YS.h
//  LCWeibo
//
//  Created by zhangxin on 16/6/9.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YS)

/**
 *  快速创建一个导航栏上的item
 */
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action;

@end
