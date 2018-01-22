//
//  UIImage+YS.m
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YS)

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizeImageWithName:(NSString *)name;

+ (UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
