//
//  DevTools.h
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, iPhoneType) {
    iPhone4, //0
    iPhone4s, //1
    iPhone5, //2
    iPhone5c, //3
    iPhone5s, //4
    iPhone6, //5
    iPhone6p, //6
    iPhone6s, //7
    iPhone6sp, //8
    iPhone7, //9
    iPhone7p, //10
    iPhone8, //11
    iPhone8p, //12
    iPhoneX, //13
    iPhoneSE, //14
    Simulator, //15
    Unknown, //16
};

@interface DevTools : NSObject

/**
 * 手机号格式校验
 */
+ (BOOL)checkMobile:(NSString *)mobile;

/*
 *获取系统音量大小
 */
+(CGFloat)getSystemVolumValue;

/*
 *设置系统音量大小
 */
+(void)setSysVolumWith:(double)value;

/**
 *  获取设备型号
 */
+ (iPhoneType)phoneType;

/**
 * 截屏
 */
+(UIImage *)captureImageInView:(UIView *)view;


@end
