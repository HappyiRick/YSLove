//
//  UIView+YS.m
//  YSLove
//
//  Created by zhangxin on 2017/2/22.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YS)

@property (nonatomic, assign) CGFloat X;
@property (nonatomic, assign) CGFloat Y;
@property (nonatomic, assign) CGFloat Width;
@property (nonatomic, assign) CGFloat Height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint orign;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;

- (void)setSize:(CGSize)size;
- (void)setOrign:(CGPoint)orign;

- (void)circleView;

- (void)setShadowWithColor:(UIColor *)color offset:(CGSize)size  opacity:(CGFloat)opacity;

@end
