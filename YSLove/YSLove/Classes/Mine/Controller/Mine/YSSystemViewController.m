//
//  YSSystemViewController.m
//  YSLove
//
//  Created by zhangxin on 2017/3/31.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSSystemViewController.h"

#import "YSSettingGroup.h"
#import "IRickSettingArrowItem.h"
#import "IRickSettingLabelItem.h"
#import "IRickSettingSwitchItem.h"
#import "YSSettingCell.h"

@interface YSSystemViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *systemTableView;

@property(nonatomic, strong) NSMutableArray *groups;
@end

@implementation YSSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

-(void)setupGroup0{
    YSSettingGroup *group = [self addGroup];
    IRickSettingSwitchItem *newsTip = [IRickSettingSwitchItem itemWithTitle:@"消息提示"];
    
    group.items = @[newsTip];
}


-(void)setupGroup1{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *read = [IRickSettingArrowItem itemWithTitle:@"阅读模式" destVcClass:nil];
    
    IRickSettingArrowItem *font = [IRickSettingArrowItem itemWithTitle:@"字号大小" destVcClass:nil];
    
    IRickSettingSwitchItem *mark = [IRickSettingSwitchItem itemWithTitle:@"显示备注"];
    
    group.items = @[mark,read,font];
}

-(void)setupGroup2{
    YSSettingGroup *group = [self addGroup];
    IRickSettingArrowItem *pic = [IRickSettingArrowItem itemWithTitle:@"图片质量设置" destVcClass:nil];
    pic.operation = ^{
        [SVProgressHUD showInfoWithStatus:@"此功能暂未开放"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    };
    group.items = @[pic];
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


@end
