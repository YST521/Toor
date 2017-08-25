//
//  QiantuiView.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "QiantuiView.h"
#import <MapKit/MapKit.h>

@implementation QiantuiView
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
    self.addressLa.text =@"当前位置：上海市永嘉路36号";
    [self addSubview:self.addressLa];
    
    self.mapView =[[MKMapView alloc]init];
    self.mapView.frame =CGRectMake(0, CGRectGetMaxY(self.addressLa.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-40-PROPORTION_HIGHT(200));
    [self addSubview:self.mapView];
    
    
    UIView*bgview=[[UIView alloc]init];
    bgview.frame=CGRectMake(0, CGRectGetMaxY(self.mapView.frame), SCREEN_WIDTH, PROPORTION_HIGHT(45));
    bgview.backgroundColor =[UIColor whiteColor];
    [self addSubview:bgview];
    
    self.selectbanciLa=[[UILabel alloc]init];
    self.selectbanciLa.frame =CGRectMake(10, STANDRD_H_20_y, SCREEN_WIDTH/3, PROPORTION_HIGHT(20));
    self.selectbanciLa.textColor=textCententColor;
    self.selectbanciLa.font =[UIFont systemFontOfSize:16];
    [bgview addSubview:self.selectbanciLa];
    self.selectbanciLa.text = @"选择当前考勤班次";
    self.selectbanciLa.adjustsFontSizeToFitWidth =YES;
    
    self.textfileBG=[[UIImageView alloc]init];
    self.textfileBG.frame =CGRectMake(SCREEN_WIDTH-120, PROPORTION_HIGHT(15/2), 100, PROPORTION_HIGHT(30));
    self.textfileBG.image =[UIImage imageNamed:@"home_textfile_duanbg.png"];
    [bgview addSubview:self.textfileBG];
    self.textfileBG.userInteractionEnabled =YES;
    
    self.banciFi=[[UITextField alloc]init];
    self.banciFi.frame = self.textfileBG.bounds;
    // self.rightLa.backgroundColor=[UIColor greenColor];
    self.banciFi.placeholder = @"日班";
    self.banciFi.textAlignment = NSTextAlignmentCenter;
    self.banciFi.textColor = textCententColor;
    [self.textfileBG addSubview:self.banciFi];
    
    self.cameraBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.cameraBtn.frame =CGRectMake(STANDARD_X, CGRectGetMaxY(bgview.frame)+20, STANDARD_WIDTH, STANDARD_HEIGHT);
    KUIbutton(self.cameraBtn);
    KUIbuttonClick(self.cameraBtn);
    [self.cameraBtn setTitle:@"去拍照" forState:(UIControlStateNormal)];
    [self addSubview:self.cameraBtn];
    //mapview center image
    self.timeImageview=[[UIImageView alloc]init];
    self.timeImageview.frame =CGRectMake(0, 0, PROPORTION_WIDTH(100), PROPORTION_HIGHT(100));
   [self.timeImageview setImage:[UIImage imageNamed:@"kaoqin_curreTime.png"]];
    self.timeImageview.center =CGPointMake(self.mapView.width/2, self.mapView.height/2-100);
    [self.mapView addSubview:self.timeImageview];
    self.timeImageview.layer.cornerRadius=PROPORTION_HIGHT(50);
    self.timeImageview.layer.masksToBounds =YES;
    
    self.cuttreTimeLa=[[UILabel alloc]init];
    self.cuttreTimeLa.frame =CGRectMake(20, self.timeImageview.height/3, self.timeImageview.width-40, 20);
   // self.cuttreTimeLa.adjustsFontSizeToFitWidth=YES;
    //self.cuttreTimeLa.text=@"09：00";
    self.cuttreTimeLa.textAlignment =NSTextAlignmentCenter;
    
    [self.timeImageview addSubview:self.cuttreTimeLa];
    
    self.cuttreLa=[[UILabel alloc]init];
    self.cuttreLa.frame = CGRectMake(20, CGRectGetMaxY(self.cuttreTimeLa.frame)+2, self.timeImageview.width-PROPORTION_WIDTH(40), PROPORTION_HIGHT(20));
    self.cuttreLa.text = @"当前时间";
    self.cuttreLa.adjustsFontSizeToFitWidth=YES;
    [self.timeImageview addSubview:self.cuttreLa];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
