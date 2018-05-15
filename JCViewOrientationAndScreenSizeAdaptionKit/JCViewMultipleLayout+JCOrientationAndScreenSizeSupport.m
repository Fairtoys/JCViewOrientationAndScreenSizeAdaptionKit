//
//  JCViewMultipleLayout+JCOrientationAndScreenSizeSupport.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/9.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCViewMultipleLayout+JCOrientationAndScreenSizeSupport.h"

@implementation JCViewMultipleLayout (JCOrientationAndScreenSizeSupport)

- (void)setStateForCurrentOrientationAndScreenSize{
    self.state = @(stateForCurrentOrientationAndCurrentScreenSize());
}
- (void)setLayout:(dispatch_block_t)layout forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize{
    parseOrientationAndScreenSizeAndCallback(orientationAndScreenSize, ^(JCInterfaceOrientation stateParsed) {
        [self setLayout:layout forStateInt:stateParsed];
    });
}

@end

@implementation UIView (JCViewMultipleLayoutOrientationAndScreenSizeSupport)

- (void)jclayout_setStateForCurrentOrientationAndScreenSize{
    JCViewMultipleLayout *_viewlayout = self.jclayout_viewLayoutOrNilIfNotCreated;
    [_viewlayout setStateForCurrentOrientationAndScreenSize];
}

- (void)jclayout_enumerateSetStateForCurrentOrientationAndScreenSize{
    [self jclayout_setStateForCurrentOrientationAndScreenSize];
    
    for (UIView *subview in self.subviews) {
        [subview jclayout_enumerateSetStateForCurrentOrientationAndScreenSize];
    }
}

- (void)jclayout_setLayout:(nullable dispatch_block_t)layout forOrientationAndScreenSize:(JCInterfaceOrientation)orientationAndScreenSize{
    [self.jclayout_viewLayout setLayout:layout forOrientationAndScreenSize:orientationAndScreenSize];
}

@end
