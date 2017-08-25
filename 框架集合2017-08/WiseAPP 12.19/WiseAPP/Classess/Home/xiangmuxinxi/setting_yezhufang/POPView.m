//
//  POPView.m
//  WiseAPP
//
//  Created by app on 16/10/26.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "POPView.h"

@implementation POPView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
    
        [self addView];
    }

    return  self;
}

-(void)addView{

  
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(220));
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
    textfBg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(self.popTitle.frame)+PROPORTION_HIGHT(30), bgView.width-PROPORTION_WIDTH(30), STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.popTextFile=[[UITextField alloc]init];
    self.popTextFile.frame = titleBg.bounds;
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*string=[[NSMutableAttributedString alloc]initWithString:@"请输入身高"];
    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:53/255 green:53/255 blue:53/255 alpha:1]} range:NSMakeRange(0, 5)];
    self.popTextFile.attributedPlaceholder= string;
   self.popTextFile.textColor = textCententColor;
    self.popTextFile.textAlignment = NSTextAlignmentCenter;
    [textfBg addSubview:self.popTextFile];


    self.popDoneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.popDoneBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(30), textfBg.width, STANDARD_HEIGHT);
    KUIbutton( self.popDoneBtn);
    KUIbuttonClick( self.popDoneBtn);
    [self.popDoneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.popDoneBtn];
    

    self.hidden = NO;
    

}



@end
