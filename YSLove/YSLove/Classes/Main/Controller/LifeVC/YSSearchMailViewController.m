//
//  YSSearchMailViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/27.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSSearchMailViewController.h"

#import "YSSearchMailAPIParam.h"
#import "YSSearchMailAPIResult.h"
#import "YSSearchMailResult.h"
#import "YSMailStaus.h"
#import "YSAPIHttpTool.h"

@interface YSSearchMailViewController ()<YSKeyBoardToolBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *postNumber;

@end

@implementation YSSearchMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.postNumber becomeFirstResponder];
}

-(void)endInputClick{
    [_postNumber resignFirstResponder];
}

- (IBAction)searchMail {
    
    if (kObj_isNIl(self.postNumber.text)) {
        [SVProgressHUD showErrorWithStatus:@"订单号不能为空"];
        return;
    }
    [self.postNumber resignFirstResponder];
    YSSearchMailAPIParam *param = [YSSearchMailAPIParam param];
    param.number = _postNumber.text;
    //param.number = @"3325131116626";
    
    [YSAPIHttpTool searchMailWithparameter:param success:^(YSSearchMailAPIResult *result) {
        if ([result.status isEqualToString:@"0"]) {
            YSMailStaus *status = result.result.list[0];
            YSSearchMailResult *mailStatus = result.result;
            NSString *mailDeliver  = nil;
            switch (mailStatus.deliverystatus) {
                case 1:
                    mailDeliver = @"在途中";
                    break;
                case 2:
                    mailDeliver = @"派件中";
                    break;
                case 3:
                    mailDeliver = @"已签收";
                    break;
                case 4:
                    mailDeliver = @"派送失败";
                    break;
            }
            NSString *str = [NSString stringWithFormat:@"快递状态：%@\n快递编号：%@\n%@\n%@",mailDeliver,mailStatus.number,status.status,status.time];
            [SVProgressHUD showSuccessWithStatus:str];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else{
            [SVProgressHUD showErrorWithStatus:result.msg];
        }
        
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
