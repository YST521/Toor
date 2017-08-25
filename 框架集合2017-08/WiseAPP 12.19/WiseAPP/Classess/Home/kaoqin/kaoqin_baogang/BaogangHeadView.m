//
//  BaogangHeadView.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangHeadView.h"

@implementation BaogangHeadView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        [self addView];
        
    }
    return self;

}

-(void)addView{


    //yuan
    self.roundView=[[UIImageView alloc]init];
    self.roundView.frame =CGRectMake(0, 0, PROPORTION_WIDTH(100), PROPORTION_HIGHT(100));
    [self.roundView setImage:[UIImage imageNamed:@"kaoqin_curreTime.png"]];
    [self addSubview:self.roundView];
    self.roundView.center =CGPointMake(SCREEN_WIDTH/2, PROPORTION_HIGHT(60));
    self.roundView.layer.cornerRadius =PROPORTION_WIDTH(50);
    self.roundView.layer.borderWidth = 3;
    self.roundView.layer.borderColor=[UIColor blueColor].CGColor;
    
    self.cuttreeTimeLa =[[UILabel alloc]init];
    self.cuttreeTimeLa.frame=CGRectMake(20, self.roundView.height/3, self.roundView.width-40, PROPORTION_HIGHT(20));
        self.cuttreeTimeLa.textAlignment =NSTextAlignmentCenter;
    [self.roundView addSubview:self.cuttreeTimeLa];
    self.cuttreeTimeLa.textColor=[UIColor redColor];
  
    
    self.timeLa=[[UILabel alloc]init];
    self.timeLa.frame =CGRectMake(20, CGRectGetMaxY(self.cuttreeTimeLa.frame)+2, self.roundView.width-40, PROPORTION_HIGHT(20));
    [self.roundView addSubview:self.timeLa];
    self.timeLa.text =@"当前时间";
    self.timeLa.font =[UIFont systemFontOfSize:14];
    self.timeLa.adjustsFontSizeToFitWidth =YES;
    
    self.bgview =[[UIView alloc]init];
    self.bgview.frame =CGRectMake(0, CGRectGetMaxY(self.roundView.frame)+10, SCREEN_WIDTH, PROPORTION_HIGHT(110));
    [self addSubview:self.bgview];
    self.bgview.backgroundColor=[UIColor whiteColor];
    
    self.banciLa = [[UILabel alloc]init];
    self.banciLa.frame =CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(10), SCREEN_WIDTH/3, PROPORTION_HIGHT(20));
    [self.bgview addSubview:self.banciLa];
   // self.banciLa.backgroundColor=[UIColor redColor];
    self.banciLa.font =[UIFont boldSystemFontOfSize:16 ];
    
    self.shijibaogangLa=[[UILabel alloc]init];
    self.shijibaogangLa.frame =CGRectMake(SCREEN_WIDTH/2, PROPORTION_HIGHT(10), SCREEN_WIDTH/2-10, PROPORTION_HIGHT(20));
    [self.bgview addSubview:self.shijibaogangLa];
    
    self.yingbaogangLa=[[UILabel alloc]init];
    self.yingbaogangLa.frame =CGRectMake(PROPORTION_WIDTH(10), CGRectGetMaxY(self.banciLa.frame)+10, SCREEN_WIDTH/2-PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.bgview addSubview:self.yingbaogangLa];
   // self.yingbaogangLa.backgroundColor=[UIColor redColor];
    
    self.weibaogangLa=[[UILabel alloc]init];
    self.weibaogangLa.frame =CGRectMake(SCREEN_WIDTH/2+10, CGRectGetMaxY(self.banciLa.frame)+10,SCREEN_WIDTH/2-PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.bgview addSubview:self.weibaogangLa];
    
    self.leftTitleLa =[[UILabel alloc]init];
    self.leftTitleLa.frame =CGRectMake(10, CGRectGetMaxY(self.weibaogangLa.frame)+10, SCREEN_WIDTH/2-20, PROPORTION_HIGHT(30));
    self.leftTitleLa.textAlignment =NSTextAlignmentCenter;
    self.leftTitleLa.textColor =[UIColor blueColor];
    [self.bgview addSubview:self.leftTitleLa];
   // self.leftTitleLa.backgroundColor =[UIColor blueColor];
  
    self.rightTitleLa =[[UILabel alloc]init];
    self.rightTitleLa.frame =CGRectMake(SCREEN_WIDTH/2+10, CGRectGetMaxY(self.weibaogangLa.frame)+10, SCREEN_WIDTH/2-20, PROPORTION_HIGHT(30));
    [self.bgview addSubview:self.rightTitleLa];
    self.rightTitleLa.textColor =[UIColor blueColor];
    self.rightTitleLa.textAlignment =NSTextAlignmentCenter;
    //self.rightTitleLa.backgroundColor=[UIColor greenColor];
    
    UIView*lineView=[[UIView alloc]init];
    lineView.frame =CGRectMake(0, self.rightTitleLa.y+1, SCREEN_WIDTH, 0.3);
    lineView.backgroundColor=[UIColor grayColor];
    [self.bgview addSubview:lineView];
    UIView*midLineView=[[UIView alloc]init];
    midLineView.frame =CGRectMake(SCREEN_WIDTH/2-2, self.bgview.height-PROPORTION_HIGHT(20), PROPORTION_WIDTH(4), PROPORTION_HIGHT(20));
    midLineView.backgroundColor=[UIColor darkGrayColor];
    [self.bgview addSubview:midLineView];
    //SET
    self.banciLa.font=[UIFont systemFontOfSize:16];
    self.shijibaogangLa.font =[UIFont systemFontOfSize:16];
    self.yingbaogangLa.font=[UIFont systemFontOfSize:16];
    self.weibaogangLa.font=[UIFont systemFontOfSize:16];
    self.banciLa.textColor =textCententColor;
    self.shijibaogangLa.textColor =textCententColor;
    self.yingbaogangLa.textColor =textCententColor;
    self.weibaogangLa.textColor =textCententColor;
    self.banciLa.textAlignment =NSTextAlignmentLeft;
    self.yingbaogangLa.textAlignment =NSTextAlignmentLeft;
    self.shijibaogangLa.textAlignment=NSTextAlignmentRight;
    self.weibaogangLa.textAlignment=NSTextAlignmentRight;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
