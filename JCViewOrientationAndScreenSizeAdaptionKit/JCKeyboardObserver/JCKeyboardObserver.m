//
//  HJKeyboardObserver.m
//  living
//
//  Created by huajiao on 2018/3/1.
//  Copyright © 2018年 MJHF. All rights reserved.
//

#import "JCKeyboardObserver.h"

@implementation JCKeyboardObserver

- (void)registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification   object:nil];
}

- (void)unrigisterObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onReceiveKeyboardWillShowNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    //
    // Get keyboard animation.
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = (UIViewAnimationCurve)curveValue.intValue;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    NSLog(@"will show animation duration :%@ , curve:%@, frame:%@", durationValue, curveValue, userInfo[UIKeyboardFrameEndUserInfoKey]);
    
    if (self.onKeyboardWillShowBlock) {
        self.onKeyboardWillShowBlock(keyboardEndFrame, animationDuration, animationCurve);
    }
    
}

- (void)onReceiveKeyboardWillHideNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    //
    // Get keyboard animation.
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = (UIViewAnimationCurve)curveValue.intValue;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    NSLog(@"will hide animation duration :%@ , curve:%@, frame:%@", durationValue, curveValue, userInfo[UIKeyboardFrameEndUserInfoKey]);
    
    if (self.onKeyboardWillHideBlock) {
        self.onKeyboardWillHideBlock(keyboardEndFrame, animationDuration, animationCurve);
    }
}

@end
