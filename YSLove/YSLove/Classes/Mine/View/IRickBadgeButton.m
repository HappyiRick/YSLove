//
//  IRickBadgeButton.m
//  IRickWeibo
//
//  Created by zhangxin on 16/6/8.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "IRickBadgeButton.h"

@interface IRickBadgeButton()


@end

@implementation IRickBadgeButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge_os7"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    
    return self;
}


-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue =[badgeValue copy];
    
    if (badgeValue && [badgeValue intValue] != 0) {
        self.hidden = NO;
        
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字尺寸
            CGSize badgeSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        
    }else {
        self.hidden = YES;
    }
}

@end
