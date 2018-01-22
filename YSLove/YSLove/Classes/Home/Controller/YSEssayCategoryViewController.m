//
//  YSEssayCategoryViewController.m
//  YSLove
//
//  Created by zhangxin on 2016/6/25.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSEssayCategoryViewController.h"
#import "YSEssayListViewController.h"
#import "YSSearchViewController.h"

#import "YSHomeCategoryViewCell.h"

#import "HomeHttpTool.h"
#import "CategoryRequestParam.h"
#import "CategoryRequestResult.h"
#import "YSEssayClassModel.h"
#import "YSEssayClassDetailModel.h"


@interface YSEssayCategoryViewController ()<UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation YSEssayCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章分类";
    [self setupNavBarButtons];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"nav_back" highlightIcon:@"nav_back_press" target:self action:@selector(leftItemClick)];
    [SVProgressHUD showWithStatus:@"正在加载列表中"];
    [self loadCategoryData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

-(void)setupNavBarButtons{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_search" highlightIcon:@"icon_search_press" target:self action:@selector(searchButtonClick)];
}

-(void)searchButtonClick{
    YSSearchViewController *searchVc = [YSSearchViewController new];
    [self.navigationController pushViewController:searchVc animated:YES];
}

-(void)leftItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadCategoryData{
    CategoryRequestParam *param = [CategoryRequestParam new];
    param.catename = @"养生人群";
    param.type = 1;
    
    [HomeHttpTool getCategoryDataWithParameter:param success:^(CategoryRequestResult *result) {
        NSMutableArray *essayArray = [NSMutableArray array];
        for (int i = 0;i<result.result.count;i++) {
            YSEssayClassModel *model = [YSEssayClassModel mj_objectWithKeyValues:result.result[i]];
            [essayArray addObject:model];
        }
        _categoryArray = essayArray;
        [self.categoryTableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _categoryArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YSEssayClassModel *model = _categoryArray[section];
    return model.items.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YSEssayClassModel *model = _categoryArray[section];
    return model.title;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHomeCategoryViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YSHomeCategoryViewCell" owner:nil options:nil] lastObject];
    YSEssayClassModel *model = _categoryArray[indexPath.section];
    YSEssayClassDetailModel *detailEssay = model.items[indexPath.row];
    cell.detail = detailEssay;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 100, 40)];
    YSEssayClassModel *model = _categoryArray[section];
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
    YSEssayListViewController *showVc = [YSEssayListViewController new];
    YSEssayClassModel *model = _categoryArray[indexPath.section];
    YSEssayClassDetailModel *detailEssay = model.items[indexPath.row];
    showVc.essayClass = detailEssay;
    [self.navigationController pushViewController:showVc animated:YES];
}

-(NSArray *)categoryArray{
    if (_categoryArray == nil) {
        _categoryArray = [NSArray array];
    }
    return _categoryArray;
}



@end
