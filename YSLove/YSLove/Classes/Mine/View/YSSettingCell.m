//
//  YSSettingCell
//  YSLove
//
//  Created by zhangxin on 16/7/29.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#import "YSSettingCell.h"
#import "IRickSettingItem.h"
#import "IRickSettingArrowItem.h"
#import "IRickSettingLabelItem.h"
#import "IRickSettingSwitchItem.h"
#import "IRickBadgeButton.h"

@interface YSSettingCell()
/**
 *  箭头
 */
@property (nonatomic, strong) UIImageView *arrowView;
/**
 *  右侧文字
 */
@property(nonatomic, strong) UILabel *itemLabel;
/**
 *  开关
 */
@property (nonatomic, strong) UISwitch *switchView;

/**
 *  提醒数字
 */
@property (nonatomic, strong) IRickBadgeButton *badgeButton;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *selectedBgView;

@end
@implementation YSSettingCell
-(UIImageView *)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_next"]];
    }
    return _arrowView;
}
-(UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView = [UISwitch new];
    }
    return _switchView;
}

-(UILabel *)itemLabel{
    if (_itemLabel == nil) {
        _itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
        _itemLabel.textAlignment = NSTextAlignmentRight;
        _itemLabel.textColor = YSColor(60, 60, 60, 1);
        _itemLabel.highlightedTextColor = _itemLabel.textColor;
        _itemLabel.font = [UIFont systemFontOfSize:14 weight:3];
    }
    return _itemLabel;
}

-(IRickBadgeButton *)badgeButton{
    if (_badgeButton == nil) {
        _badgeButton = [IRickBadgeButton new];
    }
    return _badgeButton;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"setting";
    YSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[YSSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = YSColor(60, 60, 60, 1);
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        //创建背景
        UIImageView *bgView = [UIImageView new];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
        UIImageView *selectBgView = [UIImageView new];
        self.selectedBackgroundView = selectBgView;
        self.selectedBgView = selectBgView;
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
//    frame.origin.x = 0;
//    frame.size.width -= 10;
    
    [super setFrame:frame];
}

-(void)setItem:(IRickSettingItem *)item{
    _item = item;
    
    // 1. 设置数据
    [self setupData];
    
    // 2. 设置右边的控件
    [self setupRightView];
}

-(void)setupData{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    self.textLabel.text = self.item.title;
}

-(void)setupRightView{
    if (self.item.badgeValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    }else if([self.item isKindOfClass:[IRickSettingSwitchItem class]]){
        self.accessoryView = self.switchView;
    }else if([self.item isKindOfClass:[IRickSettingLabelItem class]]){
        self.itemLabel.text = self.item.subtitle;
        self.accessoryView = self.itemLabel;
    }else if([self.item isKindOfClass:[IRickSettingArrowItem class]]){
        if(self.item.subtitle){
            self.itemLabel.text = self.item.subtitle;
            self.accessoryView = self.itemLabel;
        }else{
            self.accessoryView = self.arrowView;
        }
    }else{
        self.accessoryView = nil;
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    // 1. 设置背景图片
    int totalRows = (int)[self.tableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    if (totalRows == 1) {
        bgName = @"common_card_background_os7";
        selectedBgName = @"common_card_background_highlighted_os7";
    }else if(indexPath.row == 0){
        bgName = @"common_card_top_background_os7";
        selectedBgName = @"common_card_top_background_highlighted_os7";
    }else if(indexPath.row == totalRows-1){
        bgName = @"common_card_bottom_background_os7";
        selectedBgName = @"common_card_bottom_background_highlighted_os7";
    }else{
        bgName = @"common_card_middle_background_os7";
        selectedBgName = @"common_card_middle_background_highlighted_os7";
    }
    self.bgView.image = [UIImage resizeImageWithName:bgName];
    self.selectedBgView.image = [UIImage resizeImageWithName:selectedBgName];
}
@end
