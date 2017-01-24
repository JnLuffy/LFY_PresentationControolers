//
//  LFYAnimatedTransition.h
//  LFY_PresentationControolers
//
//  Created by IOS.Mac on 17/1/24.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFYAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)BOOL isPresenting;
-(instancetype)initWithPresenting:(BOOL) isPresenting;
@end
