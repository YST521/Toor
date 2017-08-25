//
//  WuguanView.m
//  WiseAPP
//
//  Created by app on 16/10/16.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WuguanView.h"

@implementation WuguanView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        [self creatView];
    }

    return  self;
}
-(void)creatView{

    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(STANDARD_X,20, STANDARD_WIDTH, STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    UIImageView*phontIcon=[[UIImageView alloc]init];
    phontIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    phontIcon.image =  UIimageDef(@"iconfont-xingming.png");
    [textfBg addSubview:phontIcon];
    self.wuguanPhNum=[[UITextField alloc]init];
    self.wuguanPhNum.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, textfBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*phstring=[[NSMutableAttributedString alloc]initWithString:@"请输入姓名"];
    [phstring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
  self.wuguanPhNum.attributedPlaceholder= phstring;
    //self.find_phoneNum.backgroundColor =[UIColor redColor];
    [textfBg addSubview:self.wuguanPhNum];
    
    UIImageView*companyBg=[[UIImageView alloc]init];
   companyBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(textfBg.frame)+14, STANDARD_WIDTH, STANDARD_HEIGHT);
   companyBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:companyBg];
   companyBg.userInteractionEnabled = YES;
    
    UIImageView*companyIcon=[[UIImageView alloc]init];
    companyIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
  companyIcon.image =  UIimageDef(@"iconfont-danweitijian.png");
    [companyBg addSubview:companyIcon];
    self.wuguanCompany=[[UITextField alloc]init];
    self.wuguanCompany.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, textfBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*companystring=[[NSMutableAttributedString alloc]initWithString:@"请输入单位名称"];
    [companystring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 7)];
    self.wuguanCompany.attributedPlaceholder= companystring;
    //self.find_phoneNum.backgroundColor =[UIColor redColor];
    [companyBg addSubview:self.wuguanCompany];
    
    UIImageView* poBg=[[UIImageView alloc]init];
  poBg.frame = CGRectMake(STANDARD_X,CGRectGetMaxY(companyBg.frame)+14, STANDARD_WIDTH, STANDARD_HEIGHT);
   poBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:poBg];
    poBg.userInteractionEnabled = YES;
    
    UIImageView*positionIcon=[[UIImageView alloc]init];
    positionIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
   positionIcon.image =  UIimageDef(@"iconfont-icon10005.png");
    [poBg addSubview:positionIcon];
//
    self.wuguanPosition=[[UITextField alloc]init];
   self.wuguanPosition.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, poBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*posstring=[[NSMutableAttributedString alloc]initWithString:@"请输入职位名称"];
    [posstring setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 7)];
    self.wuguanPosition.attributedPlaceholder= posstring;
    //self.find_phoneNum.backgroundColor =[UIColor redColor];
    [poBg addSubview:self.wuguanPosition];
    //poBg.backgroundColor=[UIColor greenColor];
//
    UIImageView*emailBg=[[UIImageView alloc]init];
    emailBg.frame = STANDARDWH(CGRectGetMaxY(poBg.frame)+14);
    emailBg.image =  UIimageDef(@"textfilebackgroundimage.png");
    [self addSubview:emailBg];
    emailBg.userInteractionEnabled =YES;
//
    UIImageView*emIcon=[[UIImageView alloc]init];
    emIcon.frame = CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(12.5), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));
    emIcon.image =  UIimageDef(@"iconfont-youxiang");
    [ emailBg addSubview:emIcon];
    self.wuguanEmail=[[UITextField alloc]init];
    self.wuguanEmail.frame = CGRectMake(CGRectGetMaxX(phontIcon.frame)+10, 2, poBg.width-PROPORTION_WIDTH(40), STANDARD_HEIGHT-4);
    //self.phoneNum.backgroundColor=[UIColor redColor];
    NSMutableAttributedString*eMString=[[NSMutableAttributedString alloc]initWithString:@"请输入邮箱"];
    [eMString setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 5)];
     self.wuguanEmail.attributedPlaceholder= eMString;
       //self.wuguanEmail.backgroundColor =[UIColor redColor];
    [ emailBg addSubview: self.wuguanEmail];
    
    self.commitBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.commitBtn.frame = STANDARDWH(CGRectGetMaxY(emailBg.frame)+PROPORTION_HIGHT(20));
    [self.commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    KUIbutton(self.commitBtn);
    KUIbuttonClick(self.commitBtn);
    [self addSubview:self.commitBtn];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
