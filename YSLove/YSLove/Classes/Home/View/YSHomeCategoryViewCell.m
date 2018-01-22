//
//  YSHomeCategoryViewCell.m
//  YSLove
//
//  Created by zhangxin on 2017/2/25.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSHomeCategoryViewCell.h"
#import "YSEssayClassDetailModel.h"

@interface YSHomeCategoryViewCell()
@property (weak, nonatomic) IBOutlet UILabel *iconName;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@end

@implementation YSHomeCategoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconView circleView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDetail:(YSEssayClassDetailModel *)detail{
    _detail = detail;
    
    self.categoryName.text = detail.title;
    if ([detail.icon isEqualToString:@""]) {
        self.iconName.text = [detail.title substringToIndex:2];
        
        [self.iconView setBackgroundColor:YSColor(arc4random()%255, arc4random()%255, arc4random()%255, 1)];
    }else{
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:detail.icon]];
        
    }
}

@end
