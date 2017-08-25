//
//  ZonggongshiView.m
//  WiseAPP
//
//  Created by app on 16/10/31.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ZonggongshiView.h"

@implementation ZonggongshiView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addView];
    }
    return  self;
}

-(void)addView{
    self.backgroundColor=GlobBackGroundColor;
    self.upView=[[UIView alloc]init];
    self.upView.frame = CGRectMake(0, 0, PROPORTION_WIDTH(120), PROPORTION_HIGHT(120));
    self.upView.center = CGPointMake(SCREEN_WIDTH/2, PROPORTION_HIGHT(60)+10);
    [self addSubview:self.upView];
    self.upView.layer.cornerRadius = self.upView.width/2;
    self.upView.layer.borderWidth = 2;
    self.upView.layer.borderColor=[UIColor blueColor].CGColor;
   
    UILabel*upLa=[[UILabel alloc]init];
    upLa.frame = CGRectMake(self.upView.width/5, self.upView.height/4, self.upView.width-(self.upView.width/5)*2, 20);
    upLa.text = @"总计工时";
    upLa.font =[UIFont systemFontOfSize:14];
    upLa.textColor = textCententColor;
    upLa.textAlignment =NSTextAlignmentCenter;
    [self.upView addSubview:upLa];
    
    self.gongshiNumLa=[[UILabel alloc]init];
    self.gongshiNumLa.frame =CGRectMake(upLa.x, CGRectGetMaxY(upLa.frame), upLa.width, 30);
    self.gongshiNumLa.textColor =[UIColor redColor];
    self.gongshiNumLa.font =[UIFont systemFontOfSize:14];
    self.gongshiNumLa.text =@"0";
    self.gongshiNumLa.textAlignment =NSTextAlignmentCenter;
    [self.upView addSubview:self.gongshiNumLa];
    
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
