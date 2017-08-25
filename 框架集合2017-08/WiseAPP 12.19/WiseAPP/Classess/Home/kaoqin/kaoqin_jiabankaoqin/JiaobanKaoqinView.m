//
//  JiaobanKaoqinView.m
//  WiseAPP
//
//  Created by app on 16/12/5.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "JiaobanKaoqinView.h"
#import <MapKit/MapKit.h>

@implementation JiaobanKaoqinView
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
    self.timeImageview.center =CGPointMake(self.mapView.width/2, self.mapView.height/2-100);
    [self.mapView addSubview:self.timeImageview];
    self.timeImageview.layer.cornerRadius=PROPORTION_HIGHT(50);
    self.timeImageview.layer.masksToBounds =YES;
     [self.timeImageview setImage:[UIImage imageNamed:@"kaoqin_curreTime.png"]];
    
    self.cuttreTimeLa=[[UILabel alloc]init];
    self.cuttreTimeLa.frame =CGRectMake(20, self.timeImageview.height/3, self.timeImageview.width-40, 20);
    self.cuttreTimeLa.text=@"09：00";
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
