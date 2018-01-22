//
//  UIView+YS.m
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "UIView+YS.h"

@implementation UIView (YS)

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
    
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
    
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
    
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    
    center.x = centerX;
    
    self.center = center;
    
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    
    center.y = centerY;
    
    self.center = center;
    
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
    
}

- (void)setOrign:(CGPoint)orign {
    
    CGRect frame = self.frame;
    
    frame.origin = orign;
    
    self.frame = frame;
    
}

- (CGFloat)X {
    
    return self.frame.origin.x;
}

- (CGFloat)Y {
    
    return self.frame.origin.y;
    
}

- (CGFloat)Width {
    
    return self.frame.size.width;
    
}

- (CGFloat)Height {
    
    return self.frame.size.height;
    
}

- (CGSize)size {
    
    return self.frame.size;
    
}

- (CGPoint)orign {
    
    return self.frame.origin;
    
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)circleView {
    
    self.layer.cornerRadius = self.Width / 2;
    self.layer.masksToBounds = YES;
}

- (CGFloat)top {
    return self.Y;
}

- (void)setTop:(CGFloat)top {
    self.Y = top;
}

- (CGFloat)left {
    return self.X;
}

- (void)setLeft:(CGFloat)left {
    self.X = left;
}

- (CGFloat)bottom {
    return self.Height + self.Y;
}

- (void)setBottom:(CGFloat)bottom {
    self.Y = bottom - self.Height;
}

- (CGFloat)right {
    return self.Width + self.X;
}

- (void)setRight:(CGFloat)right {
    self.X = right - self.Width;
}

-(void)setShadowWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
}

@end
