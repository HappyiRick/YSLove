//
//  YSRegisterViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/9.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSRegisterViewController.h"

#import "YSLoginParam.h"
#import "YSTagResult.h"
#import "YSUserHttpTool.h"
@interface YSRegisterViewController ()<YSKeyBoardToolBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameView;
@property (weak, nonatomic) IBOutlet UITextField *userpasswordView;
@property (weak, nonatomic) IBOutlet UITextField *userRepasswordView;

@end

@implementation YSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
}

#pragma mark TextDelegate
-(void)endInputClick{
    [self.view endEditing:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)registerButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.userpasswordView.text != self.userRepasswordView.text) {
        [SVProgressHUD showErrorWithStatus:@"请重新确认密码！"];
        return;
    }
    
    YSLoginParam *param = [YSLoginParam new];
    param.username = self.userNameView.text;
    param.userpassword = [self.userpasswordView.text encryptStringWithMD5];
    debuglog(@"%@",param.userpassword);
    
    [YSUserHttpTool registerWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            [SVProgressHUD showSuccessWithStatus:result.msg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:result.msg];
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
