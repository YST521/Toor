//
//  CustomButton+Extension.m
//  WiseAPP
//
//  Created by app on 16/10/12.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CustomButton+Extension.h"

@implementation CustomButton_Extension
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        [self CreatButton];
    }

    return self;
}

-(void)CreatButton{

    UIButton*button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame =  self.bounds;
    [button setBackgroundImage:[UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:@"loginbuttonclick.png"] forState:(UIControlStateHighlighted)];
    button.titleLabel.font =[UIFont systemFontOfSize:14];
    [self addSubview:button];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
