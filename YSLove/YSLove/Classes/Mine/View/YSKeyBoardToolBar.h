//
//  YSKeyBoardToolBar.h
//  YSLove
//
//  Created by zhangxin on 2017/3/9.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSKeyBoardToolBarDelegate <NSObject>

-(void)endInputClick;

@end

@interface YSKeyBoardToolBar : UIView

@property (nonatomic, weak) UIButton *endItem;
@property(nonatomic, weak) id<YSKeyBoardToolBarDelegate> delegate;
@end
