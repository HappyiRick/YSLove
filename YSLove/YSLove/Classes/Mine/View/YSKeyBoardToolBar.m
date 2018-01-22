//
//  YSKeyBoardToolBar.m
//  YSLove
//
//  Created by zhangxin on 2017/3/9.
//  Copyright © 2017年 i_Rick. All rights reserved.
//
#define barButtonTextSize 16
#import "YSKeyBoardToolBar.h"

@implementation YSKeyBoardToolBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YSColor(200, 200, 200, 1);
        self.endItem = [self buttonWithTitle:@"完成" action:@selector(endItemClick:)];
       
    }
    return self;
}


-(UIButton *)buttonWithTitle:(NSString *)title action:(SEL)action{
    UIButton *barItem = [[UIButton alloc] init];
    [barItem setTitle:title forState:UIControlStateNormal];
    [barItem setTitle:title forState:UIControlStateHighlighted];
    [barItem setTitle:title forState:UIControlStateDisabled];
    [barItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barItem setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [barItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    barItem.titleLabel.font = [UIFont systemFontOfSize:barButtonTextSize];
    [barItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:barItem];
    
    return barItem;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = MainScreenW/5;
    self.endItem.frame = CGRectMake(buttonW*4, 0, buttonW, self.Height);
}

-(void)endItemClick:(UIButton *)nextItem{
    if([self.delegate respondsToSelector:@selector(endInputClick)]){
        [self.delegate endInputClick];
    }
}


@end
