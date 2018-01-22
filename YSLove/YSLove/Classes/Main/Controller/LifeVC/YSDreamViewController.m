//
//  YSDreamViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/27.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSDreamViewController.h"
#import "YSDreamTableViewCell.h"

#import "YSDreamAPIParam.h"
#import "YSAPIHttpTool.h"
#import "YSDreamAPIResult.h"
#import "YSDreamContent.h"

@interface YSDreamViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YSKeyBoardToolBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dreamListView;
@property (weak, nonatomic) IBOutlet UITextField *dreamKeyText;

@property(nonatomic, strong) NSArray *dreams;

@end

@implementation YSDreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_dreamKeyText becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)endInputClick{
    [_dreamKeyText resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(kObj_isNIl(textField.text)){
        [self loadNewData:textField.text];
    }
    [self.dreamListView scrollsToTop];
}

-(void)loadNewData:(NSString *)keyWords{
    if(kObj_isNIl(keyWords)){
        return;
    }
    YSDreamAPIParam *param = [YSDreamAPIParam param];
    param.keyword = keyWords;
    
    [YSAPIHttpTool getDreamWithparameter:param success:^(YSDreamAPIResult *result) {
        if ([result.status isEqualToString:@"0"]) {
            NSMutableArray *contentArray = [NSMutableArray array];
            for (YSDreamContent *dream in result.result) {
                [contentArray addObject:dream];
            }
            _dreams = contentArray;
            
            [self.dreamListView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:result.msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dreams.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSDreamTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YSDreamTableViewCell" owner:nil options:nil] lastObject];
    YSDreamContent *content = _dreams[indexPath.row];
    cell.content = content;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.dreamListView.rowHeight = UITableViewAutomaticDimension;
    self.dreamListView.estimatedRowHeight = 133;
    return self.dreamListView.rowHeight;
}



#pragma mark 懒加载
-(NSArray *)dreams{
    if (nil == _dreams) {
        _dreams = [[NSArray alloc] init];
    }
    return _dreams;
}

@end
