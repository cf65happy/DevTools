//
//  UIButton+Category.h
//  DevTools
//
//  Created by chenfei on 2019/1/10.
//  Copyright © 2019 c.f. All rights reserved.
//  Button扩展方法

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    UIControlContentDefaulImageAndTitle = 0,    //  默认布局 图片在左 标题在右
    UIControlContentVerticalImageAndTitle,      //  垂直布局 图片在上 标题在下
    UIControlContentHorizontalImageAndTitle,    //  水平布局 图片在右 标题在左
} UIControlContentType;

@interface UIButton (Category)

/*
 * 扩大点击响应区域
 */
@property (nonatomic, assign) CGSize expandSize;

/*
 * 记录按钮点击次数
 */
@property (nonatomic, assign) NSInteger clickCount;

/*
 * 设置图文布局方式
 */
@property(nonatomic, assign) UIControlContentType contenType;

@end

NS_ASSUME_NONNULL_END
