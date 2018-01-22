//
//  YSDreamTableViewCell.h
//  YSLove
//
//  Created by zhangxin on 2017/3/29.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSDreamContent;
@interface YSDreamTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic, strong) YSDreamContent *content;
@end
