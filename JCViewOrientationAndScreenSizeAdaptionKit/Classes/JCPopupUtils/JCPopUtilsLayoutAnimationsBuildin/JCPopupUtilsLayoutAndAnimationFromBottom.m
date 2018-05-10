//
//  JCPopupUtilsLayoutAndAnimationFromBottom.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/7.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtilsLayoutAndAnimationFromBottom.h"
#import "JCPopupUtils.h"
#import <Masonry.h>

@implementation JCPopupUtilsLayoutAndAnimationFromBottom

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        [self setLayoutBlock:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            [thePopUtils.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.bottom.equalTo(thePopUtils.containerView);
                make.height.mas_equalTo(weakSelf.height);
            }];
        }];
        
        [self.animationForShow setWillAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformMakeTranslation(0, weakSelf.height);
        }];
        
        [self.animationForShow setAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformIdentity;
        }];
        
        [self.animationForHide setWillAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            
        }];
        
        [self.animationForHide setAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformMakeTranslation(0, weakSelf.height);
        }];
    }
    return self;
}

@end
