//
//  CustomPresentationController.m
//  LFY_PresentationControolers
//
//  Created by IOS.Mac on 17/1/24.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "CustomPresentationController.h"
@interface CustomPresentationController()
@property(nonatomic,strong)UIView *dimmingView;
@end

@implementation CustomPresentationController

//是在呈现过渡即将开始的时候被调用的。我们在这个方法中把半透明黑色背景 View 加入到 containerView 中，并且做一个 alpha 从0到1的渐变过渡动画。
- (void)presentationTransitionWillBegin{
    // 添加半透明背景 View 到我们的视图结构中
    self.dimmingView.frame = self.containerView.bounds;
    
    [self.containerView addSubview:self.dimmingView];
    [self.containerView addSubview:self.presentedView];
  
    
//    // 与过渡效果一起执行背景 View 的淡入效果
//    let transitionCoordinator = self.presentingViewController.transitionCoordinator()
//    transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
//        self.dimmingView.alpha  = 1.0
//    }, completion:nil)
//}
    
    
    // Get the transition coordinator for the presentation so we can
    // fade in the dimmingView alongside the presentation animation.
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.5f;
    } completion:NULL];
}

-(void)presentationTransitionDidEnd:(BOOL)completed{
    if(!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

-(void)dismissalTransitionWillBegin{
    // Get the transition coordinator for the dismissal so we can
    // fade out the dimmingView alongside the dismissal animation.
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

-(void)dismissalTransitionDidEnd:(BOOL)completed{
    // The value of the 'completed' argument is the same value passed to the
    // -completeTransition: method by the animator.  It may
    // be NO in the case of a cancelled interactive transition.
    if (completed == YES)
    {
        // The system removes the presented view controller's view from its
        // superview and disposes of the containerView.  This implicitly
        // removes the views created in -presentationTransitionWillBegin: from
        // the view hierarchy.  However, we still need to relinquish our strong
        // references to those view.
        self.dimmingView = nil;
    }
}


@end
