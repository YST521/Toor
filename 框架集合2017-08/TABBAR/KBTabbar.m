//
//  KBTabbar.m
//  KBTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "KBTabbar.h"

@implementation KBTabbar


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_U3dSelected"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"tabBar_U3d"] forState:UIControlStateNormal];
        btn.bounds = CGRectMake(0, 0, 64, 64);
        self.centerBtn = btn;
        [self addSubview:btn];
        self.backgroundImage = [self imageWithColor:[UIColor whiteColor]];
        self.shadowImage = [[UIImage alloc]init];
    }
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.centerBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.3);
    
    int index = 0;
    CGFloat wigth = self.bounds.size.width / 5;
    
    for (UIView* sub in self.subviews) {
        
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height );
            
            index++;
            
            if (index == 2) {
                index++;
            }
        }
    }
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.hidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            return self.centerBtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
