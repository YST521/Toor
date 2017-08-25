//
//  UIimage+round.h
//  WiseAPP
//
//  Created by app on 16/10/28.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIimage_round : UIImage
/**
 *  把图片裁剪成圆形
 *
 *  @param name        图片名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 圆形有边框的图片
 */

+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
