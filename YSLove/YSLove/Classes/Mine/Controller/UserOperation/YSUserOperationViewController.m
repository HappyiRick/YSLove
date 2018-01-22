//
//  YSUserOperationViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/17.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSUserOperationViewController.h"

#import "YSUserHttpTool.h"
#import "YSAccountTool.h"
#import "YSLoginResult.h"

#import "YSCheckPasswordParam.h"
#import "YSUpdateNicknameParam.h"
#import "YSUpdateUserEmailParam.h"
#import "YSUpdateUserPhoneParam.h"
#import "YSRepasswordParam.h"

@interface YSUserOperationViewController ()<YSKeyBoardToolBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property(nonatomic, assign) int uid;
@end

@implementation YSUserOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    YSLoginResult *result = [YSAccountTool account];
    self.uid = result.uid;
    
    [self.infoTextField becomeFirstResponder];
    
    if ([self.title isEqualToString: @"更改昵称"]) {
        self.infoTextField.secureTextEntry = NO;
        _verifyButton.tag = 0;
        _tipsLabel.text = @"请输入您的昵称:";
    }else if ([self.title isEqualToString: @"绑定手机"]) {
        self.infoTextField.secureTextEntry = NO;
        _verifyButton.tag = 1;
        _tipsLabel.text = @"请输入您的手机号码:";
    }else if ([self.title isEqualToString: @"绑定邮箱"]) {
        self.infoTextField.secureTextEntry = NO;
        _verifyButton.tag = 2;
        _tipsLabel.text = @"请输入您的邮箱号码:";
    }else if ([self.title isEqualToString: @"验证密码"]) {
        self.infoTextField.secureTextEntry = YES;
        _verifyButton.tag = 3;
        _tipsLabel.text = @"请输入您的密码:";
    }else if ([self.title isEqualToString: @"修改密码"]) {
        self.infoTextField.secureTextEntry = YES;
        _verifyButton.tag = 4;
        _tipsLabel.text = @"请输入您所修改的密码:";
    }
    
}



#pragma mark TextDelegate
-(void)endInputClick{
    [self.infoTextField resignFirstResponder];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark Method
- (IBAction)buttonClicked:(UIButton *)sender {
    switch ((int)sender.tag) {
        case 0:
            [self updateNickname];
            break;
        case 1:
            [self updateUserPhone];
            break;
        case 2:
            [self updateUserEmail];
            break;
        case 3:
            [self checkPassword];
            break;
        case 4:
            [self modifyPassword];
            break;
    }
}


-(void)updateNickname{
    YSUpdateNicknameParam *param = [YSUpdateNicknameParam new];
    param.uid = self.uid;
    param.usernickname = self.infoTextField.text;
    
    [YSUserHttpTool updateNicknameWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            YSLoginResult *loginResult = [YSAccountTool account];
            loginResult.usernickname = param.usernickname;
            [YSAccountTool savaAccount:loginResult];
            [SVProgressHUD showSuccessWithStatus:@"更改成功"];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
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

-(void)updateUserPhone{
    YSUpdateUserPhoneParam *param = [YSUpdateUserPhoneParam new];
    param.uid = self.uid;
    param.userphone = self.infoTextField.text;
    
    [YSUserHttpTool updateUserPhoneWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            YSLoginResult *loginResult = [YSAccountTool account];
            loginResult.userphone = param.userphone;
            [YSAccountTool savaAccount:loginResult];
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"绑定失败"];
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

-(void)updateUserEmail{
    YSUpdateUserEmailParam *param = [YSUpdateUserEmailParam new];
    param.uid = self.uid;
    param.useremail = self.infoTextField.text;
    
    [YSUserHttpTool updateUserEmailWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            YSLoginResult *loginResult = [YSAccountTool account];
            loginResult.useremail = param.useremail;
            [YSAccountTool savaAccount:loginResult];
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"绑定失败"];
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

-(void)modifyPassword{
    YSRepasswordParam *param = [YSRepasswordParam new];
    param.uid = self.uid;
    param.userrepassword = [self.infoTextField.text encryptStringWithMD5];
    
    [YSUserHttpTool updatePasswordWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
             [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
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

-(void)checkPassword{
    YSCheckPasswordParam *param = [YSCheckPasswordParam new];
    param.uid = self.uid;
    param.userpassword = [self.infoTextField.text encryptStringWithMD5];
    
    [YSUserHttpTool checkPasswordWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            [SVProgressHUD showSuccessWithStatus:@"验证成功!"];
            YSUserOperationViewController *operationVc = [YSUserOperationViewController new];
            operationVc.title = @"修改密码";
            [self.navigationController pushViewController:operationVc animated:YES];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"验证失败!"];
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
