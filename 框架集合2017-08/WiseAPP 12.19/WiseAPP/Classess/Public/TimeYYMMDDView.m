//
//  TimeYYMMDDView.m
//  WiseAPP
//
//  Created by app on 16/11/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "TimeYYMMDDView.h"



@implementation TimeYYMMDDView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        [self addView];
        
    }
    return  self;
}
-(void)addView{
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(250));
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
    
  self.userInteractionEnabled=YES;
  bgView.userInteractionEnabled =YES;
    
    for (int i = 0 ; i < 5; i++) {
     // 圆角按钮
       UIButton* dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        dateBtn.frame =CGRectMake(i*(PROPORTION_WIDTH(44)+PROPORTION_WIDTH(15))+PROPORTION_WIDTH(44),CGRectGetMaxY(self.titleLa.frame)+10, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));

       // [dateBtn setBackgroundImage:[UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
        
        [dateBtn setBackgroundImage:[UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
        [dateBtn setImage:[UIImage imageNamed:@"home_jiahao"] forState:(UIControlStateNormal)];
        
      
        [bgView addSubview:dateBtn];
        self.btn =dateBtn;
        self.btn.tag = 600+ i;
    }
    

    for (int i = 0 ; i < 5; i++) {
        
        UIImageView* hourBg =[[UIImageView alloc]init];
            hourBg.frame =CGRectMake(i*(PROPORTION_WIDTH(44)+PROPORTION_WIDTH(15))+PROPORTION_WIDTH(44),CGRectGetMaxY(self.btn.frame)+15, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
            [bgView addSubview:hourBg];
            [hourBg setImage:[UIImage imageNamed:@"home_time_la"]];
        hourBg.userInteractionEnabled =YES;
        self.labg =hourBg;
        UILabel* timeLa = [[UILabel alloc]init];
        timeLa.frame =CGRectMake(2, 0, hourBg.width-4, hourBg.height);
        //timeLa.backgroundColor=[UIColor greenColor];
        self.la =timeLa;
        self.la.textAlignment =NSTextAlignmentCenter;
        [hourBg addSubview:timeLa];
        //self.la.text =@"2325345456";
        self.la.tag = 800+i;
    }
//jian btn
    for (int i = 0 ; i < 5; i++) {
   
        UIButton* jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        jianBtn.frame =CGRectMake(i*(PROPORTION_WIDTH(44)+PROPORTION_WIDTH(15))+PROPORTION_WIDTH(44),CGRectGetMaxY(self.labg.frame)+15, PROPORTION_WIDTH(44), PROPORTION_HIGHT(30));
        
        [jianBtn setBackgroundImage:[UIImage imageNamed:@"loginbutton.png"] forState:(UIControlStateNormal)];
         [jianBtn setImage:[UIImage imageNamed:@"home_jianhao"] forState:(UIControlStateNormal)];
      
        //[jianBtn setTitle:@"-" forState:(UIControlStateNormal)];
        
        [bgView addSubview:jianBtn];
        
          self.jianbtn =jianBtn;
        self.jianbtn.tag =300+i;
       
    }
    
    
    
    self.DoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.DoneBtn.frame = CGRectMake(PROPORTION_WIDTH(16), bgView.height-PROPORTION_HIGHT(60), (bgView.width-PROPORTION_WIDTH(16)*2-10), STANDARD_HEIGHT);
    KUIbutton( self.DoneBtn);
    KUIbuttonClick(self.DoneBtn);
    [self.DoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.DoneBtn];
    
    self.hidden = NO;
    
    
    
    
}


@end
