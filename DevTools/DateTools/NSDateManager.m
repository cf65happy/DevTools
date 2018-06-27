//
//  NSDateManager.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "NSDateManager.h"

static NSDateManager* dateManager = nil;

@implementation NSDateManager
+(instancetype)shareDateManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateManager = [[NSDateManager alloc] init];
    });
    return dateManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
        NSTimeZone* localzone = [NSTimeZone localTimeZone];
        [_formatter setTimeZone:localzone];
        [_formatter setLocale:[NSLocale currentLocale]];
        //设置默认格式
        _defalutFormatter = @"yyyy-MM-dd HH:mm:ss";
        [_formatter setDateFormat:_defalutFormatter];
    }
    return self;
}

/**
 * 时间转指定格式的字符串
 */
-(NSString *)date:(NSDate *)date WithFormatter:(NSString *)formatter {
    if (formatter) {
        [_formatter setDateFormat:formatter];
    }
    return [_formatter stringFromDate:date];
}

/**
 * 当前时间转指定格式的字符串
 */
-(NSString *)currentDateWithFormatter:(NSString *)formatter {
    if (formatter) {
        [_formatter setDateFormat:formatter];
    }
    return [_formatter stringFromDate:[NSDate date]];
}

/**
 * 字符串转时间
 */
-(NSDate *)string:(NSString *)string WithFormatter:(NSString *)formatter {
    if (formatter) {
        [_formatter setDateFormat:formatter];
    }
    return [_formatter dateFromString:string];
}

/**
 * 比较两个日期
 */
-(BOOL)compareDate:(id)date1 isEarly:(id)date2 {
    
    if ([date1 isKindOfClass:[NSDate class]] && [date2 isKindOfClass:[NSDate class]]) {
        return [self compare:date1 isEarly:date2];
    }else {
        NSDate* firstDate;
        NSDate* secondDate;
        if ([date1 isKindOfClass:[NSString class]]) {
            firstDate = [self date:date1];
        }else if([date1 isKindOfClass:[NSDate class]]) {
            firstDate = date1;
        }
        if ([date2 isKindOfClass:[NSString class]]) {
            secondDate = [self date:date2];
        }else if ([date2 isKindOfClass:[NSDate class]]) {
            secondDate = date2;
        }
        if (firstDate && secondDate) {
            return [self compare:firstDate isEarly:secondDate];
        }
    }
    return NO;
    
}

/**
 * 未知格式的时间字符串转日期
 */
-(NSDate*)date:(NSString*)dateStr {
    NSDate* date;
    if ([self string:dateStr WithFormatter:@"yyyy-MM-dd HH:mm:ss"]) {
        date = [self string:dateStr WithFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }else if ([self string:dateStr WithFormatter:@"yyyy-MM-dd HH:mm"]){
        date = [self string:dateStr WithFormatter:@"yyyy-MM-dd HH:mm"];
    }else if ([self string:dateStr WithFormatter:@"yyyy-MM-dd"]){
        date = [self string:dateStr WithFormatter:@"yyyy-MM-dd"];
    }else if ([self string:dateStr WithFormatter:@"yyyy-MM"]){
        date = [self string:dateStr WithFormatter:@"yyyy-MM"];
    }else if ([self string:dateStr WithFormatter:@"yyyy"]){
        date = [self string:dateStr WithFormatter:@"yyyy"];
    }
    return date;
}
/**
 * 比较两个日期
 */
-(BOOL)compare:(NSDate *)date1 isEarly:(NSDate *)date2 {
    NSComparisonResult result = [date1 compare:date2];
    if (result == NSOrderedSame) {
        //两个日期相等
        return NO;
    }
    //NSOrderedAscending：date1比date2早
    return result == NSOrderedAscending? YES: NO;
}

/**
 * 获取某个时间的时间戳
 */
-(NSTimeInterval)timeInterval:(id)date {
    NSDate* date1;
    if (!date) {
        date1 = [NSDate date];
    }else {
        if ([date isKindOfClass:[NSDate class]]) {
            date1 = date;
        }else if ([date isKindOfClass:[NSString class]]){
            date1 = [self date:date];
        }
    }
    return [date1 timeIntervalSince1970];
}

/**
 * 到将来时间剩余时长
 */
-(NSDateComponents*)toFuture:(id)date {
    NSDate* date1;
    if (!date) {
        date1 = [NSDate date];
    }else {
        if ([date isKindOfClass:[NSDate class]]) {
            date1 = date;
        }else if ([date isKindOfClass:[NSString class]]){
            date1 = [self date:date];
        }
    }
    NSTimeInterval time = [date1 timeIntervalSinceNow];
    if (time<=0) {
        return nil;
    }
    NSInteger time_int = time;
    NSDateComponents* components = [[NSDateComponents alloc] init];
    //计算
    int hour = time / 3600;
    int minute = time_int % 3600 / 60;
    int second = time_int%60;
    int day = 0;
    int month = 0;
    int year = 0;
    //计算小时
    if (hour>=24) {
        day = hour/24;
        hour = hour % 24;
    }
    //计算月,一个月按30天算
    if (day>30) {
        month = day/30;
        day = day%30;
    }
    //计算年
    if (month>12) {
        year = month/12;
        month = month%12;
    }
    
    components.second = second; //秒
    components.minute = minute; //分
    components.hour = hour; //时
    components.day = day;
    components.month = month;
    components.year = year;
    
    return components;
}

/**
 * 过去多长时间
 */
-(NSDateComponents*)past:(id)date {
    NSDate* date1;
    if (!date) {
        date1 = [NSDate date];
    }else {
        if ([date isKindOfClass:[NSDate class]]) {
            date1 = date;
        }else if ([date isKindOfClass:[NSString class]]){
            date1 = [self date:date];
        }
    }
    NSTimeInterval time = [date1 timeIntervalSinceNow];
    if (time>0) {
        return nil;
    }
    time = -time;
    NSInteger time_int = time;
    NSDateComponents* components = [[NSDateComponents alloc] init];
    //计算
    int hour = time / 3600;
    int minute = time_int % 3600 / 60;
    int second = time_int%60;
    int day = 0;
    int month = 0;
    int year = 0;
    //计算小时
    if (hour>=24) {
        day = hour/24;
        hour = hour % 24;
    }
    //计算月,一个月按30天算
    if (day>30) {
        month = day/30;
        day = day%30;
    }
    //计算年
    if (month>12) {
        year = month/12;
        month = month%12;
    }
    
    components.second = second; //秒
    components.minute = minute; //分
    components.hour = hour; //时
    components.day = day;
    components.month = month;
    components.year = year;
    
    return components;
}

/**
 * 多久前的
 */
-(NSString*)timeBeforNow:(id)date Type:(NSInteger)type{
    
    NSDate* date1;
    if (!date) {
        date1 = [NSDate date];
    }else {
        if ([date isKindOfClass:[NSDate class]]) {
            date1 = date;
        }else if ([date isKindOfClass:[NSString class]]){
            date1 = [self date:date];
        }
    }
    NSTimeInterval time = [date1 timeIntervalSinceNow];
    if (time>0) {
        return [self date:date1 WithFormatter:@"yyyy-MM-dd HH:mm"];
    }
    time = -time;
    int year = time / (3600 * 24 * 30 *12);
    int month = time / (3600 * 24 * 30);
    int day = time / (3600 * 24);
    int hour = time / 3600;
    int minute = time / 60;
    if (type==1) {
        if (year > 0) {
            return [NSString stringWithFormat:@"%d年前",year];
        }else if(month > 0){
            return [NSString stringWithFormat:@"%d个月前",month];
        }else if(day > 0){
            return [NSString stringWithFormat:@"%d天前",day];
        }else if(hour > 0){
            return [NSString stringWithFormat:@"%d小时前",hour];
        }else if(minute > 0){
            return [NSString stringWithFormat:@"%d分钟前",minute];
        }else{
            return [NSString stringWithFormat:@"刚刚"];
        }
    }else if (type==2){
        if (month > 0) {
            return [self date:date1 WithFormatter:@"yyyy-MM-dd HH:mm"];
        }else if(hour > 0){
            return [NSString stringWithFormat:@"%d小时前",hour];
        }else if(minute > 0){
            return [NSString stringWithFormat:@"%d分钟前",minute];
        }else{
            return [NSString stringWithFormat:@"刚刚"];
        }
    }else if (type==3){
        if (month>0) {
           return [self date:date1 WithFormatter:@"yyyy-MM-dd HH:mm"];
        }else if(day > 0){
            return [NSString stringWithFormat:@"%d天前",day];
        }else if(hour > 0){
            return [NSString stringWithFormat:@"%d小时前",hour];
        }else if(minute > 0){
            return [NSString stringWithFormat:@"%d分钟前",minute];
        }else{
            return [NSString stringWithFormat:@"刚刚"];
        }
    }
    
    if (year > 0) {
        return [NSString stringWithFormat:@"%d年前",year];
    }else if(month > 0){
        return [NSString stringWithFormat:@"%d个月前",month];
    }else if(day > 0){
        return [NSString stringWithFormat:@"%d天前",day];
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%d小时前",hour];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }else{
        return [NSString stringWithFormat:@"刚刚"];
    }
}

/**
 * 时间戳获取多久前
 * type:1-全部显示多久前；2-超过24小时显示日期；3-超过1月显示日期
 */
-(NSString*)timeBeforWithtimeInterval:(NSTimeInterval)timeInterval Type:(NSInteger)type {
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    if (date) {
        if ([self compare:date isEarly:[NSDate date]]) {
            return [self timeBeforNow:date Type:type];
        }
    }
    return nil;
}

/**
 * 时间戳转多长时间
 */
-(NSDateComponents*)componentsWithTimeInterval:(NSTimeInterval)timeInterval {
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    if (date) {
        if ([self compare:date isEarly:[NSDate date]]) {
            return [self past:date];
        }else {
            return [self toFuture:date];
        }
    }
    return nil;
}

/**
 * 显示时间范围
 */
-(NSString*)rangeOfDate:(id)date1 With:(id)date2 {
    NSDate* firstDate;
    NSDate* secondDate;
    if ([date1 isKindOfClass:[NSDate class]] && [date2 isKindOfClass:[NSDate class]]) {
        firstDate = date1;
        secondDate = date2;
    }else {
        if ([date1 isKindOfClass:[NSString class]]) {
            firstDate = [self date:date1];
        }else if([date1 isKindOfClass:[NSDate class]]) {
            firstDate = date1;
        }
        if ([date2 isKindOfClass:[NSString class]]) {
            secondDate = [self date:date2];
        }else if ([date2 isKindOfClass:[NSDate class]]) {
            secondDate = date2;
        }
    }
    if (firstDate && secondDate) {
        if ([firstDate compare:secondDate]==NSOrderedSame) {
            return [self date:firstDate WithFormatter:@"yyyy-MM-dd HH:mm"];
        }
        NSDate* temp;
        if (![self compare:firstDate isEarly:secondDate]) {
            temp = firstDate;
            firstDate = secondDate;
            secondDate = temp;
        }
        NSString* dateStr;
        NSString* form1;
        NSString* form2;
        NSDateComponents* comp1 = [self components:firstDate];
        NSDateComponents* comp2 = [self components:secondDate];
        if (comp2.year == comp1.year) {
            //年份相同
            NSDateComponents* now = [self components:[NSDate date]];
            
            if (comp2.year == now.year) { //今年
                //月份和天相同
                if (comp2.month == comp1.month && comp2.day == comp1.day) {
                    //今天
                    if (comp2.day == now.day && comp2.month == now.month) {
                        form1 = @"HH:mm";
                        form2 = @"HH:mm";
                    }else {
                        //其他天
                        form1 = @"MM-dd HH:mm";
                        form2 = @"HH:mm";
                    }
                }else {
                    //月份和天不同
                    form1 = @"MM-dd HH:mm";
                    form2 = @"MM-dd HH:mm";
                }
                
            }else { //不为今年
                if (comp2.month == comp1.month && comp2.day == comp1.day) {
                    //月份和天相同
                    form1 = @"yyyy-MM-dd HH:mm";
                    form2 = @"HH:mm";
                }else {
                    //月份和天不同
                    form1 = @"yyyy-MM-dd HH:mm";
                    form2 = @"MM-dd HH:mm";
                }

            }
        }else {
            //年份不同
            form1 = @"yyyy-MM-dd HH:mm";
            form2 = @"yyyy-MM-dd HH:mm";
        }
        dateStr = [NSString stringWithFormat:@"%@ ~ %@", [self date:firstDate WithFormatter:form1], [self date:secondDate WithFormatter:form2]];
        return dateStr;
    }
    return nil;
}
- (NSDateComponents*)components:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return components;
}

@end
