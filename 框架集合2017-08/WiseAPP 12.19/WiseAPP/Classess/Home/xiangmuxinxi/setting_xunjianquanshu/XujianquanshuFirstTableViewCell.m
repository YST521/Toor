//
//  XujianquanshuFirstTableViewCell.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XujianquanshuFirstTableViewCell.h"


@interface XujianquanshuFirstTableViewCell()

@property(nonatomic,strong)UIImageView * numbgImage;

@end

@implementation XujianquanshuFirstTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addView];
    }
    return  self;
}

-(void)addView{
//    self.leftBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.leftBtn.frame = CGRectMake(0, STANDRD_H_20_y, 20, 20);
//    // self.leftBtn.backgroundColor =[UIColor redColor];
//    [self.contentView addSubview:self.leftBtn];
//    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
//    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    
//    self.numbgImage=[[UIImageView alloc]init];
//    self.numbgImage.frame =  CGRectMake(10, STANDRD_H_20_y, 20, 20);
//    self.numbgImage.image = [UIImage imageNamed:@"home_paiban_num"];
//    [self.contentView addSubview:self.numbgImage];
    // self.numbgImage.backgroundColor =[UIColor redColor];
    
    self.leftNumLa =[[UILabel alloc]init];
    //    self.leftNumLa.frame = self.numbgImage.bounds;
    //    self.leftNumLa.text = @"11";
    self.leftNumLa.frame =CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(120), PROPORTION_HIGHT(20));
    self.leftNumLa.font =[UIFont systemFontOfSize:16];
    self.leftNumLa.textColor=textCententColor;
    self.leftNumLa.textAlignment = NSTextAlignmentLeft;
    
      [self.contentView addSubview:self.leftNumLa];
    
    self.leftAdressLa =[[UILabel alloc]init];
    self.leftAdressLa.frame = CGRectMake(CGRectGetMaxX(self.numbgImage.frame)+10, STANDRD_H_20_y, 120, 20);
    // self.leftAdressLa.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:self.leftAdressLa];
    //self.leftAdressLa.text = @"1232435436547568768";
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(130), STANDRD_H_20_y, PROPORTION_WIDTH(100), PROPORTION_HIGHT(20));
    // self.rightLa.backgroundColor=[UIColor greenColor];
    self.rightLa.text = @"12：00";
    self.rightLa.textAlignment = NSTextAlignmentCenter;
    self.rightLa.textColor = textColorPlace;
    [self.contentView addSubview:self.rightLa];
    
    self.rightImage=[[UIImageView alloc]init];
    self.rightImage.frame =CGRectMake(CGRectGetMaxX(self.rightLa.frame)+5, PROPORTION_HIGHT(15), PROPORTION_WIDTH(15), PROPORTION_HIGHT(8));
    self.rightImage.image =[UIImage imageNamed:@"icon_right.png"];
    [self.contentView addSubview:self.rightImage];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.leftBtn.frame = CGRectMake(10, STANDRD_H_20_y, 20, 20);
//    
//    self.numbgImage.frame =  CGRectMake(10, STANDRD_H_20_y, 20, 20);
//    self.leftNumLa.frame = self.numbgImage.bounds;
     self.leftNumLa.frame =CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(120), PROPORTION_HIGHT(20));
    self.leftAdressLa.frame = CGRectMake(CGRectGetMaxX(self.numbgImage.frame)+10, STANDRD_H_20_y, 150, 20);
    
 self.rightLa.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(130), STANDRD_H_20_y, PROPORTION_WIDTH(100), PROPORTION_HIGHT(20));
    
   self.rightImage.frame =CGRectMake(CGRectGetMaxX(self.rightLa.frame)+5, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
