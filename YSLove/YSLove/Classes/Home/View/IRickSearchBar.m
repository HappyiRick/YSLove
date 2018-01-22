//
//  IRickSearchBar.m
//  IRickWeibo
//
//  Created by zhangxin on 16/6/9.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "IRickSearchBar.h"

#define searchFontSize 13

@implementation IRickSearchBar

+(instancetype)searchBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 背景
        self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background_os7"];
        
        // 左边的放大镜图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode  = UITextFieldViewModeAlways;
        
        // 字体
        self.font = [UIFont systemFontOfSize:searchFontSize];
        
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        
    }
    
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    rect = CGRectMake(rect.origin.x + 5,rect.origin.y, rect.size.width, rect.size.height);
    [super drawPlaceholderInRect:rect];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 20, self.frame.size.height);
}
@end
