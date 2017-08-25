//
//  BaogangTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/12/6.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangTableViewCell.h"

@implementation BaogangTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }

    return self;

}
-(void)addView{
    self.leftBg=[[UIView alloc]init];
    self.leftBg.frame =CGRectMake(5, 2, SCREEN_WIDTH/2-PROPORTION_WIDTH(25), PROPORTION_HIGHT(80)-4);
    self.leftBg.backgroundColor=GlobBackGroundColor;
    [self.contentView addSubview:self.leftBg];

    self.rightBg=[[UIView alloc]init];
     self.rightBg.frame =CGRectMake(SCREEN_WIDTH/2+20, 2, SCREEN_WIDTH/2-PROPORTION_WIDTH(25), PROPORTION_HIGHT(80)-4);
     self.rightBg.backgroundColor=GlobBackGroundColor;
    [self.contentView addSubview: self.rightBg];
    
    self.middleNumLa=[[UILabel alloc]init];
    self.middleNumLa.frame =CGRectMake(0, 0, 20, 20);
    self.middleNumLa.center = CGPointMake(SCREEN_WIDTH/2, PROPORTION_HIGHT(40));
    self.middleNumLa.textAlignment =NSTextAlignmentCenter;
    self.middleNumLa.layer.cornerRadius = 10;
    self.middleNumLa.adjustsFontSizeToFitWidth=YES;
    self.middleNumLa.clipsToBounds =YES;
    [self.contentView addSubview:self.middleNumLa];
   
    UIView*upLineView=[[UIView alloc]init];
    upLineView.frame =CGRectMake(SCREEN_WIDTH/2-2, 0, 4, PROPORTION_HIGHT(30));
    upLineView.backgroundColor=[UIColor darkGrayColor];
    [self.contentView addSubview:upLineView];
    UIView*downView=[[UIView alloc]init];
    downView.frame =CGRectMake(SCREEN_WIDTH/2-2, CGRectGetMaxY(self.middleNumLa.frame), 4, PROPORTION_HIGHT(30));
    downView.backgroundColor=[UIColor darkGrayColor];
    [self.contentView addSubview:downView];
    
    //left bg UI
    self.leftGangweiLa=[[UILabel alloc]init];
    self.leftGangweiLa.frame =CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(10), self.leftBg.width-PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.leftBg addSubview:self.leftGangweiLa];
    self.leftGangweiLa.textColor =textCententColor;
    self.leftGangweiLa.font =[UIFont systemFontOfSize:16];
    
    self.leftTimeLa=[[UILabel alloc]init];
   self.leftTimeLa.frame =CGRectMake(PROPORTION_WIDTH(10), CGRectGetMaxY(self.leftGangweiLa.frame), SCREEN_WIDTH-PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.leftBg addSubview:self.leftTimeLa];
       self.leftTimeLa.font =[UIFont systemFontOfSize:16];
    self.leftTimeLa.textColor = textCententColor;
    
    self.lefDetailBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.lefDetailBtn.frame =CGRectMake(self.leftBg.width-PROPORTION_WIDTH(80), self.leftBg.height-PROPORTION_HIGHT(25), PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
    [self.lefDetailBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
    self.lefDetailBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [self.lefDetailBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
     [self.lefDetailBtn setTitle:@"查看详情" forState:(UIControlStateHighlighted)];
    [self.leftBg addSubview:self.lefDetailBtn];
    UIView*view=[[UIView alloc]init];
    view.frame=CGRectMake(self.lefDetailBtn.x+PROPORTION_WIDTH(10), self.lefDetailBtn.y+self.lefDetailBtn.height, self.lefDetailBtn.width-PROPORTION_WIDTH(20), 1);
    view.backgroundColor=[UIColor blueColor];
    [self.leftBg addSubview:view];
    
    //right
    self.rightTimeLa=[[UILabel alloc]init];
    self.rightTimeLa.frame =CGRectMake(PROPORTION_WIDTH(10), PROPORTION_HIGHT(20), self.rightBg.width-PROPORTION_WIDTH(20), PROPORTION_HIGHT(30));
    self.rightTimeLa.textColor =textCententColor;
    [self.rightBg addSubview:self.rightTimeLa];
    
    self.rightCamareBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightCamareBtn.frame =CGRectMake(self.rightBg.width-PROPORTION_WIDTH(30), self.rightBg.height-PROPORTION_HIGHT(30), PROPORTION_WIDTH(30), PROPORTION_HIGHT(30));
    [self.rightCamareBtn setImage:[UIImage imageNamed:@"kaoqin_camare.png"] forState:(UIControlStateNormal)];
      [self.rightCamareBtn setImage:[UIImage imageNamed:@"kaoqin_camare.png"] forState:(UIControlStateHighlighted)];
    [self.rightBg addSubview:self.rightCamareBtn];
    
    //测试数据
    self.middleNumLa.backgroundColor=[UIColor redColor];
   // self.leftGangweiLa.backgroundColor=[UIColor redColor];
    self.leftGangweiLa.text = @"岗位: 2号岗";
    self.leftTimeLa.text = @"完成时间: 10:00";
    self.rightTimeLa.text =@"完成时间:12:00";
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
