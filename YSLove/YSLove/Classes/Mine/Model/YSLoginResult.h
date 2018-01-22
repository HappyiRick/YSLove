//
//  YSLoginResult.h
//  YSLove
//
//  Created by zhangxin on 2017/3/16.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSTagResult.h"
@interface YSLoginResult : YSTagResult<NSCoding>
@property(nonatomic, assign) int uid;
@property(nonatomic, copy)   NSString *username;
@property(nonatomic, copy)   NSString *usernickname;
@property(nonatomic, copy)   NSString *userheader;
@property(nonatomic, copy)   NSString *userphone;
@property(nonatomic, copy)   NSString *useremail;
@end
