//
//  YSSearchViewController.m
//  YSLove
//
//  Created by zhangxin on 2016/8/16.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSSearchViewController.h"
#import "YSShowDetailViewController.h"

#import "EssayDetailModel.h"
#import "IRickSearchBar.h"
#import "YSHomeEssayViewCell.h"

#import "EssaySearchRequestParam.h"
#import "EssayListRequestResult.h"

#import "YSHttpTool.h"
@interface YSSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YSKeyBoardToolBarDelegate>
@property(nonatomic, weak) IRickSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *essayListView;
@property(nonatomic, strong) EssayListRequestResult *result;
@property(nonatomic, strong) NSArray *results;

@end

@implementation YSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSearchBar];
    
    [self.searchBar becomeFirstResponder];
    self.essayListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.essayListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.essayListView.mj_footer.hidden = YES;
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.searchBar resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(void)endInputClick{
    [self loadNewData];
    [self.searchBar resignFirstResponder];
}


-(void)setupSearchBar{
    IRickSearchBar *searchBar = [IRickSearchBar searchBar];
    searchBar.frame = CGRectMake(20, 5, MainScreenW/3*2, 30);
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
};

-(void)loadNewData{
    [self.essayListView.mj_header beginRefreshing];
    EssaySearchRequestParam *param = [EssaySearchRequestParam new];
    param.pagesize = 20;
    param.p = 1;
    param.keywords = self.searchBar.text;
    
    
    [YSHttpTool getWithURL:[NSString stringWithFormat:@"%@%@",http_text_prefixURL,http_text_searchURL] parameter:param.mj_keyValues success:^(id json) {
        debuglog(@"%@",json);
        EssayListRequestResult *result = [EssayListRequestResult mj_objectWithKeyValues:json];
        if (_result == nil) {
            _result = result;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (EssayDetailModel *model in result.results) {
            [array addObject:model];
        }
        _results = array;
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
    
    if ([self.searchBar.text  isEqual: @""]) {
        [SVProgressHUD showErrorWithStatus:@"搜索内容不能为空!"];
        [self.essayListView.mj_footer endRefreshing];
        return;
    }
    EssaySearchRequestParam *param = [EssaySearchRequestParam new];
    param.pagesize = 20;
    param.keywords = self.searchBar.text;
    param.p = _result.nowpage + 1;
    
    [YSHttpTool getWithURL:[NSString stringWithFormat:@"%@%@",http_text_prefixURL,http_text_searchURL] parameter:param.mj_keyValues success:^(id json) {
        debuglog(@"%@",json);
        EssayListRequestResult *result = [EssayListRequestResult mj_objectWithKeyValues:json];
        _result = result;
        NSMutableArray *array = [NSMutableArray array];
        for (EssayDetailModel *model in result.results) {
            [array addObject:model];
        }
        NSMutableArray *newArray = [NSMutableArray array];
        [newArray addObjectsFromArray:_results];
        [newArray addObjectsFromArray:array];
        _results = newArray;
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

#pragma mark tableViewMethod
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSHomeEssayViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YSHomeEssayViewCell" owner:nil options:nil] lastObject];
    EssayDetailModel *detailEssay = _results[indexPath.row];
    cell.essay = detailEssay;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YSShowDetailViewController *showVc = [YSShowDetailViewController new];
    EssayDetailModel *detailEssay = _results[indexPath.row];
    showVc.detailModel = detailEssay;

    [self.navigationController pushViewController:showVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loadNewData];
    return YES;
}


#pragma mark 懒加载
-(NSArray *)results{
    if (_results == nil) {
        _results = [NSArray array];
    }
    return _results;
}
@end
