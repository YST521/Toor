//
//  CellJinjiLianxirenView.m
//  WiseAPP
//
//  Created by app on 16/10/18.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "CellJinjiLianxirenView.h"

@implementation CellJinjiLianxirenView


-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        [self addView];
    }

    return self;
}

-(void)addView{
    self.userInteractionEnabled =YES;
    self.backgroundColor =  [UIColor whiteColor];
//    UIView*bgView=[[UIView alloc]init];
//    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
//    bgView.backgroundColor=[UIColor whiteColor];
//    [self addSubview:bgView];
    
   // 输入框
    UIImageView*textfBg=[[UIImageView alloc]init];
    textfBg.frame = CGRectMake(STANDARD_X,PROPORTION_HIGHT(20), STANDARD_WIDTH,STANDARD_HEIGHT);
    textfBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:textfBg];
    textfBg.userInteractionEnabled = YES;
    
    
    self.contanctName=[[UITextField alloc]init];
    self.contanctName.frame = textfBg.bounds;
    //self.phoneNum.backgroundColor=[UIColor redColor];
   self.contanctName.placeholder = @"请输入紧急联系人的姓名";
    self.contanctName.textColor = textCententColor;
    [textfBg addSubview:self.contanctName];
    
    UILabel*between =[[UILabel alloc]initWithFrame:CGRectMake(STANDARD_X, CGRectGetMaxY(textfBg.frame)+PROPORTION_HIGHT(15), STANDARD_WIDTH, 20)];
     between.text = @"联系人与本人的关系:";
    between.textColor=textCententColor;
    //between.backgroundColor=[UIColor redColor];
    [self addSubview:between];
    
    //selectBTn
  UIImage*meimage=[UIImage imageNamed:@"selectAgreementImage"];
    self.motherBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.motherBtn.frame = CGRectMake(STANDARD_X+PROPORTION_WIDTH(10), CGRectGetMaxY(between.frame)+PROPORTION_HIGHT(10),meimage.size.width, meimage.size.height);
       // self.motherBtn.backgroundColor=[UIColor grayColor];
    [ self.motherBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [ self.motherBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    [self.motherBtn setBackgroundImage:meimage forState:(UIControlStateSelected)];
    [self addSubview:self.motherBtn];

    
    UILabel*mLabel=[[UILabel alloc]init];
    mLabel.frame = CGRectMake(CGRectGetMaxX(self.motherBtn.frame)+10, self.motherBtn.y, 40, 20);
    mLabel.text = @"母亲";
    mLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:mLabel];

    self.fatherBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.fatherBtn.frame = CGRectMake(textfBg.width-80, CGRectGetMaxY(between.frame)+PROPORTION_HIGHT(10), meimage.size.width, meimage.size.height);
   //self.fatherBtn.backgroundColor=[UIColor grayColor];
    [self addSubview:self.fatherBtn];
    [self.fatherBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.fatherBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    [self.fatherBtn setBackgroundImage:meimage forState:(UIControlStateSelected)];
    
    
    UILabel*fLabel=[[UILabel alloc]init];
   fLabel.frame = CGRectMake(CGRectGetMaxX(self.fatherBtn.frame)+10, self.fatherBtn.y, 40, 20);
   fLabel.text = @"父亲";
   fLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:fLabel];

    self.sisterBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.sisterBtn.frame = CGRectMake(STANDARD_X+PROPORTION_WIDTH(10), CGRectGetMaxY(self.motherBtn.frame)+PROPORTION_HIGHT(10),  meimage.size.width, meimage.size.height);

  //self.sisterBtn.backgroundColor=[UIColor grayColor];
    [self addSubview:self.sisterBtn];
    [self.sisterBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.sisterBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    [ self.sisterBtn setBackgroundImage:meimage forState:(UIControlStateSelected)];
    
    UILabel*sLabel=[[UILabel alloc]init];
  sLabel.frame = CGRectMake(CGRectGetMaxX(self.sisterBtn.frame)+10, self.sisterBtn.y, 40, 20);
   sLabel.text = @"姐妹";
    sLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:sLabel];
    
    self.brotherBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.brotherBtn.frame = CGRectMake(STANDARD_WIDTH-80, self.sisterBtn.y,  meimage.size.width, meimage.size.height);

    //self.brotherBtn.backgroundColor=[UIColor grayColor];
    [self.brotherBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.brotherBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    [self.brotherBtn setBackgroundImage:meimage forState:(UIControlStateSelected)];
    [self addSubview:self.brotherBtn];

    
    UILabel*bLabel=[[UILabel alloc]init];
    bLabel.frame = CGRectMake(CGRectGetMaxX(self.brotherBtn.frame)+10, self.brotherBtn.y, 40, 20);
    bLabel.text = @"兄弟";
    bLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:bLabel];
    
    // 联系方式输入框
    UIImageView*phoneBg=[[UIImageView alloc]init];
    phoneBg.frame = CGRectMake(STANDARD_X, CGRectGetMaxY(self.sisterBtn.frame)+PROPORTION_HIGHT(10), STANDARD_WIDTH,STANDARD_HEIGHT);
    phoneBg.image=[UIImage imageNamed:@"textfilebackgroundimage.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self addSubview:phoneBg];
    phoneBg.userInteractionEnabled = YES;
    
    self.contentPhone=[[UITextField alloc]init];
   self.contentPhone.frame = phoneBg.bounds;

     self.contentPhone.placeholder = @"请输入紧急联系人的电话号码";
    self.contentPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.contentPhone.textColor = textCententColor;
    [phoneBg addSubview: self.contentPhone];
    
    self.saveBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.saveBtn.frame = STANDARDWH(CGRectGetMaxY(phoneBg.frame)+PROPORTION_HIGHT(20));
    KUIbutton(self.saveBtn);
    KUIbuttonClick(self.saveBtn);
    [self.saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [self addSubview:self.saveBtn];
    self.hidden = NO;
    
}

@end
