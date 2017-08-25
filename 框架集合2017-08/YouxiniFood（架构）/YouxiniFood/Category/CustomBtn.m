//
//  CustomBtn.m
//  iFood
//
//  Created by 何青 on 2017/7/27.
//  Copyright © 2017年 何青. All rights reserved.
//

#import "CustomBtn.h"

const CGFloat WZFlashInnerCircleInitialRaius = 20;

@implementation CustomBtn

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (IS_IPHONE4S || IS_IPHONE5) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }else if(IS_IPHONE6_PLUS){
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }else{
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height *0.75;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = contentRect.size.height * 0.7;
    if (IS_IPHONE4S || IS_IPHONE5) {
        return CGRectMake(5, 5, imageW-10, imageH-10);
    }
    return CGRectMake(10, 10, imageW-20, imageH-20);
}


@end
