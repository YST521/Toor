//
//  GerengongshiHeadView.m
//  WiseAPP
//
//  Created by app on 16/12/7.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GerengongshiHeadView.h"

@implementation GerengongshiHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
      
        [self addView];
        
    }
    return self;

}
-(void)addView{
    self.backgroundColor=GlobBackGroundColor;
    self.titleLa=[[UILabel alloc]init];
    self.titleLa.frame =CGRectMake(0, PROPORTION_HIGHT(20), PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
  
    [self addSubview:self.titleLa];
    
    self.numberLa=[[UILabel alloc]init];
    self.numberLa.frame =CGRectMake(0, PROPORTION_HIGHT(40), PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
   
    [self addSubview:self.numberLa];
    
    //test
//  self.titleLa.backgroundColor=[UIColor redColor];
//     self.numberLa.backgroundColor=[UIColor greenColor];
    self.titleLa.textAlignment = NSTextAlignmentCenter;
    self.numberLa.textAlignment = NSTextAlignmentCenter;
    self.numberLa.textColor=[UIColor redColor];
    self.numberLa.adjustsFontSizeToFitWidth=YES;
    self.titleLa.adjustsFontSizeToFitWidth=YES;
    self.titleLa.textColor=textCententColor;
    self.titleLa.font=[UIFont systemFontOfSize:15];
    self.numberLa.font=[UIFont systemFontOfSize:16];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
