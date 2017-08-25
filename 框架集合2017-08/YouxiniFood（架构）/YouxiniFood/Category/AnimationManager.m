//
//  AnimationManager.m
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "AnimationManager.h"
#import "MainNavigationController.h"
@implementation AnimationManager
- (instancetype)initWithType:(KAnimationType)type {
    
    if (self = [super init]) {
        
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 获取fromVc和toVc
    
    MainNavigationController *fromVc = (MainNavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    MainNavigationController *toVc = (MainNavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toVc.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         fromVc.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}
@end
