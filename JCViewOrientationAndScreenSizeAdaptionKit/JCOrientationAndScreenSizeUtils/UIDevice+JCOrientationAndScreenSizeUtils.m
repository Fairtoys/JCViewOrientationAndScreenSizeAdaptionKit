//
//  UIDevice+ScreenSize.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/8.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "UIDevice+JCOrientationAndScreenSizeUtils.h"

@implementation UIDevice (JCOrientationAndScreenSizeUtils)

+ (BOOL)isEqualToHeight:(CGFloat)theHeight{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGFloat max = MAX(width, height);
    return  ABS(max - theHeight) < DBL_EPSILON;
}

+ (BOOL)jc_is480x320{
    return [self isEqualToHeight:480];
}

+ (BOOL)jc_is568x320{
    return [self isEqualToHeight:568];
}
+ (BOOL)jc_is667x375{
    return [self isEqualToHeight:667];
}
+ (BOOL)jc_is736x414{
    return [self isEqualToHeight:736];
}
+ (BOOL)jc_is812x375{
    return [self isEqualToHeight:812];
}

@end
