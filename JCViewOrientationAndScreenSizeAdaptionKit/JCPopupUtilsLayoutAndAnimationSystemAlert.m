//
//  JCPopupUtilsLayoutAndAnimationSystemAlert.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/7.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtilsLayoutAndAnimationSystemAlert.h"
#import "JCPopupUtils.h"
#import <Masonry.h>

@implementation JCPopupUtilsLayoutAndAnimationSystemAlert


- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        [self setLayoutBlock:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            [thePopUtils.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(thePopUtils.containerView);
                if (!CGSizeEqualToSize(CGSizeZero, weakSelf.size)) {
                    make.size.mas_equalTo(weakSelf.size);
                }
            }];
        }];
        
        [self.animationForShow setWillAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            CGFloat height = CGRectGetMidY(thePopUtils.superView.bounds);
            if (!CGSizeEqualToSize(CGSizeZero, weakSelf.size)) {
                height = height + weakSelf.size.height / 2;
            }else{
                height = height + thePopUtils.view.intrinsicContentSize.height / 2;
            }
            thePopUtils.view.transform = CGAffineTransformMakeTranslation(0, height);
        }];
        
        [self.animationForShow setAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            thePopUtils.view.transform = CGAffineTransformIdentity;
        }];
        
        [self.animationForHide setAnimations:^(__kindof JCPopupUtils * _Nonnull thePopUtils) {
            CGFloat height = CGRectGetMidY(thePopUtils.superView.bounds);
            if (!CGSizeEqualToSize(CGSizeZero, weakSelf.size)) {
                height = height + weakSelf.size.height / 2;
            }else{
                height = height + thePopUtils.view.intrinsicContentSize.height / 2;
            }
            thePopUtils.view.transform = CGAffineTransformMakeTranslation(0, height);
        }];
    }
    return self;
}

@end
