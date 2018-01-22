//
//  YSMacro.h
//  YSLove
//
//  Created by zhangxin on 16/10/27.
//  Copyright © 2016年 i_Rick. All rights reserved.
//

#ifndef YSMacro_h
#define YSMacro_h

/**************************************** 宏定义 *******************************/
// 1.颜色
#define YSColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

// 2.调试
// 调试阶段
#ifdef __OBJC__
#ifdef DEBUG
#define debuglog(...) NSLog(__VA_ARGS__)
// 发布阶段
#else
#define debuglog(...)
#endif
#endif

// 3. 屏幕
#define MainScreenW [UIScreen mainScreen].bounds.size.width
#define MainScreenH [UIScreen mainScreen].bounds.size.height

// 4. 通知中心
#define YSNotificationCenter [NSNotificationCenter defaultCenter]

// 5. 判断为空
#define kObj_isNIl(obj) (obj == nil || [obj isKindOfClass:[NSNull class]] || [obj isEqualToString:@""])

// 6. 接口IP
#define hostName @"http://47.94.163.146:3000"

// 7. 极速APP Key
#define myAppkey @"6efd26ffa3cdffa8"

// 在 block 中引用 weak 变量
#define WeakObj(obj) __weak typeof(obj) weak_##obj = obj

#endif /* YSMacro_h */
