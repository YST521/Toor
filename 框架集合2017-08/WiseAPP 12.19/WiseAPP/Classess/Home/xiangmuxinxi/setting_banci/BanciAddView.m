//
//  BanciAddView.m
//  WiseAPP
//
//  Created by app on 16/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanciAddView.h"

@implementation BanciAddView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        [self addView];
    }


    return self;

}
-(void)addView{
    
    UILabel*titleLabel= [[UILabel alloc]init];
    titleLabel.text = @"班次名称";
    titleLabel.textColor = textCententColor;
    titleLabel.frame =CGRectMake(PROPORTION_WIDTH(15), 0, STANDARD_WIDTH, 30);
    //titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIImageView*banciImageBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_text_bg.png"]];
    banciImageBg.frame =CGRectMake(STANDARD_X+5, CGRectGetMaxY(titleLabel.frame)+10, STANDARD_WIDTH-5, STANDARD_HEIGHT);
    [self addSubview:banciImageBg];
    banciImageBg.userInteractionEnabled = YES;
    
    self.banciName=[[UITextField alloc]initWithFrame:CGRectMake(5, 0, banciImageBg.width-10, banciImageBg.height)];
    self.banciName.textAlignment =NSTextAlignmentCenter;
    [banciImageBg addSubview:self.banciName];
    self.banciName.placeholder= @"请输入班次名称 例如：日班";
    //self.banciName.delegate = self;
    UILabel*label=[[UILabel alloc]init];
    label.frame = CGRectMake(PROPORTION_WIDTH(15), CGRectGetMaxY(banciImageBg.frame)+PROPORTION_HIGHT(20), 100, 20);
    label.text = @"班次时间";
    label.textColor = textCententColor;
    [self addSubview:label];
    
    UIImageView*starImageBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_file"]];
    starImageBg.frame =CGRectMake(STANDARD_X+5, CGRectGetMaxY(label.frame)+10, STANDARD_WIDTH-5, STANDARD_HEIGHT);
    [self addSubview:starImageBg];
   starImageBg.userInteractionEnabled = YES;
    self. starTime = [[UITextField alloc]initWithFrame:starImageBg.bounds];
    self.starTime.placeholder= @"请输入开始时间:08:00";
    [ starImageBg addSubview:self.starTime];
    self.starTime.textAlignment =NSTextAlignmentCenter;
    
    UIImageView*endImageBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_file"]];
    endImageBg.frame =CGRectMake(STANDARD_X+5, CGRectGetMaxY(starImageBg.frame)+10, STANDARD_WIDTH-5, STANDARD_HEIGHT);
    [self addSubview:endImageBg];
    endImageBg.userInteractionEnabled = YES;
    self. endTime = [[UITextField alloc]initWithFrame:starImageBg.bounds];
    self. endTime.placeholder= @"请输入下班时间:20:00";
    [endImageBg addSubview: self. endTime];
    self. endTime.textAlignment =NSTextAlignmentCenter;
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
