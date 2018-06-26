//
//  NSArray+Category.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)
//处理数组越界问题
+(void)load {
    //替换方法
    [super load];
#ifdef DEBUG
#else
    [self swizzMethod];
#endif
}
+(void)swizzMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#pragma mark - 避免数组越界处理
        //替换NSMutableArray的方法
        Method objectIndexM = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method newObjectIndexM = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeAtIndex:));
        method_exchangeImplementations(objectIndexM, newObjectIndexM);
        
        Method subscriptM = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
        Method newSubscriptM = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safeObjectAtIndexedSubscript:));
        method_exchangeImplementations(subscriptM, newSubscriptM);
        
        //替换NSArray的方法
        Method objectIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method newObjectIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndex:));
        method_exchangeImplementations(objectIndex, newObjectIndex);
        
        Method subscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
        Method newSubscript = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndexedSubscript:));
        method_exchangeImplementations(subscript, newSubscript);
        
        //替换空数组
        Method emptyIndex = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:));
        Method newEmptyIndex = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(newEmptyAtIndex:));
        method_exchangeImplementations(emptyIndex, newEmptyIndex);
        
        Method emptySubscript = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(objectAtIndexedSubscript:));
        Method newEmptySubscript = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(newEmptyAtIndexSubscript:));
        method_exchangeImplementations(emptySubscript, newEmptySubscript);
        
#pragma mark - 避免添加空对象处理
        Method oldMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:));
        Method newMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(insertNoNilObject:atIndex:));
        method_exchangeImplementations(oldMethod, newMethod);
        
        Method oldAdd = class_getInstanceMethod(objc_getClass("NSArray"), @selector(arrayByAddingObject:));
        Method newAdd = class_getInstanceMethod(objc_getClass("NSArray"), @selector(arrayByAddingNoNilObject:));
        method_exchangeImplementations(oldAdd, newAdd);
    });
}
//TODO: 防止数组越界的方式获取
-(id)objectAtSafeIndex:(NSUInteger)index {
    if (index > self.count-1 || !self.count) {
        return nil;
    }
    return [self objectAtSafeIndex:index];
    
}
-(id)safeAtIndex:(NSUInteger)index {
    if (index > self.count-1 || !self.count) {
        return nil;
    }
    
    return [self safeAtIndex:index];
}
-(id)objectAtSafeIndexedSubscript:(NSUInteger)index {
    if (index > self.count-1 || !self.count) {
        return nil;
    }
    return [self objectAtSafeIndexedSubscript:index];
}
-(id)safeObjectAtIndexedSubscript:(NSUInteger)index {
    if (index > self.count-1 || !self.count) {
        return nil;
    }
    return [self safeObjectAtIndexedSubscript:index];
}
-(id)newEmptyAtIndex:(NSUInteger)index {
    if (index > self.count-1 || !self.count) {
        return nil;
    }
    return [self newEmptyAtIndex:index];
}
-(id)newEmptyAtIndexSubscript:(NSUInteger)index {
    if (index > self.count-1 || !self.count) {
        return nil;
    }
    return [self newEmptyAtIndexSubscript:index];
}

//TODO: 添加空对象
-(void)insertNoNilObject:(id)object atIndex:(NSInteger)index {
    if (index<0||!object) {
        NSLog(@"非法添加");
    }else {
        [self insertNoNilObject:object atIndex:index];
    }
}
- (NSArray *)arrayByAddingNoNilObject:(id)anObject {
    if (!anObject) {
        NSLog(@"非法添加");
        return self;
    }else {
        return [self arrayByAddingObject:anObject];
    }
}

@end
