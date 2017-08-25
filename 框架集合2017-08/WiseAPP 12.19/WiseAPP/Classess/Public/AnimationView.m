//
//  AnimationView.m
//  WiseAPP
//
//  Created by yst911521 on 2016/12/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        [self addView];
        
    }
    return self;
}

-(void)addView{
    
    self.titleLa=[[UILabel alloc]init];
    self.titleLa.frame =CGRectMake(0, 0, PROPORTION_WIDTH(100), PROPORTION_HIGHT(100));
    self.titleLa.center =self.center;
    [self addSubview:self.titleLa];

    [UIView animateWithDuration:2 animations:^{
        
        self.titleLa.hidden =NO;
    } completion:^(BOOL finished) {
        
        self.titleLa.hidden=YES;
    }];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
