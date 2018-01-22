//
//  YSLifeViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/27.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSLifeViewController.h"
#import "YSSearchMailViewController.h"
#import "YSDreamViewController.h"


#import "YSSettingCell.h"
#import "YSSettingGroup.h"
#import "IRickSettingArrowItem.h"

@interface YSLifeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *lifeTableView;

@property(nonatomic, strong)NSMutableArray *groups;

@end

@implementation YSLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"生活服务";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"nav_back" highlightIcon:@"nav_back_press" target:self action:@selector(leftItemClick)];
    
    [self addGroup0];
    [self addGroup1];
}

-(void)addGroup0{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *searchMailVc = [IRickSettingArrowItem itemWithIcon:@"express" title:@"快递查询" destVcClass:[YSSearchMailViewController class]];
    group.items = @[searchMailVc];
}

-(void)addGroup1{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *dreamVc= [IRickSettingArrowItem itemWithIcon:@"dream" title:@"周公解梦" destVcClass:[YSDreamViewController class]];
    group.items = @[dreamVc];
}


#pragma mark TableViewDelegate
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
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
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

-(void)leftItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
