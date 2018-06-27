//
//  NSObject+Category.m
//  DevTools
//
//  Created by chenfei on 2018/6/27.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "NSObject+Category.h"
#import "NSString+Category.h"
@implementation NSObject (Category)

- (BOOL)isNoEmpty
{
    if ([self isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if ([self isKindOfClass:[NSString class]])
    {
        NSString *str = (NSString *)self;
        return [str.trim length] > 0;
    }
    else if ([self isKindOfClass:[NSData class]])
    {
        
        return [(NSData *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSArray class]])
    {
        
        return [(NSArray *)self count] > 0;
    }
    else if ([self isKindOfClass:[NSDictionary class]])
    {
        
        return [(NSDictionary *)self count] > 0;
    }
    
    return YES;
}

@end
