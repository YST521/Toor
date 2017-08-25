//
//  QudaoView.m
//  WiseAPP
//
//  Created by app on 16/10/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "QudaoView.h"

@implementation QudaoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
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
    
    
    
    self.titleLabel=[[UILabel alloc]initWithFrame:titleBg.bounds];
    self.titleLabel.text = @"朋友";
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.titleLabel.textColor =  [UIColor whiteColor];
    [bgView addSubview: self.titleLabel];
    
    //输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(_titleLabel.frame)+PROPORTION_HIGHT(20), bgView.width-PROPORTION_WIDTH(30), STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.FriendName=[[UITextField alloc]init];
   self.FriendName.frame = titleBg.bounds;
    //self.phoneNum.backgroundColor=[UIColor redColor];
//    NSMutableAttributedString*string=[[NSMutableAttributedString alloc]initWithString:@"请输入朋友名称"];
//    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:53/255 green:53/255 blue:53/255 alpha:1]} range:NSMakeRange(0, 5)];
    self.FriendName.placeholder= @"请输入朋友名称";
    self.FriendName.textColor = textCententColor;
    
    [textfBg addSubview:self.FriendName];
    
    //输入框
    UIImageView*textfBgg=[[UIImageView alloc]init];
    textfBgg.frame = CGRectMake(PROPORTION_WIDTH(15),CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(20), bgView.width-PROPORTION_WIDTH(30), STANDARD_HEIGHT);
    textfBgg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgView addSubview:textfBgg];
    textfBgg.userInteractionEnabled = YES;
    
    
    self.frientNum=[[UITextField alloc]init];
    self.frientNum.frame = titleBg.bounds;
    self.frientNum.placeholder= @"请输入朋友电话号码";
    self.frientNum.textColor = textCententColor;
    self.frientNum.keyboardType= UIKeyboardTypeNumberPad;
    [textfBgg addSubview:self.frientNum];
    
    
    self.cannelBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
     self.cannelBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(textfBgg.frame)+PROPORTION_HIGHT(20), (bgView.width-PROPORTION_WIDTH(16)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton( self.cannelBtn);
    KUIbuttonClick( self.cannelBtn);
    [ self.cannelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [bgView addSubview: self.cannelBtn];
    
    self.doneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
   self.doneBtn.frame=CGRectMake(CGRectGetMaxX(self.cannelBtn.frame)+10, self.cannelBtn.y, self.cannelBtn.width, self.cannelBtn.height);
    KUIbutton(self.doneBtn);
    KUIbuttonClick(self.doneBtn);
    [self.doneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [bgView addSubview:self.doneBtn];
    self.hidden = NO;
    
    
    
}


@end
