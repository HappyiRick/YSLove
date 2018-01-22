//
//  YSDreamTableViewCell.m
//  YSLove
//
//  Created by zhangxin on 2017/3/29.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "YSDreamTableViewCell.h"
#import "YSDreamContent.h"

@implementation YSDreamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContent:(YSDreamContent *)content{
    _content = content;
    
    self.titleLabel.text = content.name;
    self.contentLabel.text = [content.content flatterHTML:content.content];
}

@end
