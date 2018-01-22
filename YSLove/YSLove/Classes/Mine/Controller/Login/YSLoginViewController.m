//
//  YSLoginViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/9.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSLoginViewController.h"
#import "YSRegisterViewController.h"

#import "YSUserHttpTool.h"
#import "YSLoginParam.h"
#import "YSLoginResult.h"
#import "YSAccountTool.h"

@interface YSLoginViewController ()<YSKeyBoardToolBarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

@end

@implementation YSLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户登录";
    
}

#pragma mark TextDelegate
-(void)endInputClick{
    [self.view endEditing:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



-(IBAction)registerButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    YSRegisterViewController *registerView = [[YSRegisterViewController alloc] init];
    registerView.title = @"用户注册";
    [self.navigationController pushViewController:registerView animated:YES];
}


- (IBAction)loginButtonClick:(UIButton *)sender {
    YSLoginParam *param = [YSLoginParam new];
    param.username = self.userName.text;
    param.userpassword = [self.userPassword.text encryptStringWithMD5];
    
    [YSUserHttpTool loginWithParameter:param success:^(YSLoginResult *result) {
        if (result.code == 200) {
            [YSAccountTool savaAccount:result];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } failure:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"服务器出现故障~"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        };
    }];
}

@end
