//
//  UIimageScaleImage.h
//  AFN封装
//
//  Created by app on 16/10/25.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIimageScaleImage : UIImage
//上传压缩图片
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
