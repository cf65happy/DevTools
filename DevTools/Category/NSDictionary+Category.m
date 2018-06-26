//
//  NSDictionary+Category.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

+(void)load {
    [super load];
#ifdef DEBUG
#else
    [self swizzMethod];
#endif
}
+ (void)swizzMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method newMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setNoNilObject:forKey:));
        method_exchangeImplementations(oldMethod, newMethod);
    });
}

-(void)setNoNilObject:(id)anyObject forKey:(id)key {
    if (!anyObject) {
        NSLog(@"value不能为空");
    }else {
        [self setNoNilObject:anyObject forKey:key];
    }
}


@end
