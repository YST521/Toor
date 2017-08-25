//
//  UIImage+CricleImage.m
//  百思不得其姐
//
//  Created by lanou3g on 16/6/2.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "UIImage+CricleImage.h"

@implementation UIImage (CricleImage)
-(UIImage*)circleImage{


    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;


}
@end
