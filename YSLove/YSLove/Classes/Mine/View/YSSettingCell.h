//
//  YSSettingCell.h
//  YSLove
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IRickSettingItem;
@interface YSSettingCell : UITableViewCell
@property (nonatomic, strong) IRickSettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
