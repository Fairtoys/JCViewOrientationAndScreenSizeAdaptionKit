//
//  JCViewMultipleLayout+JCOrientationAndScreenSizeSupport.h
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/9.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCViewMultipleLayout.h"
#import "UIDevice+JCOrientationAndScreenSizeUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCViewMultipleLayout (JCOrientationAndScreenSizeSupport)

- (void)setStateForCurrentOrientationAndScreenSize;//判断当前的屏幕方向，来设置对应的布局

/**
 //1.只传方向，不传尺寸，那么给当前尺寸的对应方向加上state
 //2.只传尺寸，不传方向，那么给当前尺寸的所有方向加上state
 //3.又传方向，又传尺寸，则给相应的尺寸和方向

 @param layout 对应状态下的layout
 @param orientationAndScreenSize JCInterfaceOrientation | JCScreenSize
 */
- (void)setLayout:(nullable dispatch_block_t)layout forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize;

@end

@interface UIView (JCViewMultipleLayoutOrientationAndScreenSizeSupport)


/**
 [self.jclayout_viewLayout setStateForCurrentOrientationAndScreenSize];
 */
- (void)jclayout_setStateForCurrentOrientationAndScreenSize;

/**
 调用 自己的setStateForCurrentOrientation， 并遍历子view，也调用setStateForCurrentOrientation
 */
- (void)jclayout_enumerateSetStateForCurrentOrientationAndScreenSize;


/**
 [self.jclayout_viewLayout setLayout:layout forOrientationAndScreenSize:orientationAndScreenSize];

 @param layout 对应状态的layout
 @param orientationAndScreenSize JCInterfaceOrientation | JCScreenSize
 */
- (void)jclayout_setLayout:(nullable dispatch_block_t)layout forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize;

@end

NS_ASSUME_NONNULL_END
