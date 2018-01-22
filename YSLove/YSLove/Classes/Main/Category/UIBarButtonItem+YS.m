//
//  UIBarButtonItem+YS.m
//  LCWeibo
//
//  Created by zhangxin on 16/6/9.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "UIBarButtonItem+YS.h"

@implementation UIBarButtonItem (YS)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action{
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [itemBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [itemBtn setImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    itemBtn.frame = (CGRect){CGPointMake(0, 0),itemBtn.currentBackgroundImage.size};
    itemBtn.size = itemBtn.currentImage.size;
    itemBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    return [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
}
@end
