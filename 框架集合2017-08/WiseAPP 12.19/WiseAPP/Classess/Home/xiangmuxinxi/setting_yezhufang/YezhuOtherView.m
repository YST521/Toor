//
//  YezhuOtherView.m
//  WiseAPP
//
//  Created by yst911521 on 2016/12/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuOtherView.h"

@implementation YezhuOtherView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        
        [self addView];
    }
    
    return  self;
}

-(void)addView{
    
    
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(320));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    
    
    self.popTitle=[[UILabel alloc]initWithFrame:titleBg.bounds];
    //self.popTitle.text = @" 身高";
    self.popTitle.textAlignment =NSTextAlignmentCenter;
    self.popTitle.textColor =  textCententColor;
    [bgView addSubview: self.popTitle];
    self.popTextFile.text=@"某某亲戚";
  
    //输入框
    UIImage*image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(self.popTitle.frame)+PROPORTION_HIGHT(10), bgView.width-PROPORTION_WIDTH(30), image.size.height);
    textfBg.image=[UIImage imageNamed:@"home_textView_contentbg.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.popTextFile=[[UITextView alloc]init];
    self.popTextFile.frame = CGRectMake(PROPORTION_WIDTH(5), 0, textfBg.width-PROPORTION_WIDTH(10), textfBg.height);

    self.popTextFile.textColor = textCententColor;
    self.popTextFile.textAlignment = NSTextAlignmentLeft;
    [textfBg addSubview:self.popTextFile];
    self.popTextFile.backgroundColor=[UIColor clearColor];
    UILabel*la=[[UILabel alloc]init];
    la.frame = CGRectMake(titleBg.width-PROPORTION_WIDTH(80), image.size.height-PROPORTION_HIGHT(20), PROPORTION_WIDTH(60), PROPORTION_HIGHT(20));
    la.text =@"50字";
    la.font=[UIFont systemFontOfSize:14];
    la.textColor=textCententColor;
    [textfBg addSubview:la];
    
    self.popDoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.popDoneBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(10), textfBg.width, STANDARD_HEIGHT);
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
