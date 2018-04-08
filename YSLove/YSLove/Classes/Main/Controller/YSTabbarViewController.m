//
//  YSTabbarViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/1/6.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

//c
#import "YSTabbarViewController.h"
#import "YSBaseNavController.h"
#import "YSHomeViewController.h"
#import "YSMineViewController.h"
#import "YSPublishViewController.h"
//v
#import "YSTabBar.h"

@interface YSTabbarViewController ()<YSTabbarDelegate,RZTransitionInteractionControllerDelegate>
@property(nonatomic, weak)YSTabBar *customTabBar;

@property (nonatomic, strong) id<RZTransitionInteractionController> pushPopInteractionController;
@property (nonatomic, strong) id<RZTransitionInteractionController> presentInteractionController;
@property (nonatomic, strong) id<RZTransitionInteractionController> pinchInteractionController;
@end

@implementation YSTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.初始化tabbar
    [self setupTabbar];
    
    // 2.初始化所有子控制器
    [self setupChildViewControlelrs];
    [self loadAnimations];
    [self setTransitioningDelegate:[RZTransitionsManager shared]];
    
    
    
}

-(void)loadAnimations{
    self.pushPopInteractionController = [[RZHorizontalInteractionController alloc] init];
    [self.pushPopInteractionController setNextViewControllerDelegate:self];
    [self.pushPopInteractionController attachViewController:self withAction:RZTransitionAction_PushPop];
    [[RZTransitionsManager shared] setInteractionController:self.pushPopInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_PushPop];
    
    
    // Create the presentation interaction controller that allows a custom gesture
    // to control presenting a new VC via a presentViewController
    self.presentInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [self.presentInteractionController setNextViewControllerDelegate:self];
    [self.presentInteractionController attachViewController:self withAction:RZTransitionAction_Present];
    
    self.pinchInteractionController = [RZPinchInteractionController new];
    [self.pinchInteractionController setNextViewControllerDelegate:self];
    [self.pinchInteractionController attachViewController:self withAction:RZTransitionAction_Present];
    
    // Setup the push & pop animations as well as a special animation for pushing a
    // RZSimpleCollectionViewController
    [[RZTransitionsManager shared] setAnimationController:[[RZCardSlideAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_PushPop];
    
    // Setup the animations for presenting and dismissing a new VC
    [[RZTransitionsManager shared] setAnimationController:[[RZCirclePushAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_PresentDismiss];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[RZTransitionsManager shared] setInteractionController:self.presentInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Present];
    [[RZTransitionsManager shared] setInteractionController:self.pinchInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Present];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view  removeFromSuperview];
        }
    }
}

-(void)tabBarDidClickedPlusButton:(YSTabBar *)tabBar{
//    YSPublishViewController *publishVc = [[YSPublishViewController alloc] init];
//    [publishVc setTransitioningDelegate:[RZTransitionsManager shared]];
//    RZVerticalSwipeInteractionController *dismissInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
//    [dismissInteractionController attachViewController:publishVc withAction:RZTransitionAction_Dismiss];
//    [[RZTransitionsManager shared] setInteractionController:dismissInteractionController fromViewController:[self class]
//                        toViewController:nil
//                        forAction:RZTransitionAction_Dismiss];
//    [self presentViewController:publishVc animated:YES completion:nil];
    [self presentViewController:[self nextSimpleColorViewController] animated:YES completion:nil];
    
}


- (UIViewController *)nextSimpleColorViewController
{
    YSPublishViewController * newColorVC = [[YSPublishViewController alloc] init];
    [newColorVC setTransitioningDelegate:[RZTransitionsManager shared]];
    
    // Create a dismiss interaction controller that will be attached to the presented
    // view controller to allow for a custom dismissal
    RZVerticalSwipeInteractionController *dismissInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [dismissInteractionController attachViewController:newColorVC withAction:RZTransitionAction_Dismiss];
    [[RZTransitionsManager shared] setInteractionController:dismissInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Dismiss];
    return newColorVC;
}

-(void)setupTabbar{
    YSTabBar *customTabBar = [[YSTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

-(void)setupChildViewControlelrs{
    YSHomeViewController *home = [[YSHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectImageName:@"tabbar_home_selected"];
    
    
    YSMineViewController *mine = [[YSMineViewController alloc] init];
    [self setupChildViewController:mine title:@"我的" imageName:@"tabbar_mine" selectImageName:@"tabbar_mine_selected"];
    
}


/**
 监听tabbar改变
*/
-(void)tabBar:(YSTabBar *)tabBar didSelectButtonFrom:(int)from toButton:(int)to{
    self.selectedIndex = to;
}

/**
 *  初始化子控制器
 *
 *  @vc                 需要初始化的子控制器
 *  @title              标题
 *  @imageName          图标
 *  @selectedImageName  选中图标
 */
-(void)setupChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectedImageName
{
    // 1.设置属性
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.title = title;
    
    // 2.包装导航
    YSBaseNavController *Nav = [[YSBaseNavController alloc]initWithRootViewController:vc];
    Nav.delegate = [RZTransitionsManager shared];
    [self addChildViewController:Nav];
    
    // 3. 添加tabbar内部按钮
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

@end
