//
//  JCPopupUtilsKeyboardSurpport.m
//  JCViewOrientationAndScreenSizeAdaptionKit
//
//  Created by huajiao on 2018/6/6.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import "JCPopupUtilsKeyboardSurpport.h"
#import "JCKeyboardObserver.h"
#import <Masonry/Masonry.h>

@implementation JCPopupUtilsKeyboardSurpport

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.keyboardObserver registerObserver];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc{
    [_keyboardObserver unrigisterObserver];
}

- (JCKeyboardObserver *)keyboardObserver{
    if (!_keyboardObserver) {
        _keyboardObserver = [[JCKeyboardObserver alloc] init];
        __weak typeof(self) weakSelf = self;
        [_keyboardObserver setOnKeyboardWillShowBlock:^(CGRect keyboardEndFrame, NSTimeInterval animationDuration, UIViewAnimationCurve animationCurve) {
            if (!weakSelf.isViewShowing) {
                return ;
            }
            [weakSelf setOnClickBackgroundViewBlock:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
                [weakSelf.superView endEditing:YES];
            }];
            
            [UIView animateWithDuration:animationDuration delay:0 options:animationCurve<<16 animations:^{
                weakSelf.view.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(keyboardEndFrame));
                weakSelf.backgroundView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(keyboardEndFrame));
            } completion:^(BOOL finished) {
                
            }];
        }];
        [_keyboardObserver setOnKeyboardWillHideBlock:^(CGRect keyboardEndFrame, NSTimeInterval animationDuration, UIViewAnimationCurve animationCurve) {
            if (!weakSelf.isViewShowing) {
                return ;
            }
            [weakSelf setOnClickBackgroundViewBlock:NULL];
            
            [UIView animateWithDuration:animationDuration delay:0 options:animationCurve<<16 animations:^{
                weakSelf.view.transform = CGAffineTransformIdentity;
                weakSelf.backgroundView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    return _keyboardObserver;
}

- (void)showView:(UIView *)view inSuperView:(UIView *)superView viewWillShowBlock:(dispatch_block_t)viewWillShowBlock viewDidShowBlock:(dispatch_block_t)viewDidShowBlock{
    __weak typeof(self) weakSelf = self;
    [super showView:view inSuperView:superView viewWillShowBlock:viewWillShowBlock viewDidShowBlock:^(){
        [weakSelf.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerX.equalTo(weakSelf.containerView);
            make.top.equalTo(weakSelf.view.mas_bottom);
        }];
        if (viewDidShowBlock) {
            viewDidShowBlock();
        }
    }];
}

@end
