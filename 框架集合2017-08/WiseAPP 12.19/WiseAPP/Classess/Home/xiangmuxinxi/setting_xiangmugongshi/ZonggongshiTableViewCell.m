//
//  ZonggongshiTableViewCell.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ZonggongshiTableViewCell.h"

@interface ZonggongshiTableViewCell()
@property(nonatomic,strong)UIImageView*codeBg;

@end

@implementation ZonggongshiTableViewCell-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addview];
    }
    return  self;
}
-(void)addview{
    self.leftselectbtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftselectbtn.frame = CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
   // self.leftselectbtn.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.leftselectbtn];
    [self.leftselectbtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.leftselectbtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    
    self.leftla = [[UILabel alloc]init];
    self.leftla.frame =CGRectMake(CGRectGetMaxX(self.leftselectbtn.frame)+5, STANDRD_H_20_y, PROPORTION_WIDTH(100), 20);
    //self.leftla.backgroundColor =[UIColor greenColor];
    [self.contentView addSubview:self.leftla];
    self.leftla.text = @"常日班";
    self.leftla.textColor =textCententColor;
    
    self.rightla=[[UILabel alloc]init];
    self.rightla.frame = CGRectMake(SCREEN_WIDTH/5*2+PROPORTION_WIDTH(30), STANDRD_H_20_y, 80, 20);
    //self.rightla.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:self.rightla];
     self.rightla.text = @"人员数量";
     self.rightla.textColor=textCententColor;
    
    self.codeBg=[[UIImageView alloc]init];
    self.codeBg.frame = CGRectMake(CGRectGetMaxX(self.rightla.frame)+2, PROPORTION_HIGHT(15/2.0), PROPORTION_WIDTH(100), PROPORTION_HIGHT(20));
    self.codeBg.image=[UIImage imageNamed:@"home_textfile_duanbg.png"];
    //textfBg.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.codeBg];
    self.codeBg.userInteractionEnabled = YES;
    
    self.rightFi=[[UITextField alloc]init];
     self.rightFi .frame = self.codeBg.bounds;
     self.rightFi.placeholder = @"请输入人数";
    self.rightFi.font=[UIFont systemFontOfSize:14];
    [self.codeBg addSubview: self.rightFi];
    self.rightFi.keyboardType=UIKeyboardTypeNumberPad;
    self.rightFi.textAlignment =NSTextAlignmentCenter;
    self.codeBg.userInteractionEnabled = YES;

}
-(void)layoutSubviews{

    [super layoutSubviews];

 self.leftselectbtn.frame = CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
     self.leftla.frame =CGRectMake(CGRectGetMaxX(self.leftselectbtn.frame)+5, STANDRD_H_20_y, PROPORTION_WIDTH(100), 20);
          self.rightla.frame = CGRectMake(SCREEN_WIDTH/5*2+PROPORTION_WIDTH(20), STANDRD_H_20_y, 80, 20);
    self.codeBg.frame = CGRectMake(CGRectGetMaxX(self.rightla.frame)+2, PROPORTION_HIGHT(15/2.0), PROPORTION_WIDTH(100), PROPORTION_HIGHT(30));
      self.rightFi .frame = self.codeBg.bounds;
    
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
