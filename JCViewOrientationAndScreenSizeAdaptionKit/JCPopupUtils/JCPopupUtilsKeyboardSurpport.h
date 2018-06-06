//
//  JCPopupUtilsKeyboardSurpport.h
//  JCViewOrientationAndScreenSizeAdaptionKit
//
//  Created by huajiao on 2018/6/6.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import "JCViewOrientationAndScreenSizeAdaptionKit.h"

NS_ASSUME_NONNULL_BEGIN

@class JCKeyboardObserver;

/**
 监听键盘通知的PopupUtil
 */
@interface JCPopupUtilsKeyboardSurpport : JCPopupUtils

@property (nonatomic, strong) JCKeyboardObserver *keyboardObserver;

@end

NS_ASSUME_NONNULL_END
