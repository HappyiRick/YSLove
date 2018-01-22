//
//  YSHomeEssayViewCell.m
//  YSLove
//
//  Created by zhangxin on 2017/2/24.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSHomeEssayViewCell.h"
#import "EssayDetailModel.h"

@implementation YSHomeEssayViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.essayImageView circleView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setEssay:(EssayDetailModel *)essay{
    _essay = essay;
    if (![essay.thumb isEqualToString:@""]) {
        [self.essayImageView sd_setImageWithURL:[NSURL URLWithString:essay.thumb]];
    }else{
        self.essayImageView.image = [UIImage imageNamed:@"weather_sun"];
    }
    
    self.essayTitle.text = essay.title;
    self.essayTime.text = [NSDate dateStrFromCstampTime:[essay.edittime intValue]
                                         withDateFormat:@"YYYY-MM-dd"];
    self.essayType.text = essay.subcatename;
}
@end
