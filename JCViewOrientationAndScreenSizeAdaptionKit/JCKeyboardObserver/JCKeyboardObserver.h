//
//  HJKeyboardObserver.h
//  living
//
//  Created by huajiao on 2018/3/1.
//  Copyright © 2018年 MJHF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JCKeyboardObserverBlock)(CGRect keyboardEndFrame, NSTimeInterval animationDuration, UIViewAnimationCurve animationCurve);

/**
 键盘事件监听
 */
@interface JCKeyboardObserver : NSObject

@property (nonatomic, copy, nullable) JCKeyboardObserverBlock  onKeyboardWillShowBlock;
@property (nonatomic, copy, nullable) JCKeyboardObserverBlock  onKeyboardWillHideBlock;

- (void)registerObserver;
- (void)unrigisterObserver;

@end

NS_ASSUME_NONNULL_END
