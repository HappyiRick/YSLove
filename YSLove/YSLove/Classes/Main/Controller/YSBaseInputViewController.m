//
//  YSBaseInputViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/31.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSBaseInputViewController.h"

@interface YSBaseInputViewController ()<YSKeyBoardToolBarDelegate>

@end

@implementation YSBaseInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupToolBar];
    
    // 监听键盘的通知
    [YSNotificationCenter addObserver:self selector:@selector(keyBordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [YSNotificationCenter addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupToolBar{
    YSKeyBoardToolBar *toolbar = [[YSKeyBoardToolBar alloc] init];
    toolbar.frame = CGRectMake(0, MainScreenH, MainScreenW, 44);
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark TextDelegate


-(void)keyBordWillShow:(NSNotification *)note
{
    // 1. 取出键盘frame
    CGRect keyboarF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2. 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    debuglog(@"%f",duration);
    // 3. 执行动画
    int keyheight = keyboarF.size.height + 44 + 64;
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyheight);
    }];
}


-(void)keyBoardWillHidden:(NSNotification *)note
{
    // 1. 取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2. 执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

-(void)dealloc{
    [YSNotificationCenter removeObserver:self];
}


@end
