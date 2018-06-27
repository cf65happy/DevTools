//
//  NSDateManager.h
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateManager : NSObject
{
    NSString* _defalutFormatter;
}

@property(nonatomic, strong)NSDateFormatter* formatter;

+(instancetype)shareDateManager;

/**
 * 时间转指定格式的字符串
 */
-(NSString*)date:(NSDate*)date WithFormatter:(NSString*)formatter;

/**
 * 当前时间转指定格式的字符串
 */
-(NSString*)currentDateWithFormatter:(NSString*)formatter;

/**
 * 字符串转时间
 */
-(NSDate*)string:(NSString*)string WithFormatter:(NSString*)formatter;

/**
 * 比较两个日期，可以是两个date，两个string，一个date一个string
 */
-(BOOL)compareDate:(id)date1 isEarly:(id)date2;

/**
 * 获取某个时间的时间戳
 */
-(NSTimeInterval)timeInterval:(id)date;

/**
 * 到将来时间剩余时长
 */
-(NSDateComponents*)toFuture:(id)date;

/**
 * 过去多长时间
 */
-(NSDateComponents*)past:(id)date;

/**
 * 时间戳转多长时间
 */
-(NSDateComponents*)componentsWithTimeInterval:(NSTimeInterval)timeInterval;

/**
 * 多久前的
 * type:1-全部显示多久前；2-超过24小时显示日期；3-超过1月显示日期
 */
-(NSString*)timeBeforNow:(id)date Type:(NSInteger)type;

/**
 * 时间戳获取多久前
 * type:1-全部显示多久前；2-超过24小时显示日期；3-超过1月显示日期
 */
-(NSString*)timeBeforWithtimeInterval:(NSTimeInterval)timeInterval Type:(NSInteger)type;

/**
 * 显示时间范围
 */
-(NSString*)rangeOfDate:(id)date1 With:(id)date2;


@end
