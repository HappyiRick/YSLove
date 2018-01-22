//
//  UIButton+YS.m
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "UIButton+YS.h"

@implementation UIButton (YS)

/**
 快速创建按钮
 */
+(UIButton *)buttonWithBackground:(UIImage *)normalBackgroundImage highlightBackground:(UIImage *)highlightBackgroundImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton new];
    if (normalBackgroundImage != nil && highlightBackgroundImage !=nil) {
        [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:highlightBackgroundImage forState:UIControlStateHighlighted];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)circleButtonWithBackgroundCoolor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action{
    UIButton *button = [UIButton new];
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button circleView];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
