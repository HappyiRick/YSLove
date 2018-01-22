//
//  YSTabBarButton.m
//  YSLove
//
//  Created by zhangxin on 2017/2/20.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSTabBarButton.h"

//文字颜色
#define titleColor YSColor(136,136,136,1)
//选中文字颜色
#define titleSelectedColor YSColor(255,28,51,1)

@implementation YSTabBarButton
// 按钮图文比例
float tabBarButtonImageRadio = 0.6 ;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    }
    
    return self;
}

//取消高亮状态
-(void)setHighlighted:(BOOL)highlighted{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * tabBarButtonImageRadio;
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * tabBarButtonImageRadio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}
@end
