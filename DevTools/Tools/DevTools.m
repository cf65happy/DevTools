//
//  DevTools.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "DevTools.h"

@implementation DevTools

/** 手机号码验证
 */
+ (BOOL)checkMobile:(NSString *)mobile
{
    //手机号以13，15，166，18 ,17，199开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(16[6])|(17[^4,\\D])|(19[9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

@end
