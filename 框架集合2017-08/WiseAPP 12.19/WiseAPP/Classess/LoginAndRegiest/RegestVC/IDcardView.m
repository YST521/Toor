//
//  IDcardView.m
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "IDcardView.h"
#import "Header.h"

@implementation IDcardView
//-(UIImageView*)idCardA{
//    
//    if (!_idCardA) {
//        _idCardA=[[UIImageView alloc]init];
//    }
//
//    return _idCardA;
//
//}
//-(UIImageView *)idCardB{
//    if (!_idCardB) {
//        _idCardB=[[UIImageView alloc]init];
//    }
//
//    return _idCardB;
//
//}


-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        
        [self addView];
    }

    return self;
}

-(void)addView{
    //self.backgroundColor=[UIColor redColor];

    UIImageView*bgA=[[UIImageView alloc]init];
    if (SCREEN_WIDTH<370) {
        bgA.frame = CGRectMake(STANDARD_X, PROPORTION_HIGHT(10), STANDARD_WIDTH, PROPORTION_HIGHT(10+20+136));

    }else{
    bgA.frame = CGRectMake(STANDARD_X, PROPORTION_HIGHT(10), STANDARD_WIDTH, PROPORTION_HIGHT(10+10+20+136+20+10));
    }
    //bgA.backgroundColor=[UIColor redColor];
    UIImage*imageA=[UIImage imageNamed:@"shenfenzhengkuang.png"];
    bgA.image= imageA;
    [self addSubview:bgA];
    bgA.userInteractionEnabled = YES;
    
    UILabel*labelA=[[UILabel alloc]init];
    labelA.frame = CGRectMake(5, PROPORTION_HIGHT(10), bgA.width-10, 20);
    labelA.text= @"请拍下身份证人面像";
    labelA.font= textPlaceFont;
    labelA.textColor = textColorPlace;
    [bgA addSubview:labelA];
    
    self.idCardA=[[UIImageView alloc]init];
    
    self.idCardA.frame = CGRectMake(PROPORTION_HIGHT(40), CGRectGetMaxY(labelA.frame)+PROPORTION_HIGHT(10), bgA.width-(PROPORTION_HIGHT(40)*2), PROPORTION_HIGHT(136));
 
    self.idCardA.image=[UIImage imageNamed:@"renxiangmian.png"];
    [bgA addSubview:self.idCardA];
    
    self.playABtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.playABtn.frame = STANDARDWH(CGRectGetMaxY(bgA.frame)+10);
    KUIbutton(self.playABtn);
    KUIbuttonClick(self.playABtn);
    [self.playABtn setTitle:@"正面拍照" forState:(UIControlStateNormal)];
    [self addSubview:self.playABtn];
    
    //反面
    UIImageView*bgB=[[UIImageView alloc]init];
    if (SCREEN_WIDTH<370) {
        bgB.frame = CGRectMake(STANDARD_X, CGRectGetMaxY(self.playABtn.frame)+PROPORTION_HIGHT(15), STANDARD_WIDTH, PROPORTION_HIGHT(10+20+136));
        
    }else{
        bgB.frame = CGRectMake(STANDARD_X, CGRectGetMaxY(self.playABtn.frame)+PROPORTION_HIGHT(15), STANDARD_WIDTH, PROPORTION_HIGHT(10+10+20+136+20+10));    }

   
    //bgA.backgroundColor=[UIColor redColor];
  bgB.image=[UIImage imageNamed:@"shenfenzhengkuang.png"];
    [self addSubview:bgB];
  bgB.userInteractionEnabled = YES;
    
    UILabel*labelB=[[UILabel alloc]init];
    labelB.frame = CGRectMake(5, PROPORTION_HIGHT(10), bgB.width-10, 20);
   labelB.text= @"请拍下身份证人面像";
    labelB.font= textPlaceFont;
    labelB.textColor = textColorPlace;
    [bgB addSubview:labelB];
    
    self.idCardB=[[UIImageView alloc]init];
    self.idCardB.frame = CGRectMake(PROPORTION_HIGHT(40), CGRectGetMaxY(labelB.frame)+PROPORTION_HIGHT(10), bgB.width-(PROPORTION_HIGHT(40)*2), PROPORTION_HIGHT(136));
    self.idCardB.image=[UIImage imageNamed:@"guohuimian.png"];
    [bgB addSubview:self.idCardB];
    
    self.playBBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
      self.playBBtn.frame = STANDARDWH(CGRectGetMaxY(bgB.frame)+PROPORTION_HIGHT(10));
    KUIbutton(self.playBBtn);
    KUIbuttonClick(self.playBBtn);
 [self.playBBtn setTitle:@"反面面拍照" forState:(UIControlStateNormal)];
    [self addSubview:   self.playBBtn];
    
    self.commitBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.commitBtn.frame =  STANDARDWH(CGRectGetMaxY(self.playBBtn.frame)+PROPORTION_HIGHT(10));
    KUIbutton(self.commitBtn);
    KUIbuttonClick(self.commitBtn);
    [self.commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
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
