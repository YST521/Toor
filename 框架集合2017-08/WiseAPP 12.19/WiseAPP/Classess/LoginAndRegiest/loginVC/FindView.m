//
//  FindView.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "FindView.h"

@implementation FindView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
      
        [self addView];
    }

    return  self;

}
-(void)addView{
    
//输入手机号
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(STANDARD_X,20, STANDARD_WIDTH, STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    UIImageView*phontIcon=[[UIImageView alloc]init];
    phontIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    phontIcon.image =  UIimageDef(@"login_shouji");
    [textfBg addSubview:phontIcon];
    self.find_phoneNum=[[UITextField alloc]init];
    self.find_phoneNum.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, textfBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
//    NSMutableAttributedString*string=[[NSMutableAttributedString alloc]initWithString:@"请输入手机号"];
//    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:53/255 green:53/255 blue:53/255 alpha:1]} range:NSMakeRange(0, 6)];
//    self.find_phoneNum.attributedPlaceholder= string;
    //self.find_phoneNum.backgroundColor =[UIColor redColor];
     self.find_phoneNum.placeholder =@"请输入手机号";
    [textfBg addSubview:self.find_phoneNum];

    UIImageView*codeBg=[[UIImageView alloc]init];
    codeBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(textfBg.frame)+14, (STANDARD_WIDTH-10)/2, STANDARD_HEIGHT);
    codeBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:codeBg];
   codeBg.userInteractionEnabled = YES;
    
    self.validitionCode=[[UITextField alloc]init];
    self.validitionCode .frame =  CGRectMake(10, 0, codeBg.width-5, codeBg.height);
     self.validitionCode.placeholder = @"请输入验证码";
    [codeBg addSubview:self.validitionCode];
    codeBg.userInteractionEnabled = YES;
    
    self.getCodeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.getCodeBtn.frame = CGRectMake(CGRectGetMaxX(codeBg.frame)+10, codeBg.y, codeBg.width, codeBg.height);
    KUIbutton(self.getCodeBtn);
    KUIbuttonClick(self.getCodeBtn);
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
     [self addSubview:self.getCodeBtn];
    
    //输入框
    UIImageView*passwordBg=[[UIImageView alloc]init];
    passwordBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(codeBg.frame)+PROPORTION_HIGHT(14), STANDARD_WIDTH, STANDARD_HEIGHT);
    passwordBg.image=[UIImage imageNamed:@"login_te_file.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:passwordBg];
    passwordBg.userInteractionEnabled = YES;
    
    UIImageView*passwordIcon=[[UIImageView alloc]init];
    passwordIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    passwordIcon.image =  UIimageDef(@"login_find_lock");
    [passwordBg addSubview:passwordIcon];
    self.firstPassword=[[UITextField alloc]init];
     self.firstPassword.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, passwordBg.width-PROPORTION_WIDTH(40)-PROPORTION_WIDTH(30), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*passwordstring=[[NSMutableAttributedString alloc]initWithString:@"请输入密码"];
    [passwordstring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
     self.firstPassword.attributedPlaceholder= passwordstring;
    self.firstPassword.textColor=textCententColor;
    self.firstPassword.secureTextEntry=YES;
    [passwordBg addSubview: self.firstPassword];
    
    self.firstBtneye=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.firstBtneye.frame = CGRectMake(passwordBg.width-30, PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.firstBtneye setImage:UIimageDef(@"login_eye_no.png") forState:(UIControlStateNormal)];
    [self.firstBtneye setImage:UIimageDef(@"find_eye.png") forState:(UIControlStateSelected)];
    
    [passwordBg addSubview:self.firstBtneye];
    
    //再次输入密码
    UIImageView*secendBg=[[UIImageView alloc]init];
    secendBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY( passwordBg.frame)+PROPORTION_HIGHT(14), STANDARD_WIDTH, STANDARD_HEIGHT);
    secendBg.image=[UIImage imageNamed:@"login_te_file.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:secendBg];
    secendBg.userInteractionEnabled = YES;
    
    UIImageView*secendIcon=[[UIImageView alloc]init];
   secendIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
   secendIcon.image =  UIimageDef(@"login_find_lock");
   // secendIcon.backgroundColor=[UIColor redColor];
    [secendBg addSubview:secendIcon];
    
    self.secendPassword=[[UITextField alloc]init];
    self.secendPassword.secureTextEntry=YES;
    self.secendPassword.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, passwordBg.width-PROPORTION_WIDTH(40)-PROPORTION_WIDTH(30), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString* secentString=[[NSMutableAttributedString alloc]initWithString:@"请确认密码"];
    [secentString setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
    self.secendPassword.attributedPlaceholder= secentString;
    self.secendPassword.textColor=  textCententColor;
    self.secendPassword.secureTextEntry=YES;
    [secendBg addSubview: self.secendPassword];
    
    self.secendBtneye=[UIButton buttonWithType:(UIButtonTypeCustom)];
   self.secendBtneye.frame = CGRectMake(passwordBg.width-30, PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.secendBtneye setImage:UIimageDef(@"login_eye_no.png") forState:(UIControlStateNormal)];
    [self.secendBtneye setImage:UIimageDef(@"find_eye.png") forState:(UIControlStateSelected)];
    
    [secendBg addSubview:self.secendBtneye];
    
    self.commitButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.commitButton.frame = STANDARDWH(CGRectGetMaxY(secendBg.frame)+14);
    KUIbutton(self.commitButton);
    KUIbuttonClick(self.commitButton);
    [self.commitButton setTitle:@"提交" forState:(UIControlStateNormal)];
    [self addSubview:self.commitButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
