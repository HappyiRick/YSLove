//
//  YSCollectViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/21.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSCollectViewController.h"
#import "YSShowDetailViewController.h"

#import "YSHomeEssayViewCell.h"

#import "EssayDetailModel.h"
#import "YSBaseParam.h"
#import "YSLoginResult.h"
#import "YSAccountTool.h"
#import "YSUserCollectResult.h"
#import "YSUserHttpTool.h"

#import "YSUserDeleteCollectParam.h"
#import "YSTagResult.h"

@interface YSCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *collectTableView;

@property(nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation YSCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNavBarButtons];
    self.collectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectTableView.mj_header beginRefreshing];
}

-(void)setupNavBarButtons{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editButtonClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
}

-(void)editButtonClick{
    [self.collectTableView setEditing:!self.collectTableView.editing animated:YES];
    if (self.collectTableView.editing) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editButtonClick)];
        item.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = item;
    }else{
        [self setupNavBarButtons];
    }
}

-(void)loadNewData{
    YSBaseParam *param = [YSBaseParam new];
    YSLoginResult *result = [YSAccountTool account];
    param.uid = result.uid;
    
    [YSUserHttpTool getUserCollectWithParameter:param success:^(YSUserCollectResult *result) {
        if (result.code == 200) {
            NSMutableArray *array = [NSMutableArray array];
            for (EssayDetailModel *model in result.datas) {
                [array addObject:model];
            }
            _resultArray = array;
            
            [self.collectTableView reloadData];
            [self.collectTableView.mj_header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"服务器出现故障~"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        };
        [self.collectTableView.mj_header endRefreshing];
    }];
    
}



#pragma mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHomeEssayViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YSHomeEssayViewCell" owner:nil options:nil] lastObject];
    cell.essay = _resultArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSShowDetailViewController *showVc = [YSShowDetailViewController new];
    EssayDetailModel *model = _resultArray[indexPath.row];
    showVc.detailModel = model;
    [self.navigationController pushViewController:showVc animated:YES];
}



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
    
    [self deleteCollectWithIndex:indexPath];
}

-(void)deleteCollectWithIndex:(NSIndexPath *)indexPath{
    YSLoginResult *result = [YSAccountTool account];
    EssayDetailModel *model = _resultArray[indexPath.row];
    YSUserDeleteCollectParam *param = [YSUserDeleteCollectParam new];
    param.uid = result.uid;
    param.ID = model.ID;
    
    [YSUserHttpTool deleteUserCollectWithParameter:param success:^(YSTagResult *result) {
        if (result.code == 200) {
            
            [_resultArray removeObjectAtIndex:indexPath.row];
            [self.collectTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];
}

#pragma mark 懒加载
-(NSMutableArray *)resultArray{
    if (_resultArray == nil) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}



@end
