//
//  WiseTabbar.m
//  WiseAPP
//
//  Created by app on 16/10/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WiseTabbar.h"

@implementation WiseTabbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                [btn setImage:[UIImage imageNamed:@"tabbar_message"] forState:UIControlStateNormal];
//                btn.bounds = CGRectMake(0, 0, 64, 64);
//                self.centerBtn = btn;
//                [self addSubview:btn];
        //tabbar_message.png
        LoginRegistUIButton*btn = [[LoginRegistUIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"tabbar-icon_message"] forState:UIControlStateNormal];
        //btn.backgroundColor= [UIColor redColor];
        [btn setTitle:@"消息" forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        btn.bounds = CGRectMake(0, 0, 60, 70);
        self.centerBtn = btn;
        [self addSubview:btn];
//
        
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
            
            sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - 2);
            
            index++;
            
            if (index == 2) {
                index++;
            }
        }
    }
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            return self.centerBtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }else {
        return [super hitTest:point withEvent:event];
    }
    
    
}



@end
