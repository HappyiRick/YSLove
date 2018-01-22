//
//  YSMineViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/2/21.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSMineViewController.h"
#import "YSLoginViewController.h"
#import "YSUserViewController.h"
#import "AboutUsViewController.h"
#import "YSSystemViewController.h"
#import "YSCollectViewController.h"

#import "YSSettingGroup.h"
#import "IRickSettingArrowItem.h"
#import "IRickSettingLabelItem.h"
#import "YSSettingCell.h"

#import "YSAccountTool.h"
#import "YSLoginResult.h"

@interface YSMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mineTableView;

@property(nonatomic, strong) NSMutableArray *groups;
@end

@implementation YSMineViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

#pragma mark 懒加载
-(NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

-(YSSettingGroup *)addGroup{
    YSSettingGroup *group = [YSSettingGroup group];
    [self.groups addObject:group];
    return group;
}

-(void)setupGroup0{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *userManager = [IRickSettingArrowItem itemWithIcon:@"icon_mine_me" title:@"用户管理" destVcClass:[YSLoginViewController class]];
    
    group.items = @[userManager];
}

-(void)setupGroup1{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *news = [IRickSettingArrowItem itemWithIcon:@"icon_mine_news" title:@"我的消息" destVcClass:nil];
    news.operation = ^{
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    };
    
    IRickSettingArrowItem *stars = [IRickSettingArrowItem itemWithIcon:@"icon_mine_star" title:@"我的收藏" destVcClass:[YSCollectViewController class]];
    group.items = @[news,stars];
}

-(void)setupGroup2{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *system = [IRickSettingArrowItem itemWithIcon:@"icon_mine_system" title:@"系统设置" destVcClass:[YSSystemViewController class]];
    
    IRickSettingArrowItem *about = [IRickSettingArrowItem itemWithIcon:@"icon_mine_about"title:@"关于我们" destVcClass:[AboutUsViewController class]];
    group.items = @[system,about];
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YSSettingGroup *group = self.groups[section];
    return group.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSSettingCell *cell = [YSSettingCell cellWithTableView:tableView];
    YSSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1. 取出模型
    YSSettingGroup *group = self.groups[indexPath.section];
    IRickSettingItem *item = group.items[indexPath.row];
    
    // 2. 操作
    if (item.operation){
        item.operation();
    }
    
//     3. 跳转
    if ([item isKindOfClass:[IRickSettingArrowItem class]]) {
        IRickSettingArrowItem *arrowItem = (IRickSettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            
            YSLoginResult *result = [YSAccountTool account];
            if (indexPath.section == 0) {
                if (result) {
                    arrowItem.destVcClass = [YSUserViewController class];
                }else{
                    arrowItem.destVcClass = [YSLoginViewController class];
                }
            }else if(indexPath.section == 1 && indexPath.row == 1){
                YSLoginResult *result = [YSAccountTool account];
                if (result) {
                    arrowItem.destVcClass = [YSCollectViewController class];
                }else{
                    arrowItem.destVcClass = [YSLoginViewController class];
                    [SVProgressHUD showErrorWithStatus:@"您还尚未登录"];
                }
            }
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}




@end
