//
//  YSTabBar.m
//  YSLove
//
//  Created by zhangxin on 2017/1/6.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSTabBar.h"
#import "YSTabBarButton.h"

@interface YSTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, weak) YSTabBarButton *selectedButton;
@end

@implementation YSTabBar

bool flag = YES;

-(NSMutableArray *)tabBarButtons{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加中间按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_plusButton"]forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_plusButton_press"] forState:UIControlStateHighlighted];
        plusButton.backgroundColor = [UIColor redColor];
        plusButton.bounds = CGRectMake(0, 0, 64, 64);
        plusButton.layer.shadowColor = [UIColor blackColor].CGColor;
        plusButton.layer.shadowOffset = CGSizeMake(0, -1.5);
        plusButton.layer.shadowOpacity = 0.8;
        plusButton.layer.cornerRadius = 64/2;
        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}

-(void)plusButtonClick
{
    if([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]){
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item{
    YSTabBarButton *button = [[YSTabBarButton alloc] init];
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
    
    button.item = item;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

-(void)buttonClick:(YSTabBarButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:toButton:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:(int)self.selectedButton.tag toButton:(int)button.tag];
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //调整加号位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(0.5 * w, 0.3 * h);
    
    
    //按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0;  index < self.tabBarButtons.count; index++) {
        //取出按钮
        UIButton *button = self.tabBarButtons[index];
        
        // 设置frame
        CGFloat buttonX = index * buttonW;
        if (index == 1 ) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 绑定tag
        button.tag = index;
    }
}

@end
