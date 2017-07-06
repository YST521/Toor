//
//  HeaderView.m
//  Hitest
//
//  Created by yishanliang on 2017/6/2.
//  Copyright © 2017年 youxin. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
    
}






#pragma mark  -- handle
- (UIView *)getTargetView:(UIView *)view point:(CGPoint)point event:(UIEvent *)event
{
    
    __block UIView *subView;
    
    //逆序 由层级最低 也就是最上层的子视图开始
    [view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //point 从view 转到 obj中
        CGPoint hitPoint = [obj convertPoint:point fromView:view];
        //        NSLog(@"%@ - %@",NSStringFromCGPoint(point),NSStringFromCGPoint(hitPoint));
        
        if([obj pointInside:hitPoint withEvent:event])//在当前视图范围内
        {
            if(obj.subviews.count != 0)
            {
                //如果有子视图 递归
                subView = [self getTargetView:obj point:hitPoint event:event];
                
                if(!subView)
                {
                    //如果没找到 提交当前视图
                    subView = obj;
                }
            }
            else
            {
                subView = obj;
            }
            
            *stop = YES;
        }
        else//不在当前视图范围内
        {
            if(obj.subviews.count != 0)
            {
                //如果有子视图 递归
                subView = [self getTargetView:obj point:hitPoint event:event];
            }
        }
        
    }];
    
    return subView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view = [super hitTest:point withEvent:event];
    
    //由于响应链在此处断开，我们就去手动寻找最终响应的子视图，传入本 view 遍历本 view 的子视图
    UIView *tempview = [self getTargetView:self point:point event:event];
    if (tempview) {
        view = tempview;
    }
    
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //    CGPoint yellowPoint =[_yellowView convertPoint:point fromView:self];
    //    if ([_yellowView pointInside:yellowPoint withEvent:event]) return NO;
    
    return [super pointInside:point withEvent:event];
}

@end
