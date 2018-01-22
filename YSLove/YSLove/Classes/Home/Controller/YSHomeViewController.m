//
//  YSHomeViewController.m
//  YSLove
//
//  Created by zhangxin on 2016/6/21.
//  Copyright © 2016年 i_Rick. All rights reserved.
//


#import "YSHomeViewController.h"
#import "YSShowDetailViewController.h"
#import "YSEssayCategoryViewController.h"
#import "YSSearchViewController.h"

#import "HomeHttpTool.h"
#import "HomeRequestParam.h"
#import "HomeRequestResult.h"
#import "EssayCategoryModel.h"
#import "EssayDetailModel.h"

#import "YSHomeEssayViewCell.h"

@interface YSHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property(nonatomic, strong) NSMutableArray *essayArray;
@end

@implementation YSHomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBarButtons];
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHomeData)];
    [self.homeTableView.mj_header beginRefreshing];
}


-(void)setupNavBarButtons{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_search" highlightIcon:@"icon_search_press" target:self action:@selector(searchButtonClick)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

-(void)searchButtonClick{
    YSSearchViewController *searchVc = [YSSearchViewController new];
    [self.navigationController pushViewController:searchVc animated:YES];
}

-(void)loadHomeData{
    HomeRequestParam *param = [HomeRequestParam new];
    param.catename = @"养生人群";
    [HomeHttpTool getHomeDataWithParameter:param success:^(HomeRequestResult *result) {
        NSMutableArray *array = [NSMutableArray array];
        for (EssayCategoryModel *model in result.list) {
            [array addObject:model];
        }
        _essayArray = array;
        [self.homeTableView reloadData];
        [self.homeTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"服务器出现故障~"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        };
        [self.homeTableView.mj_header endRefreshing];
    }];
}

#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _essayArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EssayCategoryModel *model = _essayArray[section];
    return model.list.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    EssayCategoryModel *model = _essayArray[section];
    return model.title;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHomeEssayViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YSHomeEssayViewCell" owner:nil options:nil] lastObject];
    EssayCategoryModel *model = _essayArray[indexPath.section];
    EssayDetailModel *detailEssay = model.list[indexPath.row];
    cell.essay = detailEssay;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 100, 40)];
    EssayCategoryModel *model = _essayArray[section];
    label.text = model.title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont  systemFontOfSize:15 weight:5];
    [view addSubview:label];
    view.backgroundColor = YSColor(185, 10, 8, 1);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSShowDetailViewController *showVc = [YSShowDetailViewController new];
    EssayCategoryModel *model = _essayArray[indexPath.section];
    EssayDetailModel *detailEssay = model.list[indexPath.row];
    showVc.detailModel = detailEssay;
    [self.navigationController pushViewController:showVc animated:YES];
}

#pragma mark 懒加载
-(NSMutableArray *)essayArray{
    if (_essayArray == nil) {
        _essayArray = [NSMutableArray array];
    }
    return _essayArray;
}
@end
