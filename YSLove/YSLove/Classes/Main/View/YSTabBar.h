//
//  YSTabBar.h
//  YSLove
//
//  Created by zhangxin on 2017/1/6.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSTabBar;

@protocol YSTabbarDelegate <NSObject>
-(void)tabBar:(YSTabBar *)tabBar didSelectButtonFrom:(int)from toButton:(int)to;
-(void)tabBarDidClickedPlusButton:(YSTabBar *)tabBar;
@end

@interface YSTabBar : UIView
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property(nonatomic, weak) id<YSTabbarDelegate> delegate;
@end
