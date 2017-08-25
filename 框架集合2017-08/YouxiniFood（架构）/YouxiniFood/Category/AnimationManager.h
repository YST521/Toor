//
//  AnimationManager.h
//  YouxiniFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KAnimationType){
    
    KAnimationTypeLeftToRight = 0,
    KAnimationTypeRightToLeft
};

@interface AnimationManager : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) KAnimationType type;
- (instancetype)initWithType:(KAnimationType)type;
@end
