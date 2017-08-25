//
//  CellShowCompanyNameView.m
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CellShowCompanyNameView.h"

@implementation CellShowCompanyNameView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addView];
    }
    
    return self;
    
}

-(void)addView{
    
    
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(250));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    
    
    
    self.titleLabel=[[UILabel alloc]initWithFrame:titleBg.bounds];
    self.titleLabel.text = @"现单位名称";
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.titleLabel.textColor =  [UIColor whiteColor];
    [bgView addSubview: self.titleLabel];
    
    //输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(_titleLabel.frame)+PROPORTION_HIGHT(50), bgView.width-PROPORTION_WIDTH(30), STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.heightFile=[[UITextField alloc]init];
    self.heightFile.frame = titleBg.bounds;
    self.heightFile.placeholder =@"请输入现单位名称";
    self.heightFile.textColor = textCententColor;
    
    [textfBg addSubview:self.heightFile];
    
    
    self.backCBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backCBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(30), (bgView.width-PROPORTION_WIDTH(16)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton(self.backCBtn);
    KUIbuttonClick(self.backCBtn);
    [self.backCBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [bgView addSubview:self.backCBtn];
    
    self.doneCBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.doneCBtn.frame=CGRectMake(CGRectGetMaxX(self.backCBtn.frame)+10, self.backCBtn.y, self.backCBtn.width, self.backCBtn.height);
    KUIbutton(self.doneCBtn);
    KUIbuttonClick(self.doneCBtn);
    [self.doneCBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [bgView addSubview:self.doneCBtn];
    self.hidden = NO;
    
    
    
}


@end
