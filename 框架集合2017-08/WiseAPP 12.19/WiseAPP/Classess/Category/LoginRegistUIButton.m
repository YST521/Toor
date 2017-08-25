//
//  LoginRegistUIButton.m
//  百思不得其姐
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LoginRegistUIButton.h"
#import "UIView+YSTExtension.h"



@implementation LoginRegistUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//
- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)layoutSubviews{

    [super layoutSubviews];
//buttom   默认图片在左 文字在右
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
     self.titleLabel.center = CGPointMake(self.size.width/2+14, CGRectGetMaxY(self.imageView.frame)+2);

}


@end
