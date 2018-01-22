//
//  NSString+YS.m
//  YSLove
//
//  Created by zhangxin on 2017/3/31.
//  Copyright © 2017年 i_Rick. All rights reserved.
//

#import "NSString+YS.h"

@implementation NSString (YS)
-(NSString *)flatterHTML:(NSString *)html{
    NSScanner *scaner;
    NSString *text = nil;
    
    
    scaner = [NSScanner scannerWithString:html];
    
    
    while ([scaner isAtEnd] == NO) {
        [scaner scanUpToString:@"<" intoString:NULL];
        [scaner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
@end
