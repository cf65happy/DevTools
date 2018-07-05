//
//  DevTools.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "DevTools.h"
#import <sys/utsname.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@implementation DevTools

/** 手机号码验证
 */
+ (BOOL)checkMobile:(NSString *)mobile
{
    //手机号以13，15，166，18 ,17，199开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(16[6])|(17[^4,\\D])|(19[9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/*
 *获取系统音量大小
 */
+(CGFloat)getSystemVolumValue {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat currentVol = audioSession.outputVolume;

    return currentVol;
}
/*
 *设置系统音量大小
 */
+(void)setSysVolumWith:(double)value {
    if (value>1) {
        value = value/100.0;
    }
    [self getSystemVolumSlider].value = value;
}

+(UISlider*)getSystemVolumSlider{
    static UISlider * volumeViewSlider = nil;
    if (volumeViewSlider == nil) {
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(10, 50, 200, 4)];
        volumeView.showsRouteButton = NO;
        volumeView.showsVolumeSlider = NO;
        for (UIView* newView in volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeViewSlider = (UISlider*)newView;
                break;
            }
        }
    }
    return volumeViewSlider;
}

// 获取设备型号
+ (iPhoneType)phoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return iPhone4;
    if ([deviceString isEqualToString:@"iPhone3,2"])    return iPhone4;
    if ([deviceString isEqualToString:@"iPhone3,3"])    return iPhone4;
    if ([deviceString isEqualToString:@"iPhone4,1"])    return iPhone4s;
    if ([deviceString isEqualToString:@"iPhone5,1"])    return iPhone5;
    if ([deviceString isEqualToString:@"iPhone5,2"])    return iPhone5;
    if ([deviceString isEqualToString:@"iPhone5,3"])    return iPhone5c;
    if ([deviceString isEqualToString:@"iPhone5,4"])    return iPhone5c;
    if ([deviceString isEqualToString:@"iPhone6,1"])    return iPhone5s;
    if ([deviceString isEqualToString:@"iPhone6,2"])    return iPhone5s;
    if ([deviceString isEqualToString:@"iPhone7,1"])    return iPhone6p;
    if ([deviceString isEqualToString:@"iPhone7,2"])    return iPhone6;
    if ([deviceString isEqualToString:@"iPhone8,1"])    return iPhone6s;
    if ([deviceString isEqualToString:@"iPhone8,2"])    return iPhone6sp;
    if ([deviceString isEqualToString:@"iPhone8,4"])    return iPhoneSE;
    if ([deviceString isEqualToString:@"iPhone9,1"])    return iPhone7;
    if ([deviceString isEqualToString:@"iPhone9,2"])    return iPhone7p;
    if ([deviceString isEqualToString:@"iPhone9,3"])    return iPhone7;
    if ([deviceString isEqualToString:@"iPhone9,4"])    return iPhone7p;
    if ([deviceString isEqualToString:@"iPhone10,1"])   return iPhone8;
    if ([deviceString isEqualToString:@"iPhone10,4"])   return iPhone8;
    if ([deviceString isEqualToString:@"iPhone10,2"])   return iPhone8p;
    if ([deviceString isEqualToString:@"iPhone10,5"])   return iPhone8p;
    if ([deviceString isEqualToString:@"iPhone10,3"])   return iPhoneX;
    if ([deviceString isEqualToString:@"iPhone10,6"])   return iPhoneX;
    if ([deviceString isEqualToString:@"i386"])         return Simulator;
    if ([deviceString isEqualToString:@"x86_64"])       return Simulator;
    
    return Unknown;
}


@end
