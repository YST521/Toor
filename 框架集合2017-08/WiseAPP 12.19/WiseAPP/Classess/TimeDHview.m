//
//  TimeDHview.m
//  SelectTime
//
//  Created by app on 16/11/15.
//  Copyright © 2016年 i. All rights reserved.
//

#import "TimeDHview.h"

@implementation TimeDHview
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addView];
        
    }

    return self;

}
-(void)addView{
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    bgView.userInteractionEnabled = YES;
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    self.titleLa=[[UILabel alloc]init];
    self.titleLa.frame =titleBg.bounds;
    self.titleLa.textColor =[UIColor whiteColor];
    self.titleLa.textAlignment = NSTextAlignmentCenter;
    [titleBg addSubview:self.titleLa];
    
    self.hourJiaBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.hourJiaBtn.frame = CGRectMake(PROPORTION_WIDTH(134), CGRectGetMaxY(titleBg.frame)+20, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
    self.hourJiaBtn.backgroundColor=[UIColor redColor];
    [ bgView addSubview:self.hourJiaBtn];
    [self.hourJiaBtn setTitle:@"+" forState:(UIControlStateNormal)];
    [self.hourJiaBtn setImage:[UIImage imageNamed:@"home_jiahao"] forState:(UIControlStateNormal)];
     //[self.hourJiaBtn setImage:[UIImage imageNamed:@"home_time_jia"] forState:(UIControlStateHighlighted)];
    //home_jiahao
    self.mineJiaBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
     self.mineJiaBtn.frame = CGRectMake(CGRectGetMaxX(self.hourJiaBtn.frame)+20, CGRectGetMaxY(titleBg.frame)+20,  PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
     self.mineJiaBtn.backgroundColor=[UIColor redColor];
    [ bgView addSubview: self.mineJiaBtn];
       [self.mineJiaBtn setImage:[UIImage imageNamed:@"home_jiahao"] forState:(UIControlStateNormal)];

    UIImageView* hourBg =[[UIImageView alloc]init];
    hourBg.frame =CGRectMake(PROPORTION_WIDTH(134), CGRectGetMaxY( self.mineJiaBtn.frame)+20, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
    [bgView addSubview:hourBg];
    [hourBg setImage:[UIImage imageNamed:@"home_time_la"]];
    
    self.hourLa=[[UILabel alloc]init];
    self.hourLa.frame = hourBg.bounds;
    //self.hourLa.backgroundColor=[UIColor greenColor];
    [hourBg addSubview:self.hourLa];
    self.hourLa.textAlignment = NSTextAlignmentCenter;
    
    UIImageView* mineBg =[[UIImageView alloc]init];
    mineBg.frame =CGRectMake(CGRectGetMaxX(hourBg.frame)+20, CGRectGetMaxY (self.mineJiaBtn.frame)+20, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
    [bgView addSubview:mineBg];
    [mineBg setImage:[UIImage imageNamed:@"home_time_la"]];

    self.mineLa=[[UILabel alloc]init];
    self.mineLa.frame = mineBg.bounds;
   //self.mineLa.backgroundColor=[UIColor yellowColor];
    [mineBg addSubview:self.mineLa];
    self.mineLa.textAlignment = NSTextAlignmentCenter;
  
     self.hourJianBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.hourJianBtn.frame = CGRectMake(PROPORTION_WIDTH(134), CGRectGetMaxY(mineBg.frame)+20, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
  self.hourJianBtn.backgroundColor=[UIColor cyanColor];
    [ bgView addSubview: self.hourJianBtn];;
      [self.hourJianBtn setTitle:@"-" forState:(UIControlStateNormal)];
     [self.hourJianBtn setImage:[UIImage imageNamed:@"home_jianhao"] forState:(UIControlStateNormal)];
    
    self.mineJianBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.mineJianBtn.frame = CGRectMake(CGRectGetMaxX(self.hourJianBtn.frame)+20, CGRectGetMaxY(mineBg.frame)+20, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
    self.mineJianBtn.backgroundColor=[UIColor blueColor];
    [ bgView addSubview: self.mineJianBtn];;
     [self.mineJianBtn setImage:[UIImage imageNamed:@"home_jianhao"] forState:(UIControlStateNormal)];
    
    self.timeDoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.timeDoneBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(self.mineJianBtn.frame)+30, (bgView.width-PROPORTION_WIDTH(16)*2-10), STANDARD_HEIGHT);
    KUIbutton( self.timeDoneBtn);
    KUIbuttonClick(self.timeDoneBtn);
    [self.timeDoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.timeDoneBtn];
    
    
    self.hidden = NO;
    
 
    


}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
