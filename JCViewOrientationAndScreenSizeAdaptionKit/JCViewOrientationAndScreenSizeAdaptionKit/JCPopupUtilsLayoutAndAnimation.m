//
//  JCPopupUtilsLayoutAndAnimation.m
//  JCPopupContainerViewDemo
//
//  Created by Cerko on 2018/5/5.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtilsLayoutAndAnimation.h"

@implementation JCPopupUtilsAnimation

- (instancetype)init{
    if (self = [super init]) {
        _duration = 0.25;
    }
    return self;
}

@end

@implementation JCPopupUtilsLayoutAndAnimation

- (JCPopupUtilsAnimation *)animationForShow{
    if (!_animationForShow) {
        _animationForShow = [[JCPopupUtilsAnimation alloc] init];
    }
    return _animationForShow;
}
- (JCPopupUtilsAnimation *)animationForHide{
    if (!_animationForHide) {
        _animationForHide = [[JCPopupUtilsAnimation alloc] init];
    }
    return _animationForHide;
}

@end
