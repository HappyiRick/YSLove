//
//  YSHeaderImageData.h
//  YSLove
//
//  Created by zhangxin on 2017/3/18.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSHeaderImageData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
