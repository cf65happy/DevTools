//
//  NSDictionary+Category.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

/**
 * json对应key
 */
- (void)propertyCode {
    // 属性跟字典的key一一对应
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典中所有key取出来
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // key:属性名
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,copy) NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) BOOL %@;",key];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSNumber  *%@;",key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSArray *%@;",key];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSDictionary *%@;",key];
        }
        
        [codes appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",codes);
    
}


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
