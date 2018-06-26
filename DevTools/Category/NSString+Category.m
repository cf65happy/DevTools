//
//  NSString+Category.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+(void)load {
    [super load];
#ifdef DEBUG
#else
    [self swizzMethod];
#endif
}
+(void)swizzMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#pragma mark - 截取字符串到指定位置
        Method oldSubstringTo = class_getInstanceMethod(objc_getClass("__NSCFConstantString"), @selector(substringToIndex:));
        Method newSubstringTo = class_getInstanceMethod(objc_getClass("__NSCFConstantString"), @selector(substringToSafeIndex:));
        method_exchangeImplementations(oldSubstringTo, newSubstringTo);
        
#pragma mark - 截取字符串从指定位置
        Method oldSubstringFrom = class_getInstanceMethod(objc_getClass("__NSCFConstantString"), @selector(substringFromIndex:));
        Method newSubstringFrom = class_getInstanceMethod(objc_getClass("__NSCFConstantString"), @selector(substringFromSafeIndex:));
        method_exchangeImplementations(oldSubstringFrom, newSubstringFrom);
        
#pragma mark - 截取指定范围字符串
        Method oldSubstringWithRange = class_getInstanceMethod(objc_getClass("__NSCFConstantString"), @selector(substringWithRange:));
        Method newSubstringWithRange = class_getInstanceMethod(objc_getClass("__NSCFConstantString"), @selector(substringWithSafeRange:));
        method_exchangeImplementations(oldSubstringWithRange, newSubstringWithRange);
        
#pragma mark - 插入字符串
        Method oldInsert = class_getInstanceMethod(objc_getClass("__NSCFString"), @selector(insertString:atIndex:));
        Method newInsert = class_getInstanceMethod(objc_getClass("__NSCFString"), @selector(insertString:atSafeIndex:));
        method_exchangeImplementations(oldInsert, newInsert);
        
#pragma mark - 删除字符串
        Method oldDel = class_getInstanceMethod(objc_getClass("__NSCFString"), @selector(deleteCharactersInRange:));
        Method newDel = class_getInstanceMethod(objc_getClass("__NSCFString"), @selector(deleteCharactersInSafeRange:));
        method_exchangeImplementations(oldDel, newDel);
    });
}

-(NSString*)substringToSafeIndex:(NSUInteger)index {
    if (index > self.length || !self.length) {
        NSLog(@"越界了");
        return self;
    }else {
        return [self substringToSafeIndex:index];
    }
}
-(NSString *)substringFromSafeIndex:(NSUInteger)from {
    if (from > self.length || !self.length) {
        NSLog(@"越界了");
        return self;
    }else {
        return [self substringFromSafeIndex:from];
    }
}
-(NSString *)substringWithSafeRange:(NSRange)range {
    if (range.location+range.length > self.length || !self.length) {
        NSLog(@"越界了");
        return self;
    }else {
        return [self substringWithSafeRange:range];
    }
}

-(void)insertString:(NSString*)string atSafeIndex:(NSUInteger)loc {
    if (loc > self.length-1 || !self.length) {
        NSLog(@"越界了");
    }else {
        [self insertString:string atSafeIndex:loc];
    }
}

-(void)deleteCharactersInSafeRange:(NSRange)range {
    if (range.location+range.length > self.length || !self.length) {
        NSLog(@"越界了");
    }else {
        [self deleteCharactersInSafeRange:range];
    }
}

@end
