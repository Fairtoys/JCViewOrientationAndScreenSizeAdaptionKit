//
//  JCPopupUtils+OrientationSupport.h
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/9.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtils.h"
#import "UIDevice+JCOrientationAndScreenSizeUtils.h"

NS_ASSUME_NONNULL_BEGIN

/**
 横竖屏的支持,各种尺寸屏的支持
 */

@interface JCPopupUtils (JCOrientationAndScreenSizeSupport)
- (void)setStateForCurrentOrientationAndScreenSize;//判断当前的屏幕方向，来设置对应的布局

/**
 //1.只传方向，不传尺寸，那么给当前尺寸的对应方向加上state
 //2.只传尺寸，不传方向，那么给当前尺寸的所有方向加上state
 //3.又传方向，又传尺寸，则给相应的尺寸和方向

 @param layoutAndAnimation 对应状态下的layout
 @param orientationAndScreenSize JCInterfaceOrientation | JCScreenSize,
 */
- (void)setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize;
@end

@interface UIView (JCPopUtilsOrientationAndScreenSizeSupport)

/**
 [self.popUtils relayoutUsingCurrentOrientation]
 */
- (void)poputils_setStateForCurrentOrientationAndScreenSize;

/**
 [self.popUtils setLayoutAndAnimation:layoutAndAnimation forOrientationAndScreenSize:orientationAndScreenSize];
 
 @param layoutAndAnimation 对应状态下的layout
 @param orientationAndScreenSize JCInterfaceOrientation | JCScreenSize,
 */
- (void)poputils_setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize;

@end

@interface UIViewController (JCPopUtilsOrientationAndScreenSizeSupport)
/**
 [self.popUtils relayoutUsingCurrentOrientation]
 */
- (void)poputils_setStateForCurrentOrientationAndScreenSize;

/**
 [self.view poputils_setLayoutAndAnimation:layoutAndAnimation forOrientationAndScreenSize:orientationAndScreenSize];
 
 @param layoutAndAnimation 对应状态下的layout
 @param orientationAndScreenSize JCInterfaceOrientation | JCScreenSize,
 */
- (void)poputils_setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize;
@end

NS_ASSUME_NONNULL_END
