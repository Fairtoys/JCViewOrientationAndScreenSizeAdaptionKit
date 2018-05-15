//
//  JCPopupUtilsLayoutAndAnimation.h
//  JCPopupContainerViewDemo
//
//  Created by Cerko on 2018/5/5.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JCPopupUtils;
typedef void(^JCPopupUtilsBlock)(__kindof JCPopupUtils *thePopUtils);

@interface JCPopupUtilsAnimation : NSObject
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) UIViewAnimationOptions options;
@property (nonatomic, copy, nullable) JCPopupUtilsBlock willAnimations;
@property (nonatomic, copy, nullable) JCPopupUtilsBlock animations;
@property (nonatomic, copy, nullable) void (^completion) (BOOL finished);
@end

@interface JCPopupUtilsLayoutAndAnimation : NSObject

@property (nonatomic, strong) __kindof JCPopupUtilsAnimation *animationForShow;
@property (nonatomic, strong) __kindof JCPopupUtilsAnimation *animationForHide;
@property (nonatomic, copy, nullable) JCPopupUtilsBlock layoutBlock;//布局的回调，在show的时候会调用，在旋转的时候需要在controller中手动调用此回调
@end


NS_ASSUME_NONNULL_END
