//
//  UIView+JCLayoutForOrientation.h
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/8.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 给UIView添加不同状态下的不同布局回调
 */
@interface JCViewMultipleLayout : NSObject

/**
 设置在state状态下的布局回调

 @param layout 回调
 @param state 状态
 */
- (void)setLayout:(nullable dispatch_block_t)layout forState:(id <NSCopying>)state;
- (void)setLayout:(nullable dispatch_block_t)layout forStateInt:(NSInteger)state;

/**
 获取在state下的回调

 @param state 状态
 @return 布局回调
 */
- (nullable dispatch_block_t)layoutForState:(id <NSCopying>)state;
- (nullable dispatch_block_t)layoutForStateInt:(NSInteger)state;

/**
 默认的布局回调，如果没有设置其他状态的回调，则会默认调用此回调来布局
 */
@property (nonatomic, copy, nullable) dispatch_block_t layoutNormal;

/**
 当前状态，设置state会有可能重新布局
 */
@property (nonatomic, strong, nullable) id <NSCopying> state;

@end


@interface UIView (JCMultipleLayoutSupport)

@property (nonatomic, strong) JCViewMultipleLayout * jclayout_viewLayout;//调用此property会自动创建JCViewMultipleLayout,
@property (nonatomic, readonly, nullable) JCViewMultipleLayout * jclayout_viewLayoutOrNilIfNotCreated;//此方法不会自动创建jclayout_viewLayout
/**
 会调用自己的 jclayout_viewLayout来布局，然后遍历子view，布局子view

 @param state 状态
 */
- (void)jclayout_enumerateSetState:(id <NSCopying>)state;
- (void)jclayout_enumerateSetStateInt:(NSInteger)state;


#pragma mark - 转发给jclayout_viewLayout的方法
/**
 设置在state状态下的布局回调
 
 @param layout 回调
 @param state 状态
 */
- (void)jclayout_setLayout:(nullable dispatch_block_t)layout forState:(id <NSCopying>)state;
- (void)jclayout_setLayout:(nullable dispatch_block_t)layout forStateInt:(NSInteger)state;

/**
 获取在state下的回调
 
 @param state 状态
 @return 布局回调
 */
- (nullable dispatch_block_t)jclayout_layoutForState:(id <NSCopying>)state;
- (nullable dispatch_block_t)jclayout_layoutForStateInt:(NSInteger)state;

/**
 默认的布局回调，如果没有设置其他状态的回调，则会默认调用此回调来布局
 */
@property (nonatomic, copy, nullable) dispatch_block_t jclayout_layoutNormal;

/**
 当前状态，设置state会有可能重新布局
 */
@property (nonatomic, strong, nullable) id <NSCopying> jclayout_state;


@end

NS_ASSUME_NONNULL_END
