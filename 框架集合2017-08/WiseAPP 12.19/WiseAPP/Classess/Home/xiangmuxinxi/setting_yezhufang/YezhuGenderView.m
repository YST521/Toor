//
//  YezhuGenderView.m
//  WiseAPP
//
//  Created by yst911521 on 2016/12/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuGenderView.h"

@implementation YezhuGenderView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        
        [self addView];
    }
    
    return  self;
}

-(void)addView{
    self.backgroundColor=popBGColore;
    UIView*bgView=[[UIView alloc]init];
    bgView.frame = CGRectMake(PROPORTION_WIDTH(38),PROPORTION_HIGHT(150) , SCREEN_WIDTH-PROPORTION_WIDTH(38*2), PROPORTION_HIGHT(45*3));
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    bgView.userInteractionEnabled = YES;
    
    UIImageView*titleBg=[[UIImageView alloc]init];
    titleBg.frame = CGRectMake(0, 0, bgView.width,  STANDARD_HEIGHT);
    titleBg.image =[UIImage imageNamed:@"nabackgroundImage.png"];
    [bgView addSubview:titleBg];
    self.selectTitle=[[UILabel alloc]init];
    self.selectTitle.frame = titleBg.bounds;
    self.selectTitle.text = @"性别设置";
    self.selectTitle.textColor =[UIColor whiteColor];
    self.selectTitle.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.selectTitle];
    bgView.userInteractionEnabled=YES;
    self.manBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.manBtn.frame=CGRectMake(0, CGRectGetMaxY(titleBg.frame),  titleBg.width, STANDARD_HEIGHT);
    [self.manBtn setTitle:@"男" forState:(UIControlStateNormal)];
    [self.manBtn setTitleColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1] forState:(UIControlStateNormal)];
    [bgView addSubview:self.manBtn];
    
    UIView*lineView=[[UIView alloc]init];
    lineView.frame =CGRectMake(0, CGRectGetMaxY(self.manBtn.frame),  titleBg.width, 0.5);
    lineView.backgroundColor=[UIColor grayColor];
    [bgView addSubview:lineView];
    
    self.womenBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.womenBtn.frame =CGRectMake(0, CGRectGetMaxY(lineView.frame),titleBg.width, STANDARD_HEIGHT);
    [self.womenBtn setTitle:@"女" forState:(UIControlStateNormal)];
      [self.womenBtn setTitleColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1] forState:(UIControlStateNormal)];
    [bgView addSubview:self.womenBtn];
    

    
    
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
