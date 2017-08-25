//
//  KaoqinDetaileView.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "KaoqinDetaileView.h"

@implementation KaoqinDetaileView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        [self addView];
    }
    return self;
}
-(void)addView{

    self.hidden =NO;
    self.bgImageV=[[UIImageView alloc]init];
    self.bgImageV.frame =CGRectMake(0, 0, self.width, self.height);
    [self addSubview:self.bgImageV];
    
    
    self.titleLa=[[UILabel alloc]init];
    self.titleLa.frame =CGRectMake(10, 0, PROPORTION_WIDTH(150), PROPORTION_HIGHT(20));
    self.titleLa.textColor=[UIColor whiteColor];
    [self.bgImageV addSubview: self.titleLa];
    
    UIView*view=[[UIView alloc]init];
    view.frame =CGRectMake(10, CGRectGetMaxY(self.titleLa.frame)+1, SCREEN_WIDTH-20, 1);
    view.backgroundColor=[UIColor whiteColor];
    [self.bgImageV addSubview:view];
    
    self.starTime=[[UILabel alloc]init];
    self.starTime.frame =CGRectMake(10, CGRectGetMaxY(view.frame)+2, SCREEN_WIDTH/3, PROPORTION_HIGHT(20));
    [self.bgImageV addSubview:self.starTime];
    self.starTime.textColor =[UIColor whiteColor];
    self.starTime.font =[UIFont systemFontOfSize:14];
    
    self.endTime=[[UILabel alloc]init];
    self.endTime.frame =CGRectMake(SCREEN_WIDTH- SCREEN_WIDTH/3-10, CGRectGetMaxY(view.frame)+2, SCREEN_WIDTH/3, PROPORTION_HIGHT(20));
    [self.bgImageV addSubview:self.endTime];
    self.endTime.textColor =[UIColor whiteColor];
    self.endTime.font =[UIFont systemFontOfSize:14];
    
    self.starkaoqinLa=[[UILabel alloc]init];
    self.starkaoqinLa.frame =CGRectMake(10, CGRectGetMaxY(self.endTime.frame)+5, SCREEN_WIDTH/3, PROPORTION_HIGHT(20));
   self.starkaoqinLa.textColor =[UIColor whiteColor];
   self.starkaoqinLa.font =[UIFont systemFontOfSize:14];
    [self.bgImageV addSubview:self.starkaoqinLa];
    
    self.endKoaqinLa=[[UILabel alloc]init];
     self.endKoaqinLa.frame =CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/3-10, CGRectGetMaxY(self.endTime.frame)+5, SCREEN_WIDTH/3, PROPORTION_HIGHT(20));
     self.endKoaqinLa.textColor =[UIColor whiteColor];
   self.endKoaqinLa.font =[UIFont systemFontOfSize:14];
    [self.bgImageV addSubview: self.endKoaqinLa];
    
    self.starAdressLa=[[UILabel alloc]init];
    self.starAdressLa.frame =CGRectMake(10, CGRectGetMaxY(self.starkaoqinLa.frame)+1, SCREEN_WIDTH/3, PROPORTION_HIGHT(40));
    self.starAdressLa.textColor =[UIColor whiteColor];
     self.starAdressLa.font =[UIFont systemFontOfSize:14];
    self.starAdressLa.adjustsFontSizeToFitWidth=YES;
    self.starAdressLa.numberOfLines =0;
    [self.bgImageV addSubview: self.starAdressLa];

    self.endStrAdressLa=[[UILabel alloc]init];
    self.endStrAdressLa.frame =CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/3-10, CGRectGetMaxY(self.starkaoqinLa.frame)+1, SCREEN_WIDTH/3, PROPORTION_HIGHT(40));
    self.endStrAdressLa.textColor =[UIColor whiteColor];
   self.endStrAdressLa.font =[UIFont systemFontOfSize:14];
  self.endStrAdressLa.adjustsFontSizeToFitWidth=YES;
  self.endStrAdressLa.numberOfLines =0;
    [self.bgImageV addSubview:self.endStrAdressLa];
    
    //bgcoror
//    self.bgImageV.backgroundColor=[UIColor redColor];
//    self.titleLa.backgroundColor=[UIColor redColor];
     self.backgroundColor=[UIColor blueColor];
    //text
    self.titleLa.text =@"考勤详情";
    self.starTime.text =@"上班时间：10:03";
    self.endTime.text =@"上班时间：12:03";
    self.starkaoqinLa.text =@"考勤情况:正常";
    self.endKoaqinLa.text =@"考勤情况:早退";
    self.starAdressLa.text=@"地址:中国上海市黄浦区茂名南路永嘉路36号";
    self.endStrAdressLa.text=@"地址:中国上海市黄浦区茂名南路永嘉路36号";
}


@end
