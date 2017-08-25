//
//  HYTabbarView.m
//  17zwd
//
//  Created by D_han on 13-11-21.
//  Copyright (c) 2013年 Hanyun. All rights reserved.
//

#import "HYTabbarView.h"

#define TOP SceneHeight - 64

@implementation HYTabbarView
/*
- (id)initWithFrame:(CGRect)frame
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, TOP)];
    
    [path addLineToPoint:CGPointMake(132, TOP)]; // 128 OK
//    [path addArcWithCenter:CGPointMake(160, TOP + 10) radius:33 startAngle:M_PI * 1.13f endAngle:-M_PI * 0.095625 clockwise:YES];   // start : 1.105    OK
     [path addArcWithCenter:CGPointMake(161, TOP + 15) radius:32 startAngle:M_PI * 1.1538f endAngle:-M_PI * 0.1455 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(SceneWidth, TOP)];
    [path addLineToPoint:CGPointMake(SceneWidth, SceneHeight)];
    [path addLineToPoint:CGPointMake(0, SceneHeight)];
    [path closePath];

    
    self = [super initWithFrame:CGPathGetBoundingBox(path.CGPath)];
    if (self) {
        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor clearColor];
        CGAffineTransform t = CGAffineTransformMakeTranslation(-CGRectGetMinX(self.frame), -CGRectGetMinY(self.frame));
        [[self layer] setPath:CGPathCreateCopyByTransformingPath(path.CGPath, &t)];
        [[self layer] setFillMode:kCAFillRuleNonZero];
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.8f]];
    }
    return self;
}*/

+(Class)layerClass
{
    return [CAShapeLayer class];
}

-(CAShapeLayer*)layer
{
    return (CAShapeLayer*)[super layer];
}


-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
//    [[self layer] setFillColor:backgroundColor.CGColor];
//    
//    [[self layer] setStrokeColor:backgroundColor.CGColor];
//    
//    
////    UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
////    [borderView setUserInteractionEnabled:NO];
//    
//    
//    
//    CAShapeLayer *shapeLayer = [self layer];
////    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    [shapeLayer setStrokeColor:[UIColor colorWithWhite:0.5 alpha:1].CGColor];
//    [shapeLayer setLineWidth:0.3f];
}


@end
