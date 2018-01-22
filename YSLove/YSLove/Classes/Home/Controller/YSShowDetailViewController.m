//
//  YSShowDetailViewController.m
//  YSLove
//
//  Created by zhangxin on 2016/6/25.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSShowDetailViewController.h"
#import "YSHttpTool.h"
#import "HomeHttpTool.h"


#import "YSSaveCollectParam.h"
#import "YSTagResult.h"
#import "YSLoginResult.h"
#import "YSAccountTool.h"

@interface YSShowDetailViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) WKWebView *YSHomeWebView;

@end

@implementation YSShowDetailViewController

bool tag = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *homeWkVc = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, MainScreenH)];
    homeWkVc.UIDelegate = self;
    homeWkVc.navigationDelegate = self;
    [self.view addSubview:homeWkVc];
    self.YSHomeWebView = homeWkVc;
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    self.title = @"详情";
    NSString *requestURL = [NSString stringWithFormat:@"%@%@?id=%@",http_text_prefixURL,http_text_detailURL,_detailModel.ID];
    debuglog(@"%@",requestURL);
    
    [_YSHomeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(collectButtonClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"正在加载"];
}


-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}


-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


-(void)setDetailModel:(EssayDetailModel *)detailModel{
    _detailModel = detailModel;
}


-(void)collectButtonClick{
    
    if(tag){
        tag = NO;
        
        YSLoginResult *result = [YSAccountTool account];
        if (kObj_isNIl(result.username)) {
            [SVProgressHUD showErrorWithStatus:@"尚未登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            tag = YES;
            return;
        }
        
        YSSaveCollectParam *param = [YSSaveCollectParam new];
        param.uid = result.uid;
        param.jianjie = _detailModel.jianjie;
        param.ID = _detailModel.ID;
        param.thumb = _detailModel.thumb;
        param.title = _detailModel.title;
        param.edittime = _detailModel.edittime;
        param.views = _detailModel.views;
        param.catename = _detailModel.catename;
        param.subcatename = _detailModel.subcatename;
        param.tags = _detailModel.tags;
        
        [HomeHttpTool saveCollectDataWithParameter:param success:^(YSTagResult *result) {
            if (result.code == 200) {
                [SVProgressHUD showSuccessWithStatus:result.msg];
            }else{
                [SVProgressHUD showErrorWithStatus:@"收藏失败"];
            }
            tag = YES;
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
}



@end
