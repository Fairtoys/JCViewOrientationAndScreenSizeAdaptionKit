//
//  JCPopupUtilsLayoutAndAnimationFromRight.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/7.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtilsLayoutAndAnimationFromRight.h"
#import "JCPopupUtils.h"
#import <Masonry.h>
@implementation JCPopupUtilsLayoutAndAnimationFromRight

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        [self setLayoutBlock:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            [thePopUtils.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.trailing.equalTo(thePopUtils.containerView);
                make.width.mas_equalTo(weakSelf.width);
            }];
        }];
        
        [self.animationForShow setWillAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformMakeTranslation(weakSelf.width, 0);
        }];
        
        [self.animationForShow setAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformIdentity;
        }];
        
        [self.animationForHide setAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformMakeTranslation(weakSelf.width, 0);
        }];
    }
    return self;
}

@end
