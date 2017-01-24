//
//  LFYAnimatedTransition.m
//  LFY_PresentationControolers
//
//  Created by IOS.Mac on 17/1/24.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "LFYAnimatedTransition.h"

@implementation LFYAnimatedTransition

-(instancetype)initWithPresenting:(BOOL) isPresenting{
    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    BOOL isPresenting = (fromViewController == self.presentingViewController);

    if (self.isPresenting) {
        [self animatePresentationWithTransitionContext:transitionContext];
    }
    else {
        [self animateDismissalWithTransitionContext:transitionContext];
    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}





-(void) animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>) transitionContext {
    UIViewController *presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
//     设定被呈现的 view 一开始的位置，在屏幕下方
    presentedControllerView.frame = [transitionContext finalFrameForViewController:presentedController];
    CGRect rect = {{presentedControllerView.frame.origin.x,containerView.frame.origin.y},presentedControllerView.frame.size};
    presentedControllerView.frame = rect;
    [containerView addSubview:presentedControllerView];

    // 添加一个动画，让被呈现的 view 移动到最终位置，我们使用0.6的damping值让动画有一种duang-duang的感觉……
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        presentedControllerView.center = CGPointMake(presentedControllerView.center.x, containerView.bounds.size.height/2);
    } completion:^(BOOL finished) {
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

-(void) animateDismissalWithTransitionContext:(id<UIViewControllerContextTransitioning>) transitionContext {

    UIView* presentedControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView* containerView = [transitionContext containerView];
    
    // 添加一个动画，让被呈现的 view 移动到最终位置，我们使用0.6的damping值让动画有一种duang-duang的感觉……
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        presentedControllerView.center = CGPointMake(presentedControllerView.center.x, containerView.bounds.size.height);
    } completion:^(BOOL finished) {
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
