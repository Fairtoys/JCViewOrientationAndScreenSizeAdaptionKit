//
//  UIView+JCLayoutForOrientation.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/8.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCViewMultipleLayout.h"
#import <objc/runtime.h>
#import "UIDevice+JCOrientationAndScreenSizeUtils.h"
#import "JCStateStorage.h"

@interface JCViewMultipleLayout ()

@property (nonatomic, strong) JCStateStorage <id <NSCopying>, dispatch_block_t> *stateStorage;

@end

@implementation JCViewMultipleLayout

- (JCStateStorage<id <NSCopying>, dispatch_block_t> *)stateStorage{
    if (!_stateStorage) {
        _stateStorage = [[JCStateStorage alloc] init];
        [_stateStorage setOnValueDidSetBlock:^(JCStateStorage * _Nonnull theStateStorage) {
            dispatch_block_t layout = theStateStorage.value;
            if (layout) {
                layout();
            }
        }];
    }
    return _stateStorage;
}

- (void)setLayout:(dispatch_block_t)layout forState:(id<NSCopying>)state{
    [self.stateStorage setValue:layout forState:state];
}
- (void)setLayout:(dispatch_block_t)layout forStateInt:(NSInteger)state{
    [self setLayout:layout forState:@(state)];
}

- (dispatch_block_t)layoutForState:(id<NSCopying>)state{
    return [self.stateStorage valueForState:state];
}
- (dispatch_block_t)layoutForStateInt:(NSInteger)state{
    return [self layoutForState:@(state)];
}

- (void)setLayoutNormal:(dispatch_block_t)layoutNormal{
    [self.stateStorage setValueForDefault:layoutNormal];
}

- (dispatch_block_t)layoutNormal{
    return self.stateStorage.valueForDefault;
}

- (void)setState:(id<NSCopying>)state{
    [self.stateStorage setState:state];
}

- (id<NSCopying>)state{
    return self.stateStorage.state;
}

@end


@implementation UIView (JCMultipleLayoutSupport)

- (void)setJclayout_viewLayout:(JCViewMultipleLayout *)jclayout_viewLayout{
    objc_setAssociatedObject(self, @selector(jclayout_viewLayout), jclayout_viewLayout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JCViewMultipleLayout *)jclayout_viewLayout{
    JCViewMultipleLayout *_viewlayout = objc_getAssociatedObject(self, _cmd);
    if (!_viewlayout) {
        _viewlayout = [[JCViewMultipleLayout alloc] init];
        [self setJclayout_viewLayout:_viewlayout];
    }
    return _viewlayout;
}

- (JCViewMultipleLayout *)jclayout_viewLayoutOrNilIfNotCreated{
    return objc_getAssociatedObject(self, @selector(jclayout_viewLayout));
}

- (void)jclayout_enumerateSetState:(id <NSCopying>)state{
    JCViewMultipleLayout *_viewlayout = self.jclayout_viewLayoutOrNilIfNotCreated;
    [_viewlayout setState:state];
    for (UIView *subview in self.subviews) {
        [subview jclayout_enumerateSetState:state];
    }
}

- (void)jclayout_enumerateSetStateInt:(NSInteger)state{
    [self jclayout_enumerateSetState:@(state)];
}

#pragma mark - 转发给jclayout_viewLayout的方法
/**
 设置在state状态下的布局回调
 
 @param layout 回调
 @param state 状态
 */
- (void)jclayout_setLayout:(nullable dispatch_block_t)layout forState:(id <NSCopying>)state{
    [self.jclayout_viewLayout setLayout:layout forState:state];
}

- (void)jclayout_setLayout:(nullable dispatch_block_t)layout forStateInt:(NSInteger)state{
    [self.jclayout_viewLayout setLayout:layout forStateInt:state];
}

/**
 获取在state下的回调
 
 @param state 状态
 @return 布局回调
 */
- (nullable dispatch_block_t)jclayout_layoutForState:(id <NSCopying>)state{
    return [self.jclayout_viewLayoutOrNilIfNotCreated layoutForState:state];
}

- (nullable dispatch_block_t)jclayout_layoutForStateInt:(NSInteger)state{
    return [self.jclayout_viewLayoutOrNilIfNotCreated layoutForStateInt:state];
}

- (void)setJclayout_layoutNormal:(dispatch_block_t)jclayout_layoutNormal{
    self.jclayout_viewLayout.layoutNormal = jclayout_layoutNormal;
}

- (dispatch_block_t)jclayout_layoutNormal{
    return self.jclayout_viewLayoutOrNilIfNotCreated.layoutNormal;
}

- (void)setJclayout_state:(id<NSCopying>)jclayout_state{
    self.jclayout_viewLayout.state = jclayout_state;
}
- (id<NSCopying>)jclayout_state{
    return self.jclayout_viewLayoutOrNilIfNotCreated.state;
}


@end
