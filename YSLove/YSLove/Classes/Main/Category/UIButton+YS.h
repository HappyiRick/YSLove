//
//  UIButton+YS.h
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YS)
/**
 *  快速创建一个按钮
 */
+(UIButton *)buttonWithBackground:(UIImage *)normalBackgroundImage highlightBackground:(UIImage *)highlightBackgroundImage target:(id)target action:(SEL)action;

/**
 快速创建一个圆形按钮
 */
+(UIButton *)circleButtonWithBackgroundCoolor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
@end
