//
//  ChangePasswordSucessView.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ChangePasswordSucessView.h"

@implementation ChangePasswordSucessView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
       
        [self addView];
    }
    return self;

}
-(void)addView{

    self.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(STANDARD_X,PROPORTION_HIGHT(138) , STANDARD_WIDTH, PROPORTION_HIGHT(250));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*logoBg=[[UIImageView alloc]init];
    logoBg.frame = CGRectMake(0, 0, PROPORTION_WIDTH(100),  PROPORTION_WIDTH(100));
    logoBg.center = CGPointMake(bgView.width/2, PROPORTION_HIGHT(20)+PROPORTION_HIGHT(50));
    //logoBg.backgroundColor =[UIColor redColor];
    logoBg.layer.cornerRadius = logoBg.frame.size.width/2;
    logoBg.layer.masksToBounds = YES;
    logoBg.image =[UIImage imageNamed:@"logoWithebac@2x"];
    [bgView addSubview:logoBg];
    
    UIImage*logo=[UIImage imageNamed:@"logo"];
    UIImageView*companyLogo =[[UIImageView alloc]init];
    companyLogo.frame =CGRectMake(0, 0, logo.size.width,logo.size.height);
    companyLogo.image = logo;
    //companyLogo.backgroundColor =[UIColor greenColor];
    companyLogo.center = logoBg.center;
    [bgView addSubview:companyLogo];
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoBg.frame)+PROPORTION_HIGHT(20), bgView.width, 30)];
    titleLabel.text = @"恭喜您！密码设置成功！";
    titleLabel.textAlignment =NSTextAlignmentCenter;
    titleLabel.textColor = textCententColor;
    [bgView addSubview:titleLabel];
    self.loginButton =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginButton.frame = CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+20, bgView.width-PROPORTION_WIDTH(20), STANDARD_HEIGHT);
    KUIbutton(self.loginButton);
    KUIbuttonClick(self.loginButton);
    [self.loginButton setTitle:@"去登陆" forState:(UIControlStateNormal)];
    
    [bgView addSubview:self.loginButton];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
