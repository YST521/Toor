//
//  CellShowDizhiView.m
//  WiseAPP
//
//  Created by app on 16/10/18.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CellShowDizhiView.h"

@implementation CellShowDizhiView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addView];
    }
    
    return self;
    
}

-(void)addView{
    
    
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(80) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    //login_dizhi_bg nabackgroundImage.png//login_dizhi_bg.png
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    //titleBg.backgroundColor=textColorPlace;
    
    [bgView addSubview:titleBg];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:titleBg.bounds];
    self.titleLabel.text = @" 现居住地";
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.titleLabel.textColor =  [UIColor whiteColor];
    [bgView addSubview: self.titleLabel];
    
    //输入框
   UIImage*image=[UIImage imageNamed:@"login_dizhi_bg.png"];
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(_titleLabel.frame)+PROPORTION_HIGHT(20), image.size.width,image.size.height);
    textfBg.image=image;
    //textfBg.backgroundColor=[UIColor greenColor];
    textfBg.backgroundColor=textColorPlace;
    [bgView addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.heightFile=[[UITextView alloc]init];
    self.heightFile.frame = textfBg.bounds;
    self.heightFile.backgroundColor =[UIColor clearColor];
    
    self.heightFile.textColor = textCententColor;
    
    [textfBg addSubview:self.heightFile];
    
    
    self.backBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(30), (bgView.width-PROPORTION_WIDTH(16)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton(self.backBtn);
    KUIbuttonClick(self.backBtn);
    [self.backBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [bgView addSubview:self.backBtn];
    
    self.doneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.doneBtn.frame=CGRectMake(CGRectGetMaxX(self.backBtn.frame)+10, self.backBtn.y, self.backBtn.width, self.backBtn.height);
    KUIbutton(self.doneBtn);
    KUIbuttonClick(self.doneBtn);
    [self.doneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.doneBtn];
    self.hidden = NO;
    
    
    
}

@end
