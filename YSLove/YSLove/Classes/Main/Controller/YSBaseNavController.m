//
//  YSBaseNavController.m
//  YSLove
//
//  Created by zhangxin on 2017/2/21.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSBaseNavController.h"
#define titleSize 17
#define buttonSize 14

@interface YSBaseNavController ()

@end

@implementation YSBaseNavController

+(void)initialize{
    
    //1.设置导航栏主题
    [self setupNavBarTheme];
    
    //2.设置按钮主题
    [self setupNavBarButtonItemTheme];
}

/**
 *  设置导航栏主题
 */
+(void)setupNavBarTheme
{
    //    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:titleSize];
    [navBar setTitleTextAttributes:textAttrs];
    //设置状态栏字体颜色
    navBar.barStyle = UIBarStyleBlack;
#warning 去除底部阴影
    //    [navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    [navBar setShadowImage:[[UIImage alloc] init]];
}

/**
 *  设置导航栏按钮主题
 */
+(void)setupNavBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:buttonSize];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"nav_back" highlightIcon:@"nav_back_press" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
