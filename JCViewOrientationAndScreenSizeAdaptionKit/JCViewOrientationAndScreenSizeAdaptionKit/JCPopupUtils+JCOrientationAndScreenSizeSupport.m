//
//  JCPopupUtils+OrientationSupport.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/9.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtils+JCOrientationAndScreenSizeSupport.h"

@implementation JCPopupUtils (JCOrientationAndScreenSizeSupport)
- (void)setStateForCurrentOrientationAndScreenSize{
    self.state = @(stateForCurrentOrientationAndCurrentScreenSize());
}

- (void)setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize{
    parseOrientationAndScreenSizeAndCallback(orientationAndScreenSize, ^(JCInterfaceOrientation stateParsed) {
        [self setLayoutAndAnimation:layoutAndAnimation forStateInt:stateParsed];
    });
}
@end


@implementation UIView (JCOrientationAndScreenSizeSupport)

- (void)poputils_setStateForCurrentOrientationAndScreenSize{
    [self.popUtils setStateForCurrentOrientationAndScreenSize];
}

- (void)poputils_setLayoutAndAnimation:(__kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize{
    [self.popUtils setLayoutAndAnimation:layoutAndAnimation forOrientationAndScreenSize:orientationAndScreenSize];
}

@end

@implementation UIViewController (JCOrientationAndScreenSizeSupport)
- (void)poputils_setStateForCurrentOrientationAndScreenSize{
    [self.view poputils_setStateForCurrentOrientationAndScreenSize];
}

- (void)poputils_setLayoutAndAnimation:(__kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize{
    [self.view poputils_setLayoutAndAnimation:layoutAndAnimation forOrientationAndScreenSize:orientationAndScreenSize];
}

@end
