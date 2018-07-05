//
//  Constant.h
//  DevTools
//
//  Created by chenfei on 2018/6/27.
//  Copyright © 2018年 c.f. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//TODO: APP相关
/**
 * app名
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
/**
 * app版本
 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**
 * 版权信息
 */
#define APP_COPYRIGHT(str) \
^(){\
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];\
    NSDate* dt = [NSDate date];\
    unsigned unitFlags = NSCalendarUnitYear;\
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];\
    NSString* copyright = [NSString stringWithFormat:@"Copyright © 2017-%ld\n\%@",comp.year,str];\
    return copyright;\
}()
//TODO:设备相关
/**
 * 设备类型
 */
//判断是否为iPhone
#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
//判断是否为iPad
#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//TODO:系统相关
/**
 * 屏幕宽高
 */
#define KSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define KSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
/**
 * 系统版本
 */
#define SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
//TODO:适配相关
//iOS11中适配scrollView
/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = NO;}


//TODO:其他
/**
 * RGB颜色
 */
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// clear背景颜色
#define ClearColor [UIColor clearColor]
/**
 * 16进制颜色
 */
#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBAHex(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
/**
 * 引用问题
 */
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

/**
 * 单例
 */
#define SINGLETON_FOR_HEADER(className) +(className *)shared##className;

#define SINGLETON_FOR_CLASS(className)\
+(className *)shared##className { \
    static className *shared##className = nil;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken,^{ \
        shared##className =[[self alloc]init];\
    });\
    return shared##className;\
}
/**
 * 初始化tableView
 */
#define CreateTableView(sender)\
^(){\
    UITableView* tableView = [[UITableView alloc] init];\
    tableView.delegate = sender;\
    tableView.dataSource = sender;\
    return tableView;\
}()
/**
 * tableView去掉多余的footer
 */
#define TableViewZeroFooter(tableView) tableView.tableFooterView = [[UIView alloc] init];

/**
 * tableView分割线
 */
#define TableViewSepartor(tableView, style)\
^(){\
    tableView.separatorStyle = style;\
    if (style==UITableViewCellSeparatorStyleNone || style == 0) {\
    }else {\
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {\
            [tableView setSeparatorInset:UIEdgeInsetsZero];\
        }\
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {\
            [tableView setLayoutMargins:UIEdgeInsetsZero];\
        }\
    }\
}()

/**
 * 获取userDefault
 */
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//获取系统对象
#define kApplication [UIApplication sharedApplication]
/**
 * 获取窗口window
 */
#define kAppWindow [UIApplication sharedApplication].delegate.window
/**
 * 获取APP代理
 */
#define kAppDelegate [AppDelegate shareAppDelegate]
/**
 * 获取根控制器
 */
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
/**
 * 获取系统通知
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]

/**
 * 获取导航栏高度（导航栏+状态栏）
 */
#define KNavBarHeight \
^(){\
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];\
    CGRect rectNav = self.navigationController.navigationBar.frame;\
    return (rectStatus.size.height+ rectNav.size.height);\
}()

/**
 * 底部安全区域
 */
#define KSafeBottom \
^(){\
    if (@available(iOS 11.0, *)) {\
        return [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;\
    } else {\
        return 0.0;\
    }\
}()

//TODO:路径相关
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



#endif /* Constant_h */
