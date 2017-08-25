//
//  CircleHeadView.h
//  CircleHeadViewDemo
//
//  Created by pigpigdaddy on 14-9-24.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CircleHeadViewContentResize,
    CircleHeadViewContentResizeAspect,
    CircleHeadViewContentResizeAspectFill
} CircleHeadViewContentType;

@interface CircleHeadView : UIView

@property (nonatomic, strong)UIColor *strokeColor;
@property (nonatomic, assign)CGFloat strokeWidth;
@property (nonatomic, strong)UIImage *originalImage;
@property (nonatomic, assign)BOOL needShadow;
@property (nonatomic, assign)CircleHeadViewContentType contentType;

- (void)setCircleImage:(UIImage *)image;

@end
