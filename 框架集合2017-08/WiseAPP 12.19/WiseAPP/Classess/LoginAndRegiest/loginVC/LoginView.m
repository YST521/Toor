//
//  LoginView.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        [self addView];
    }

    return self;
}

//布局UI
-(void)addView{
    UIImageView*bgimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginbackgroudImage"]];
    bgimage.frame = [[UIScreen mainScreen] bounds];
    [self addSubview:bgimage];
    //bgimage.backgroundColor = [UIColor whiteColor];
    bgimage.userInteractionEnabled = YES;
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 42*SCREEN_HEIGHT/667, SCREEN_WIDTH, 30)];
    titleLabel.text = @"管家登陆";
    titleLabel.font =[UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =[UIColor whiteColor];
    [bgimage addSubview:titleLabel];
    
    UIImageView*logoBg=[[UIImageView alloc]init];
    logoBg.frame = CGRectMake(0, 0, PROPORTION_WIDTH(100),  PROPORTION_WIDTH(100));
    logoBg.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(titleLabel.frame)+PROPORTION_HIGHT(50)+PROPORTION_HIGHT(100)/2);
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
    
   //输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(welcomTitle.frame)+PROPORTION_HIGHT(16), STANDARD_WIDTH, STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfile.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgimage addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    UIImageView*phontIcon=[[UIImageView alloc]init];
    phontIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    phontIcon.image =  UIimageDef(@"iconfont-shouji");
    [textfBg addSubview:phontIcon];
    self.phoneNum=[[UITextField alloc]init];
    self.phoneNum.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, textfBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*string=[[NSMutableAttributedString alloc]initWithString:@"请输入账号"];
    
    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
    self.phoneNum.attributedPlaceholder= string;
    self.phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNum.textColor = [UIColor whiteColor];
    [textfBg addSubview:self.phoneNum];
    
    //输入框
    UIImageView*passwordBg=[[UIImageView alloc]init];
   passwordBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(14), STANDARD_WIDTH, STANDARD_HEIGHT);
   passwordBg.image=[UIImage imageNamed:@"textfile"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [bgimage addSubview:passwordBg];
    passwordBg.userInteractionEnabled = YES;
    
    UIImageView*passwordIcon=[[UIImageView alloc]init];
    passwordIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    passwordIcon.image =  UIimageDef(@"luck.png");
    [passwordBg addSubview:passwordIcon];
    self.password=[[UITextField alloc]init];
  self.password.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, passwordBg.width-PROPORTION_WIDTH(40)-PROPORTION_WIDTH(30), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*passwordstring=[[NSMutableAttributedString alloc]initWithString:@"请输入密码"];
    [passwordstring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
    self.password.attributedPlaceholder= passwordstring;
    self.password.textColor=[UIColor whiteColor];
    self.password.secureTextEntry=YES;
    [passwordBg addSubview:self.password];
    
    self.eyeBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.eyeBtn.frame = CGRectMake(passwordBg.width-30, PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.eyeBtn setImage:UIimageDef(@"login_eye.png") forState:(UIControlStateNormal)];
    [self.eyeBtn setImage:UIimageDef(@"iconeyelook.png") forState:(UIControlStateSelected)];

    [passwordBg addSubview:self.eyeBtn];
    
    //忘记密码//memory.png float.png selectAgreementImage
    UIImage*meimage=[UIImage imageNamed:@"selectAgreementImage"];
    self.menmoryBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.menmoryBtn.frame= CGRectMake(PROPORTION_WIDTH(48), CGRectGetMaxY(passwordBg.frame)+PROPORTION_HIGHT(14), meimage.size.width, meimage.size.height);
    [self.menmoryBtn setImage:[UIImage imageNamed:@"memory.png"] forState:(UIControlStateNormal)];
    [self.menmoryBtn setImage:meimage forState:(UIControlStateSelected)];
    [bgimage addSubview:self.menmoryBtn];
    //bgimage.image = meimage;
    UILabel*menmeryLa=[[UILabel alloc]init];
    menmeryLa.frame = CGRectMake(CGRectGetMaxX(self.menmoryBtn.frame)+10, self.menmoryBtn.y, PROPORTION_WIDTH(100), 20);
    menmeryLa.text= @"记住密码";
    menmeryLa.textColor=[UIColor whiteColor];
    menmeryLa.font=[UIFont systemFontOfSize:14];
    [bgimage addSubview:menmeryLa];
    //找回密码
    self.remberBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.remberBtn.frame= CGRectMake(bgimage.width-100-PROPORTION_WIDTH(38), menmeryLa.y, 100, 20);
    [self.remberBtn setTitle:@"？ 忘记密码" forState:(UIControlStateNormal)];
    [self.remberBtn setTitle:@"？ 忘记密码" forState:(UIControlStateHighlighted)];
    self.remberBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    //self.remberBtn.backgroundColor=[UIColor redColor];
    [bgimage addSubview:self.remberBtn];
    
    self.loginBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginBtn.frame = STANDARDWH(CGRectGetMaxY(self.menmoryBtn.frame)+PROPORTION_HIGHT(14));
    KUIbutton(self.loginBtn);
    KUIbuttonClick(self.loginBtn);
    [self.loginBtn setTitle:@"登陆" forState:(UIControlStateNormal)];
    [bgimage addSubview:self.loginBtn];
    
    self.regestBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.regestBtn.frame= STANDARDWH(CGRectGetMaxY(self.loginBtn.frame)+14);
    KUIbutton(self.regestBtn);
    KUIbuttonClick(self.regestBtn);
    [self.regestBtn setTitle:@"新用户注册" forState:(UIControlStateNormal)];
    [bgimage addSubview:self.loginBtn];
    

 
    [bgimage addSubview:self.regestBtn];
    
    
    
    NSUserDefaults*defaults =[NSUserDefaults standardUserDefaults];
    

    //[defaults synchronize];
    self.phoneNum.text =[defaults objectForKey:@"name"];
   self.password.text  =[defaults objectForKey:@"passWord"];
    

    
    
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
