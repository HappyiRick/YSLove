//
//  YSBaseInputViewController.h
//  YSLove
//
//  Created by zhangxin on 2017/3/31.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSKeyBoardToolBar.h"
@interface YSBaseInputViewController : UIViewController
-(void)keyBordWillShow:(NSNotification *)note;
-(void)keyBoardWillHidden:(NSNotification *)note;
@property(nonatomic, weak) YSKeyBoardToolBar *toolbar;
@end
