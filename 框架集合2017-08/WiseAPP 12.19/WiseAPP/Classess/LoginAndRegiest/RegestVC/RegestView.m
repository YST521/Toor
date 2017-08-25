//
//  RegestView.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RegestView.h"

@implementation RegestView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        [self addView];
    }
    return self;


}
-(void)addView{

    UIImageView*bgimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginbackgroudImage"]];
    bgimage.frame = [[UIScreen mainScreen] bounds];
    [self addSubview:bgimage];
    //bgimage.backgroundColor = [UIColor whiteColor];
    bgimage.userInteractionEnabled = YES;
    
   UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 30)];
    titleLabel.center = CGPointMake(SCREEN_WIDTH/2, 42*SCREEN_HEIGHT/667);
    titleLabel.text = @"管家登陆";
    titleLabel.font =[UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =[UIColor whiteColor];
    [bgimage addSubview:titleLabel];
    
    self.backBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backBtn.frame = CGRectMake(15, titleLabel.y, PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    //self.backBtn.backgroundColor=[UIColor whiteColor];
    [ self.backBtn setBackgroundImage: [UIImage imageNamed:@"icon_back"] forState:(UIControlStateNormal)];
    [ self.backBtn setBackgroundImage: [UIImage imageNamed:@"icon_left"] forState:(UIControlStateHighlighted)];
    
    [bgimage addSubview:self.backBtn];
    
    
    UIImageView*logoBg=[[UIImageView alloc]init];
    logoBg.frame = CGRectMake(0, 0, PROPORTION_WIDTH(100),  PROPORTION_WIDTH(100));
    if (SCREEN_WIDTH<414) {
        logoBg.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(titleLabel.frame)+PROPORTION_HIGHT(35)+PROPORTION_HIGHT(100)/2);
    }else{
    logoBg.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(titleLabel.frame)+PROPORTION_HIGHT(50)+PROPORTION_HIGHT(100)/2);
    }
    //logoBg.backgroundColor =[UIColor redColor];
    logoBg.layer.cornerRadius = logoBg.frame.size.width/2;
    logoBg.layer.masksToBounds = YES;
    logoBg.image =[UIImage imageNamed:@"logobtn"];
    [bgimage addSubview:logoBg];
    
    UIImage*logo=[UIImage imageNamed:@"logo"];
    UIImageView*companyLogo =[[UIImageView alloc]init];
    companyLogo.frame =CGRectMake(0, 0, logo.size.width,logo.size.height);
    companyLogo.image = logo;
    //companyLogo.backgroundColor =[UIColor greenColor];
    companyLogo.center = logoBg.center;
    [bgimage addSubview:companyLogo];
    
    UILabel*welcomTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoBg.frame)+10, SCREEN_WIDTH, 20)];
    welcomTitle.text = @"物管家欢迎您";
    welcomTitle.textColor =[UIColor whiteColor];
    welcomTitle.textAlignment = NSTextAlignmentCenter;
    welcomTitle.shadowColor =YSTRGBColor(53, 53, 53);
    welcomTitle.shadowOffset =CGSizeMake(1, 2);
    [bgimage addSubview:welcomTitle];
    
    //选择工作模式
    self.typeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.typeBtn.frame = STANDARDWH(CGRectGetMaxY(welcomTitle.frame)+PROPORTION_HIGHT(14));
    [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"gongzuo.png"] forState:(UIControlStateNormal)];
    [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"wuguan.png"] forState:(UIControlStateSelected)];
    [self.typeBtn setTitle:@"工作                    物管" forState:(UIControlStateNormal)];
    [bgimage  addSubview:self.typeBtn];

    //输入手机号
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(self.typeBtn.frame)+PROPORTION_HIGHT(20), STANDARD_WIDTH, STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfile.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    UIImageView*phontIcon=[[UIImageView alloc]init];
    phontIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    phontIcon.image =  UIimageDef(@"iconfont-shouji");
    [textfBg addSubview:phontIcon];
    self.userPhoneNum=[[UITextField alloc]init];
  self.userPhoneNum.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, textfBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*string=[[NSMutableAttributedString alloc]initWithString:@"请输入手机号"];
    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 6)];
    self.userPhoneNum.attributedPlaceholder= string;
    //self.find_phoneNum.backgroundColor =[UIColor redColor];
    self.userPhoneNum.textColor = [UIColor whiteColor];
    [textfBg addSubview:self.userPhoneNum];
    self.userPhoneNum.keyboardType =UIKeyboardTypeNumberPad;
    
    UIImageView*codeBg=[[UIImageView alloc]init];
    codeBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(textfBg.frame)+14, (STANDARD_WIDTH-10)/2, STANDARD_HEIGHT);
    codeBg.image=[UIImage imageNamed:@"textfile.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:codeBg];
    codeBg.userInteractionEnabled = YES;
    
    self.userCode=[[UITextField alloc]init];
    self.userCode .frame =  CGRectMake(5,0,codeBg.width-5,codeBg.height);
    NSMutableAttributedString*codestring=[[NSMutableAttributedString alloc]initWithString:@"请输入验证码"];
    [codestring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 6)];
    self.userCode.attributedPlaceholder= codestring;
    self.userCode.textColor=[UIColor whiteColor];
    [codeBg addSubview:self.userCode];
    codeBg.userInteractionEnabled = YES;
    self.userCode.keyboardType = UIKeyboardTypeNumberPad;
    
    self.viditionBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.viditionBtn.frame =CGRectMake(CGRectGetMaxX(codeBg.frame)+10, codeBg.y, codeBg.width, codeBg.height);
    KUIbutton( self.viditionBtn);
    KUIbuttonClick( self.viditionBtn);
    [ self.viditionBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self addSubview: self.viditionBtn];
    
    //输入框
    UIImageView*passwordBg=[[UIImageView alloc]init];
    passwordBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(codeBg.frame)+PROPORTION_HIGHT(14), STANDARD_WIDTH, STANDARD_HEIGHT);
    passwordBg.image=[UIImage imageNamed:@"textfile.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:passwordBg];
    passwordBg.userInteractionEnabled = YES;
    
    UIImageView*passwordIcon=[[UIImageView alloc]init];
    passwordIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    passwordIcon.image =  UIimageDef(@"luck.png");
    [passwordBg addSubview:passwordIcon];
    self.userPassword=[[UITextField alloc]init];
    self.userPassword.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, passwordBg.width-PROPORTION_WIDTH(40)-PROPORTION_WIDTH(30), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*passwordstring=[[NSMutableAttributedString alloc]initWithString:@"请输入密码"];
    [passwordstring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
  self.userPassword.attributedPlaceholder= passwordstring;
   self.userPassword.textColor=textCententColor;
    self.userPassword.secureTextEntry=YES;
    self.userPassword.textColor = [UIColor whiteColor];
    [passwordBg addSubview:self.userPassword];
    
    self.firstEyeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
   self.firstEyeBtn.frame = CGRectMake(passwordBg.width-30, PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.firstEyeBtn setImage:UIimageDef(@"login_eye.png") forState:(UIControlStateNormal)];
    [self.firstEyeBtn setImage:UIimageDef(@"iconeyelook.png") forState:(UIControlStateSelected)];
    
    [passwordBg addSubview:self.firstEyeBtn];
    
    //再次输入密码
    UIImageView*secendBg=[[UIImageView alloc]init];
    secendBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY( passwordBg.frame)+PROPORTION_HIGHT(14), STANDARD_WIDTH, STANDARD_HEIGHT);
    secendBg.image=[UIImage imageNamed:@"textfile.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:secendBg];
    secendBg.userInteractionEnabled = YES;
    
    UIImageView*secendIcon=[[UIImageView alloc]init];
    secendIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    secendIcon.image =  UIimageDef(@"luck.png");
    [secendBg addSubview:secendIcon];
    self.userPsAgain=[[UITextField alloc]init];
       self.userPsAgain.secureTextEntry=YES;
       self.userPsAgain.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, passwordBg.width-PROPORTION_WIDTH(40)-PROPORTION_WIDTH(30), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString* secentString=[[NSMutableAttributedString alloc]initWithString:@"请确认密码"];
    [secentString setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
       self.userPsAgain.attributedPlaceholder= secentString;
       self.userPsAgain.textColor=  textCententColor;
      self.userPsAgain.secureTextEntry=YES;
    self.userPsAgain.textColor = [UIColor whiteColor];
    [secendBg addSubview:    self.userPsAgain];
    
        UIImage*meimage=[UIImage imageNamed:@"selectAgreementImage"];
    self.secendEyeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
     self.secendEyeBtn.frame = CGRectMake(passwordBg.width-30, PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [ self.secendEyeBtn setImage:UIimageDef(@"login_eye.png") forState:(UIControlStateNormal)];
    [ self.secendEyeBtn setImage:UIimageDef(@"iconeyelook.png") forState:(UIControlStateSelected)];
    
    [secendBg addSubview: self.secendEyeBtn];
    
    self.agreeBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.agreeBtn.frame=CGRectMake(PROPORTION_WIDTH(38+10), CGRectGetMaxY(secendBg.frame)+10, meimage.size.width,  meimage.size.height);

    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"memory.png"] forState:(UIControlStateNormal)];
    [self.agreeBtn setBackgroundImage:meimage forState:(UIControlStateSelected)];
    //self.agreeBtn.backgroundColor=[UIColor redColor];
    [bgimage addSubview:self.agreeBtn];
    
    //需要换成超链接label !!!
    self.agreeContentBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    //self.agreeContentBtn.backgroundColor =[UIColor greenColor];
    self.agreeContentBtn.frame = CGRectMake(PROPORTION_WIDTH(38+40),self.agreeBtn.frame.origin.y, STANDARD_WIDTH-PROPORTION_WIDTH(78), 20);
    [self.agreeContentBtn setTitle:@"我已阅读并同意物管家服务协议" forState:(UIControlStateNormal)];
    self.agreeContentBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    self.agreeContentBtn.titleLabel.textColor=[UIColor whiteColor];
    [bgimage addSubview: self.agreeContentBtn];
    
    self.nextBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.nextBtn.frame = STANDARDWH(CGRectGetMaxY(self.agreeBtn.frame)+14);
    KUIbutton(self.nextBtn);
    KUIbuttonClick(self.nextBtn);
    [self.nextBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [bgimage addSubview:self.nextBtn];
}


@end
