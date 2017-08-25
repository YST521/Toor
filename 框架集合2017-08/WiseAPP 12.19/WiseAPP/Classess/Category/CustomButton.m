//
//  CustomButton.m
//  WiseAPP
//
//  Created by app on 16/10/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self =[super initWithFrame:frame]) {
        
        [self addView];
    }
    return  self;
}
-(void)addView{
    
    self.loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
   self.loginBtn.frame =  self.bounds;
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"logo.png"] forState:(UIControlStateNormal)];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"loginbuttonclick.png"] forState:(UIControlStateHighlighted)];
    self.loginBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [self addSubview:self.loginBtn];
    
    
}


@end
