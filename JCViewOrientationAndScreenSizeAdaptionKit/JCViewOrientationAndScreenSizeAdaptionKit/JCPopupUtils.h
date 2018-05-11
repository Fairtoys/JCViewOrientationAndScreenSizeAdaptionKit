//
//  JCPopupUtils.h
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/3.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JCPopupUtilsLayoutAndAnimation;
/**
 弹出框工具
 */
@interface JCPopupUtils : NSObject

#pragma mark - layoutAndAnimations
/**
 在不同的state设置不同的布局，当设置state时，会根据该状态去取相应的布局类

 @param layoutAndAnimation 布局和动画类
 @param state 对应的状态
 */
- (void)setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forState:(id <NSCopying>)state;
- (void)setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forStateInt:(NSInteger)state;
/**
 获取对应的状态下的 LayoutAnimation

 @param state 状态
 @return JCPopupUtilsLayoutAndAnimation
 */
- (nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimationForState:(id <NSCopying>)state;
- (nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimationForStateInt:(NSInteger)state;
@property (nonatomic, strong) id <NSCopying> state;//当前状态，设置此状态有可能会重新调用layout

@property (nonatomic, strong, nullable) JCPopupUtilsLayoutAndAnimation *layoutAndAnimationNormal;//如果对应的state下的JCPopupUtilsLayoutAndAnimation都不存在的话，那么会使用此layout来做默认的布局

#pragma mark - views
@property (nonatomic, readonly) UIView *containerView;//整个大的容器,填满superView，放subView
@property (nonatomic, readonly) UIView *backgroundView;//当view的大小不填满整个containerView时，用来设置背景色
@property (nonatomic, weak, readonly, nullable) __kindof UIView *view;//当前弹出的view
@property (nonatomic, readonly, nullable) __kindof UIView *superView;//当前的容器SuperView
@property (nonatomic, readonly, getter = isViewShowing) BOOL viewShowing;//当前是否正在显示中

#pragma mark - callbacks
@property (nonatomic, copy, nullable) dispatch_block_t viewWillShowBlock;
@property (nonatomic, copy, nullable) dispatch_block_t viewDidShowBlock;
@property (nonatomic, copy, nullable) dispatch_block_t viewWillHideBlock;
@property (nonatomic, copy, nullable) dispatch_block_t viewDidHideBlock;

@property (nonatomic, copy, nullable) void (^onClickBackgroundViewBlock)( __kindof JCPopupUtils *thePopUtils);//当点击背景视图的回调，如果设置此回调，则不会触发默认关闭弹出框的逻辑，需要你自己处理关闭逻辑
#pragma mark - views util

/**
 显示新的view,如果当前已经有一个view在显示中了，则直接return

 @param view 要显示的view
 @param superView 要显示到哪个容器中
 @param viewWillShowBlock 将要显示的回调
 @param viewDidShowBlock 显示后的回调
 */
- (void)showView:(UIView *)view inSuperView:(UIView *)superView viewWillShowBlock:(nullable dispatch_block_t)viewWillShowBlock viewDidShowBlock:(nullable dispatch_block_t)viewDidShowBlock;
- (void)showView:(UIView *)view inSuperView:(UIView *)superView;


/**
 隐藏当前已显示的视图，如果当前没有视图在显示中，则直接return

 @param viewWillHideBlock 将要隐藏的回调
 @param viewDidHideBlock 隐藏后的回调
 */
- (void)hideViewWillHideBlock:(nullable dispatch_block_t)viewWillHideBlock viewDidHideBlock:(nullable dispatch_block_t)viewDidHideBlock;
- (void)hideView;

/**
显示新的view之前，先隐藏当前正在显示的view

@param view 要显示的新的view
*/
- (void)hideLastViewAndShowView:(UIView *)view inSuperView:(UIView *)superView;

- (void)relayout;//强制使用当前的layout来调用布局block
@end

@interface UIView (JCPopupUtils)

@property (nonatomic, strong) JCPopupUtils *popUtils;
/**
 在此视图上显示一个View

 @param view view
 */
- (void)poputils_showView:(UIView *)view;
- (void)poputils_showView:(UIView *)view viewWillShowBlock:(nullable dispatch_block_t)viewWillShowBlock viewDidShowBlock:(nullable dispatch_block_t)viewDidShowBlock;

/**
 隐藏当前显示的view
 */
- (void)poputils_hideView;
- (void)poputils_hideViewWillHideBlock:(nullable dispatch_block_t)viewWillHideBlock viewDidHideBlock:(nullable dispatch_block_t)viewDidHideBlock;


/**
 显示新的view之前，先隐藏当前正在显示的view

 @param view 要显示的新的view
 */
- (void)poputils_hideLastViewAndShowView:(UIView *)view;

@end

@interface UIViewController (JCPopupUtils)

@property (nonatomic, readonly) JCPopupUtils *popUtils;
/**
 在此视图上显示一个Controller，如果当前popUtils.isViewShowing 为YES ，则直接return了
 
 @param controller controller
 */
- (void)poputils_showController:(UIViewController *)controller;
- (void)poputils_showController:(UIViewController *)controller viewWillShowBlock:(nullable dispatch_block_t)viewWillShowBlock viewDidShowBlock:(nullable dispatch_block_t)viewDidShowBlock;

/**
 隐藏当前显示的controller
 */
- (void)poputils_hideController;
- (void)poputils_hideControllerViewWillHideBlock:(nullable dispatch_block_t)viewWillHideBlock viewDidHideBlock:(nullable dispatch_block_t)viewDidHideBlock;

/**
 显示新的view之前，会先去隐藏当前正在显示的view
 
 @param controller 要显示的新的view
 */
- (void)poputils_hideLastViewAndShowController:(UIViewController *)controller;
@end


NS_ASSUME_NONNULL_END
