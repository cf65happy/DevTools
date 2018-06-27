//
//  NSString+Category.h
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface NSString (Category)

/**
 * MD5
 */
-(NSString*)MD5;

/**
 * 去首尾空格
 */
-(NSString*)trim;


@end
