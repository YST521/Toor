//
//  LinbaoView.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LinbaoView.h"
#import <MapKit/MapKit.h>

@implementation LinbaoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addView];
    }
    return self;
}
-(void)addView{
    self.backgroundColor=GlobBackGroundColor;
    self.addressIcon =[[UIImageView alloc]init];
    self.addressIcon.frame =CGRectMake(10, 10, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    self.addressIcon.image =[UIImage imageNamed:@"home_dizhi.png"];
    [self addSubview:self.addressIcon];
    self.addressLa=[[UILabel alloc]init];
    self.addressLa.frame =CGRectMake(CGRectGetMaxX(self.addressIcon.frame)+10, 10, 200, 20);
    self.addressLa.textColor = textCententColor;
    self.addressLa.font =[UIFont systemFontOfSize:14];
    //self.addressLa.text =@"当前位置：上海市永嘉路36号";
    [self addSubview:self.addressLa];
    
    self.mapView =[[MKMapView alloc]init];
    self.mapView.frame =CGRectMake(0, CGRectGetMaxY(self.addressLa.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-40-PROPORTION_HIGHT(200));
    [self addSubview:self.mapView];
    
          //mapview center image
    self.timeImageview=[[UIImageView alloc]init];
    self.timeImageview.frame =CGRectMake(0, 0, PROPORTION_WIDTH(100), PROPORTION_HIGHT(100));
    self.timeImageview.backgroundColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
    self.timeImageview.center =CGPointMake(self.mapView.width/2, self.mapView.height/2-PROPORTION_HIGHT(60));
    [self.mapView addSubview:self.timeImageview];
    self.timeImageview.layer.cornerRadius=PROPORTION_HIGHT(50);
    self.timeImageview.layer.masksToBounds =YES;
     [self.timeImageview setImage:[UIImage imageNamed:@"kaoqin_curreTime.png"]];
    self.cuttreTimeLa=[[UILabel alloc]init];
    self.cuttreTimeLa.frame =CGRectMake(20, self.timeImageview.height/3, self.timeImageview.width-40, 20);
    //self.cuttreTimeLa.text=@"09：00";
   self.cuttreTimeLa.textAlignment =NSTextAlignmentCenter;
    [self.timeImageview addSubview:self.cuttreTimeLa];
    
    self.cuttreLa=[[UILabel alloc]init];
    self.cuttreLa.frame = CGRectMake(20, CGRectGetMaxY(self.cuttreTimeLa.frame)+2, self.timeImageview.width-PROPORTION_WIDTH(40), PROPORTION_HIGHT(20));
    self.cuttreLa.text = @"当前时间";
    self.cuttreLa.adjustsFontSizeToFitWidth=YES;
    [self.timeImageview addSubview:self.cuttreLa];

//    self.qiandaoBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.qiandaoBtn.frame =CGRectMake(15, CGRectGetMaxY(self.mapView.frame)+PROPORTION_HIGHT(15), (SCREEN_WIDTH-PROPORTION_WIDTH(60))/2, PROPORTION_HIGHT(80));
// 
//    [self.qiandaoBtn setTitle:@"去拍照" forState:(UIControlStateNormal)];
//    self.qiandaoBtn.backgroundColor=[UIColor redColor];
//    [self addSubview:self.qiandaoBtn];
// 
//    
//    self.qiantuiBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.qiantuiBtn.frame=CGRectMake(CGRectGetMaxX(self.qiandaoBtn.frame)+PROPORTION_WIDTH(20),  CGRectGetMaxY(self.mapView.frame)+10,  (SCREEN_WIDTH-PROPORTION_WIDTH(60))/2, PROPORTION_HIGHT(80));
//    self.qiantuiBtn.backgroundColor =[UIColor greenColor];
//    [self addSubview:self.qiantuiBtn];
    //up scrollow view
    
    self.hadongView =[[UIView alloc]init];
    self.hadongView.frame =CGRectMake(0, 0, PROPORTION_WIDTH(80), PROPORTION_HIGHT(80));
    self.hadongView.backgroundColor=[UIColor greenColor];
    [self.mapView addSubview:self.hadongView];
    
    self.peopleImage=[[UIImageView alloc]init];
    self.peopleImage.frame =CGRectMake(PROPORTION_WIDTH(5), 0, PROPORTION_WIDTH(25), PROPORTION_HIGHT(25));
    self.peopleImage.center = CGPointMake(10, self.hadongView.height/2);
    //self.peopleImage.backgroundColor=[UIColor redColor];
    [self.hadongView addSubview:self.peopleImage];
    [self.peopleImage setImage:[UIImage imageNamed:@"kaoqin_peopleImage.png"]];
    
    self.rightImage=[[UIImageView alloc]init];
    self.rightImage.frame =CGRectMake(self.hadongView.width-PROPORTION_WIDTH(30)+5, PROPORTION_HIGHT(25), PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
    self.rightImage.backgroundColor=[UIColor blueColor];
    [self.hadongView addSubview:self.rightImage];
    [self.rightImage setImage:[UIImage imageNamed:@"kaoqin_linbaoright.png"]];
    self.rightImage.userInteractionEnabled =YES;
    
    
    self.contentView=[[UIView alloc]init];
    self.contentView.frame = CGRectMake(CGRectGetMaxX(self.peopleImage.frame)+10, 5,self.hadongView.width-PROPORTION_WIDTH(80), self.hadongView.height-10);
    [self.hadongView addSubview:self.contentView];
    self.contentView.hidden =YES;
    //详情
    self.workTimeLa=[[UILabel alloc]init];
    self.workTimeLa.frame =CGRectMake(0, 5,PROPORTION_WIDTH(200), PROPORTION_HIGHT(20));
    self.workTimeLa.font=[UIFont systemFontOfSize:14];
    self.workTimeLa.textColor =[UIColor whiteColor];
    self.workNameLa.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:self.workTimeLa];
    
    self.workNameLa=[[UILabel alloc]init];
    self.workNameLa.frame =CGRectMake(0, CGRectGetMaxY( self.workTimeLa.frame),PROPORTION_WIDTH(200), PROPORTION_HIGHT(20));
   self.workNameLa.font=[UIFont systemFontOfSize:16];
  self.workNameLa.textColor =[UIColor whiteColor];
     self.workNameLa.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:self.workNameLa];
    
    self.workLongtimeLa=[[UILabel alloc]init];
   self.workLongtimeLa.frame =CGRectMake(0, CGRectGetMaxY( self.workNameLa.frame),PROPORTION_WIDTH(200), PROPORTION_HIGHT(20));
    self.workLongtimeLa.font=[UIFont systemFontOfSize:16];
    self.workLongtimeLa.textColor =[UIColor whiteColor];
     self.workLongtimeLa.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview: self.workLongtimeLa];

    
    //test data
    self.contentView.backgroundColor=[UIColor blueColor];
    self.workTimeLa.backgroundColor=[UIColor redColor];
    self.workTimeLa.text = @"工作时间:12:00-22:00";
    self.workNameLa.text = @"任务名称:人民广场临保任务";
    self.workLongtimeLa.text =@"工作时长:6小时";
    
    
}


@end
