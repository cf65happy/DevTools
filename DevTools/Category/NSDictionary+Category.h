//
//  NSDictionary+Category.h
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface NSDictionary (Category)

/**
 * json对应key，打印出来复制粘贴即可把接口返回转化为model
 */
- (void)propertyCode;

@end
