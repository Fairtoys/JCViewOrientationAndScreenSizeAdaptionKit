//
//  JCPopupUtils.m
//  JCPopupContainerViewDemo
//
//  Created by huajiao on 2018/5/3.
//  Copyright © 2018年 huajiao. All rights reserved.
//

#import "JCPopupUtils.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import "JCPopupUtilsLayoutAndAnimation.h"
#import "JCStateStorage.h"

@interface JCPopupUtils () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) JCStateStorage <id<NSCopying>, JCPopupUtilsLayoutAndAnimation*> *stateStorage;

@property (nonatomic, strong) UIView *containerView;//整个大的容器
@property (nonatomic, strong) UIView *backgroundView;//当view的大小不填满整个containerView时，用来设置背景色
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;//点击事件，点击背景

@property (nonatomic, weak, nullable) __kindof UIView *view;//当前弹出的view

@property (nonatomic, copy, nullable) dispatch_block_t viewWillShowInnerBlock;
@property (nonatomic, copy, nullable) dispatch_block_t viewDidShowInnerBlock;
@property (nonatomic, copy, nullable) dispatch_block_t viewWillHideInnerBlock;
@property (nonatomic, copy, nullable) dispatch_block_t viewDidHideInnerBlock;
- (void)relayout;//会调用layoutAndAnimation中的layoutblock来重新布局

@end

@implementation JCPopupUtils

- (JCStateStorage<id<NSCopying>,JCPopupUtilsLayoutAndAnimation *> *)stateStorage{
    if (!_stateStorage) {
        _stateStorage = [[JCStateStorage alloc] init];
        __weak typeof(self) weakSelf = self;
        [_stateStorage setOnValueDidSetBlock:^(JCStateStorage * _Nonnull theStateStorage) {
             [weakSelf relayout];
        }];
    }
    return _stateStorage;
}

- (void)setLayoutAndAnimationNormal:(JCPopupUtilsLayoutAndAnimation *)layoutAndAnimationNormal{
    //如果当前状态没有，则设置默认状态
    [self.stateStorage setValueForDefault:layoutAndAnimationNormal];
}
- (JCPopupUtilsLayoutAndAnimation *)layoutAndAnimationNormal{
    return self.stateStorage.valueForDefault;
}

- (void)setLayoutAndAnimation:(nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forState:(id <NSCopying>)state{
    [self.stateStorage setValue:layoutAndAnimation forState:state];
}

- (void)setLayoutAndAnimation:(__kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation forStateInt:(NSInteger)state{
    [self setLayoutAndAnimation:layoutAndAnimation forState:@(state)];
}

- (nullable __kindof JCPopupUtilsLayoutAndAnimation *)layoutAndAnimationForState:(id <NSCopying>)state{
    return [self.stateStorage valueForState:state];
}
- (JCPopupUtilsLayoutAndAnimation *)layoutAndAnimationForStateInt:(NSInteger)state{
    return [self layoutAndAnimationForState:@(state)];
}

- (void)setState:(id<NSCopying>)state{
    self.stateStorage.state = state;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        [_containerView addSubview:self.backgroundView];
        [_containerView addGestureRecognizer:self.tapGesture];
    }
    return _containerView;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}

- (UIView *)superView{
    return _containerView.superview;
}

- (UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackgroundView:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    for (UIView *view in self.containerView.subviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            return NO;
        }
    }
    return YES;
}

- (JCPopupUtilsLayoutAndAnimation *)layoutAndAnimation{
    return self.stateStorage.value;
}


- (void)onClickBackgroundView:(UITapGestureRecognizer *)sender{
    if (self.onClickBackgroundViewBlock) {
        self.onClickBackgroundViewBlock(self);
    }else{
        [self hideView];
    }
}

- (void)showView:(UIView *)view inSuperView:(UIView *)superView viewWillShowBlock:(nullable dispatch_block_t)viewWillShowBlock viewDidShowBlock:(nullable dispatch_block_t)viewDidShowBlock{
    
    if (self.isViewShowing) {
        return ;
    }
    
    if (self.viewWillShowInnerBlock) {
        self.viewWillShowInnerBlock();
    }
    
    if (viewWillShowBlock) {
        viewWillShowBlock();
    }
    if (self.viewWillShowBlock) {
        self.viewWillShowBlock();
    }
    self.view = view;
    [superView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    [self.containerView addSubview:view];
    
    if (self.layoutAndAnimation.layoutBlock) {
        self.layoutAndAnimation.layoutBlock(self);
    }
    //动画
    BOOL userInteractionEnabled = superView.userInteractionEnabled;
    superView.userInteractionEnabled = NO;
    JCPopupUtilsAnimation *animationForShow = self.layoutAndAnimation.animationForShow;
    if (animationForShow.willAnimations) {
        animationForShow.willAnimations(self);
    }
    [UIView animateWithDuration:animationForShow.duration delay:animationForShow.delay options:animationForShow.options animations:^{
        if (animationForShow.animations) {
            animationForShow.animations(self);
        }
    } completion:^(BOOL finished) {
        
        superView.userInteractionEnabled = userInteractionEnabled;
        if (animationForShow.completion) {
            animationForShow.completion(finished);
        }
        if (self.viewDidShowInnerBlock) {
            self.viewDidShowInnerBlock();
        }
        if (viewDidShowBlock) {
            viewDidShowBlock();
        }
        if (self.viewDidShowBlock) {
            self.viewDidShowBlock();
        }
    }];
    
}

- (void)showView:(UIView *)view inSuperView:(UIView *)superView{
    [self showView:view inSuperView:superView viewWillShowBlock:NULL viewDidShowBlock:NULL];
}

- (void)showViewController:(UIViewController *)viewController inParentViewController:(UIViewController *)parentViewController viewWillShowBlock:(dispatch_block_t)viewWillShowBlock viewDidShowBlock:(dispatch_block_t)viewDidShowBlock{
    if (self.isViewShowing) {
        return ;
    }
    __weak typeof(self) weakSelf = self;
    [self setViewWillShowInnerBlock:^{
        [parentViewController addChildViewController:viewController];
        weakSelf.viewWillShowInnerBlock = NULL;
    }];
    [self setViewDidShowInnerBlock:^{
        [viewController didMoveToParentViewController:parentViewController];
        weakSelf.viewDidShowInnerBlock = NULL;
    }];
    [self setViewWillHideInnerBlock:^{
        [viewController willMoveToParentViewController:nil];
        weakSelf.viewWillHideInnerBlock = NULL;
    }];
    [self setViewDidHideInnerBlock:^{
        [viewController removeFromParentViewController];
        weakSelf.viewDidHideInnerBlock = NULL;
    }];
    [self showView:viewController.view inSuperView:parentViewController.view viewWillShowBlock:viewWillShowBlock viewDidShowBlock:viewDidShowBlock];
}

- (void)showViewController:(UIViewController *)viewController inParentViewController:(UIViewController *)parentViewController{
    [self showViewController:viewController inParentViewController:parentViewController viewWillShowBlock:NULL viewDidShowBlock:NULL];
}

- (void)hideViewWillHideBlock:(dispatch_block_t)viewWillHideBlock viewDidHideBlock:(dispatch_block_t)viewDidHideBlock{
    if (!self.isViewShowing) {
        return ;
    }

    if (self.viewWillHideInnerBlock) {
        self.viewWillHideInnerBlock();
    }
    
    if (viewWillHideBlock) {
        viewWillHideBlock();
    }
    
    if (self.viewWillHideBlock) {
        self.viewWillHideBlock();
    }
    //动画
    UIView *superView = self.containerView.superview;
    BOOL userInteractionEnabled = superView.userInteractionEnabled;
    superView.userInteractionEnabled = NO;
    JCPopupUtilsAnimation *animationForHide = self.layoutAndAnimation.animationForHide;
    if (animationForHide.willAnimations) {
        animationForHide.willAnimations(self);
    }
    [UIView animateWithDuration:animationForHide.duration delay:animationForHide.delay options:animationForHide.options animations:^{
        if (animationForHide.animations) {
            animationForHide.animations(self);
        }
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        self.view = nil;
        
        //backgroundView 和containerView每次都重新创建，防止上次布局修改属性之后有残余
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        
        [self.containerView removeFromSuperview];
        self.containerView = nil;
        superView.userInteractionEnabled = userInteractionEnabled;
        
        if (self.viewDidHideInnerBlock) {
            self.viewDidHideInnerBlock();
        }
        
        if (viewDidHideBlock) {
            viewDidHideBlock();
        }
        
        if (self.viewDidHideBlock) {
            self.viewDidHideBlock();
        }
        
        if (animationForHide.completion) {
            animationForHide.completion(finished);
        }
    }];
}

- (void)hideView{
    [self hideViewWillHideBlock:NULL viewDidHideBlock:NULL];
}

- (void)hideViewControllerWillHideBlock:(dispatch_block_t)viewWillHideBlock viewDidHideBlock:(dispatch_block_t)viewDidHideBlock{
    [self hideViewWillHideBlock:viewWillHideBlock viewDidHideBlock:viewDidHideBlock];
}

- (void)hideViewController{
    [self hideViewControllerWillHideBlock:NULL viewDidHideBlock:NULL];
}

- (void)hideLastViewAndShowView:(UIView *)view inSuperView:(UIView *)superView{
    dispatch_block_t block = ^{
        [self showView:view inSuperView:superView];
    };
    
    if (self.isViewShowing) {
        [self hideViewWillHideBlock:NULL viewDidHideBlock:block];
        return ;
    }
    
    block();
}

- (void)hideLastViewControllerAndShowViewController:(UIViewController *)viewController inParentViewController:(UIViewController *)parentViewController{
    dispatch_block_t block = ^(){
        [self showViewController:viewController inParentViewController:parentViewController];
    };
    
    if (self.isViewShowing) {
        [self hideViewControllerWillHideBlock:NULL viewDidHideBlock:block];
        return;
    }
    block();
}

- (void)relayout{
    if (_view.superview) {
        if (self.layoutAndAnimation.layoutBlock) {
            self.layoutAndAnimation.layoutBlock(self);
        }
    }
}

- (BOOL)isViewShowing{
    //9.1 系统不能直接用_view.superview来判断，有问题
    BOOL isViewShowing = _view.superview ? YES : NO;
//    BOOL isViewShowing = ((BOOL)_view.superview);
    return isViewShowing;
}

@end

@implementation UIView (JCPopupUtils)

- (void)setPopUtils:(JCPopupUtils *)popUtils{
    objc_setAssociatedObject(self, @selector(popUtils), popUtils, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JCPopupUtils *)popUtils{
    JCPopupUtils *_popUtils = objc_getAssociatedObject(self, _cmd);
    if (!_popUtils) {
        _popUtils = [[JCPopupUtils alloc] init];
        self.popUtils = _popUtils;
    }
    return _popUtils;
}

- (void)poputils_showView:(UIView *)view{
    [self.popUtils showView:view inSuperView:self];
}

- (void)poputils_showView:(UIView *)view viewWillShowBlock:(dispatch_block_t)viewWillShowBlock viewDidShowBlock:(dispatch_block_t)viewDidShowBlock{
    [self.popUtils showView:view inSuperView:self viewWillShowBlock:viewWillShowBlock viewDidShowBlock:viewDidShowBlock];
}

- (void)poputils_hideView{
    [self.popUtils hideView];
}

- (void)poputils_hideViewWillHideBlock:(dispatch_block_t)viewWillHideBlock viewDidHideBlock:(dispatch_block_t)viewDidHideBlock{
    [self.popUtils hideViewWillHideBlock:viewWillHideBlock viewDidHideBlock:viewDidHideBlock];
}

- (void)poputils_hideLastViewAndShowView:(UIView *)view{
    [self.popUtils hideLastViewAndShowView:view inSuperView:self];
}

@end

@implementation UIViewController (JCPopupUtils)

- (void)setPopUtils:(__kindof JCPopupUtils *)popUtils{
    self.view.popUtils = popUtils;
}
- (JCPopupUtils *)popUtils{
    return self.view.popUtils;
}
- (void)poputils_showController:(UIViewController *)controller{
    [self.popUtils showViewController:controller inParentViewController:self];
}

- (void)poputils_showController:(UIViewController *)controller viewWillShowBlock:(dispatch_block_t)viewWillShowBlock viewDidShowBlock:(dispatch_block_t)viewDidShowBlock{
    [self.popUtils showViewController:controller inParentViewController:self viewWillShowBlock:viewWillShowBlock viewDidShowBlock:viewDidShowBlock];
}

- (void)poputils_hideController{
    [self.popUtils hideViewController];
}

- (void)poputils_hideControllerViewWillHideBlock:(dispatch_block_t)viewWillHideBlock viewDidHideBlock:(dispatch_block_t)viewDidHideBlock{
    [self.popUtils hideViewControllerWillHideBlock:viewWillHideBlock viewDidHideBlock:viewDidHideBlock];
}

- (void)poputils_hideLastViewAndShowController:(UIViewController *)controller{
    [self.popUtils hideLastViewControllerAndShowViewController:controller inParentViewController:self];
}

@end
