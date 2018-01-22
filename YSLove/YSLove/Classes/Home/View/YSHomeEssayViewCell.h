//
//  YSHomeEssayViewCell.h
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EssayDetailModel;
@interface YSHomeEssayViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *essayImageView;
@property (weak, nonatomic) IBOutlet UILabel *essayTitle;
@property (weak, nonatomic) IBOutlet UILabel *essayType;
@property (weak, nonatomic) IBOutlet UILabel *essayTime;

@property(nonatomic, strong) EssayDetailModel *essay;
@end
