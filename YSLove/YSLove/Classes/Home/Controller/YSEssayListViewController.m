//
//  YSEssayListViewController.m
//  YSLove
//
//  Created by zhangxin on 2016/6/25.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSEssayListViewController.h"
#import "YSShowDetailViewController.h"
#import "YSSearchViewController.h"

#import "YSHomeEssayViewCell.h"

#import "YSEssayClassDetailModel.h"
#import "EssayDetailModel.h"
#import "EssayListRequestParam.h"
#import "EssayListRequestResult.h"
#import "YSHttpTool.h"
@interface YSEssayListViewController ()<UITableViewDataSource,UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *essayListView;

@property(nonatomic, strong) NSArray *resultArray;
@property(nonatomic, strong) EssayListRequestResult *result;
@end

@implementation YSEssayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _essayClass.title;
    [self setupNavBarButtons];
    self.essayListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.essayListView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.essayListView.mj_header beginRefreshing];
}

-(void)setupNavBarButtons{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_search" highlightIcon:@"icon_search_press" target:self action:@selector(searchButtonClick)];
}

-(void)searchButtonClick{
    YSSearchViewController *searchVc = [YSSearchViewController new];
    [self.navigationController pushViewController:searchVc animated:YES];
}

-(void)loadNewData{
    EssayListRequestParam *param = [EssayListRequestParam new];
    param.pagesize = 20;
    param.p = 1;
    
    [YSHttpTool getWithURL:[NSString stringWithFormat:@"%@",_essayClass.apiurl] parameter:param.mj_keyValues success:^(id json) {
        EssayListRequestResult *result = [EssayListRequestResult mj_objectWithKeyValues:json];
        if (_result == nil) {
            _result = result;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (EssayDetailModel *model in result.results) {
            [array addObject:model];
        }
        _resultArray = array;
        [self.essayListView reloadData];
        if (_result.nowpage == _result.totalpage) {
            [self.essayListView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.essayListView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"服务器出现故障~"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        };
        [self.essayListView.mj_header endRefreshing];
    }];
}

-(void)loadMoreData{
    EssayListRequestParam *param = [EssayListRequestParam new];
    param.pagesize = 20;
    param.p = _result.nowpage + 1;
    
    [YSHttpTool getWithURL:[NSString stringWithFormat:@"%@",_essayClass.apiurl] parameter:param.mj_keyValues success:^(id json) {
        EssayListRequestResult *result = [EssayListRequestResult mj_objectWithKeyValues:json];
        _result = result;
        NSMutableArray *array = [NSMutableArray array];
        for (EssayDetailModel *model in result.results) {
            [array addObject:model];
        }
        NSMutableArray *newArray = [NSMutableArray array];
        [newArray addObjectsFromArray:_resultArray];
        [newArray addObjectsFromArray:array];
        _resultArray = newArray;
        [self.essayListView reloadData];
        if (_result.nowpage == _result.totalpage) {
            [self.essayListView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.essayListView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"服务器出现故障~"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        };
        [self.essayListView.mj_footer endRefreshing];
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

#pragma mark 懒加载
-(NSArray *)resultArray{
    if (_resultArray == nil) {
        _resultArray = [NSArray array];
    }
    return _resultArray;
}

@end
