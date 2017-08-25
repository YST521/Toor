//
//  SucessPopView.m
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SucessPopView.h"

@implementation SucessPopView
-(instancetype)initWithFrame:(CGRect)frame{
    if ( self =[super initWithFrame:frame]) {
        
        [self addView];
        
    }

    return self;
}

-(void)addView{

    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(15),PROPORTION_HIGHT(100) , SCREEN_WIDTH-PROPORTION_WIDTH(30), PROPORTION_HIGHT(300));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*logoBg=[[UIImageView alloc]init];
    logoBg.frame = CGRectMake(0, 0, PROPORTION_WIDTH(100),  PROPORTION_WIDTH(100));
    logoBg.center = CGPointMake(bgView.width/2, PROPORTION_HIGHT(20)+PROPORTION_HIGHT(50));
    //logoBg.backgroundColor =[UIColor redColor];
    logoBg.layer.cornerRadius = logoBg.frame.size.width/2;
    logoBg.layer.masksToBounds = YES;
    logoBg.image =[UIImage imageNamed:@"logoWithebac@2x"];
    [bgView addSubview:logoBg];
    
    UIImage*logo=[UIImage imageNamed:@"logo"];
    UIImageView*companyLogo =[[UIImageView alloc]init];
    companyLogo.frame =CGRectMake(0, 0, logo.size.width,logo.size.height);
    companyLogo.image = logo;
    //companyLogo.backgroundColor =[UIColor greenColor];
    companyLogo.center = logoBg.center;
    [bgView addSubview:companyLogo];
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(logoBg.frame)+PROPORTION_HIGHT(20), bgView.width, 30)];
    titleLabel.text = @"恭喜您！注册成功！请前往登录页面登录";
    titleLabel.textAlignment =NSTextAlignmentCenter;
    titleLabel.textColor = textCententColor;
    [bgView addSubview:titleLabel];
    
    UILabel*detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+PROPORTION_HIGHT(10), bgView.width, 30)];
    detailLabel.text = @"恭喜您！ 获得管家币88个 , 3s 自动跳转到首页";
    detailLabel.textAlignment =NSTextAlignmentCenter;
    detailLabel.textColor = textColorPlace;
    detailLabel.font = textPlaceFont;
    detailLabel.adjustsFontSizeToFitWidth =YES;
    [bgView addSubview:detailLabel];
    
    self.backBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.backBtn.frame = CGRectMake(PROPORTION_WIDTH(16), CGRectGetMaxY(detailLabel.frame)+20, (bgView.width-PROPORTION_WIDTH(16)*2-10)/2, STANDARD_HEIGHT);
    KUIbutton(self.backBtn);
    KUIbuttonClick(self.backBtn);
    [self.backBtn setTitle:@"重拍" forState:(UIControlStateNormal)];
    [bgView addSubview:self.backBtn];
    
    self.doneBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.doneBtn.frame=CGRectMake(CGRectGetMaxX(self.backBtn.frame)+10, self.backBtn.y, self.backBtn.width, self.backBtn.height);
    KUIbutton(self.doneBtn);
    KUIbuttonClick(self.doneBtn);
    [self.doneBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [bgView addSubview:self.doneBtn];
    self.hidden = NO;
    


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
