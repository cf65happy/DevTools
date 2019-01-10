//
//  UIButton+Category.m
//  DevTools
//
//  Created by chenfei on 2019/1/10.
//  Copyright © 2019 c.f. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)


/**
 * 垂直布局图文，图片在上文字在下
 */
- (void)verticalImageAndTitle {
    // button标题的偏移量
    self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.frame.size.height+5, -self.imageView.bounds.size.width, 0,0);
    // button图片的偏移量
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width/2, self.titleLabel.frame.size.height+5, -self.titleLabel.frame.size.width/2);
}

/*
 * 左右布局图文，文字在左图片在右
 * 注意：若使用masonry约束的button，此方法需要在约束之后调用才生效
 */
- (void)horizontalTitleAndImage {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.imageEdgeInsets = UIEdgeInsetsMake(0, strongSelf.titleLabel.frame.size.width + 2.5, 0, -strongSelf.titleLabel.frame.size.width - 2.5);
        strongSelf.titleEdgeInsets = UIEdgeInsetsMake(0, -strongSelf.currentImage.size.width, 0, strongSelf.currentImage.size.width);
    });
}

#pragma mark - setter
- (void)setExpandSize:(CGSize)expandSize {
    objc_setAssociatedObject(self, @selector(expandSize), [NSValue valueWithCGSize:expandSize], OBJC_ASSOCIATION_RETAIN);
}
- (void)setClickCount:(NSInteger)clickCount {
    objc_setAssociatedObject(self, @selector(clickCount), @(clickCount), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setContenType:(UIControlContentType)contenType {
    objc_setAssociatedObject(self, @selector(contenType), @(contenType), OBJC_ASSOCIATION_ASSIGN);
    if (contenType == UIControlContentVerticalAlignmentTop) {
        [self verticalImageAndTitle];
    } else if (contenType == UIControlContentHorizontalImageAndTitle) {
        [self horizontalTitleAndImage];
    }
}

#pragma mark - getter
- (CGSize)expandSize {
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}
- (NSInteger)clickCount {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
- (UIControlContentType)contenType {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}


#pragma mark - function
//扩大点击响应区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(self.expandSize.width, 0);
    CGFloat heightDelta = MAX(self.expandSize.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}



@end
