//
//  UIImage+YS.m
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "UIImage+YS.h"

@implementation UIImage (YS)

+ (UIImage *)resizeImageWithName:(NSString *)name
{
    UIImage *image = [self imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
