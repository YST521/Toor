//
//  WorkTimeView.m
//  WiseAPP
//
//  Created by app on 16/12/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WorkTimeView.h"

@implementation WorkTimeView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addView];
    }
    return self;
}
-(void)addView{

    
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    
    
    self.popTitle=[[UILabel alloc]initWithFrame:titleBg.bounds];
    //self.popTitle.text = @" 身高";
    self.popTitle.textAlignment =NSTextAlignmentCenter;
    self.popTitle.textColor =  [UIColor whiteColor];
    [bgView addSubview: self.popTitle];
    
    //输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(self.popTitle.frame)+PROPORTION_HIGHT(50), (bgView.width-PROPORTION_WIDTH(40))/2, STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.starTimeFile=[[UITextField alloc]init];
    self.starTimeFile.frame = textfBg.bounds;
   self.starTimeFile.textColor = textCententColor;
   [textfBg addSubview:self.starTimeFile];
    self.starTimeFile.textAlignment = NSTextAlignmentCenter;
    
    //输入框
    UIImageView*endBg=[[UIImageView alloc]init];
    endBg.frame = CGRectMake(CGRectGetMaxX(textfBg.frame)+10,CGRectGetMaxY(self.popTitle.frame)+PROPORTION_HIGHT(50), textfBg.width, STANDARD_HEIGHT);
    endBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:endBg];
    endBg.userInteractionEnabled = YES;
    
    self.endTimeFile=[[UITextField alloc]init];
    self.endTimeFile.frame = endBg.bounds;
     self.endTimeFile.textColor = textCententColor;
    [endBg addSubview: self.endTimeFile];
      self.endTimeFile.textAlignment = NSTextAlignmentCenter;
    
    self.popDoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.popDoneBtn.frame = CGRectMake(PROPORTION_WIDTH(15), CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(50), titleBg.width -PROPORTION_WIDTH(30), STANDARD_HEIGHT);
    KUIbutton( self.popDoneBtn);
    KUIbuttonClick( self.popDoneBtn);
    [self.popDoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.popDoneBtn];

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
