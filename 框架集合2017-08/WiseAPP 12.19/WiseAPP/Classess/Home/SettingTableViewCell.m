//
//  SettingTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/10/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

 -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{


    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addVIEW];
    }
    return  self;
}

-(void)addVIEW{
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame = CGRectMake(38, 0,self.contentView.width-80, self.contentView.height);
    //self.titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.textColor = textCententColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(SCREEN_WIDTH-110, STANDRD_H_20_y, 60, 20);
    self.rightLa.text= @"去设置";
    self.rightLa.textColor = textBlueColor;
    [self addSubview:self.rightLa];
    
    //navigationButtonReturnClick  iconfont-back
   // UIImage*image=[UIImage imageNamed:@"icon_right"];
    self.rightImage = [[UIImageView alloc]init];
    self.rightImage.frame = CGRectMake( SCREEN_WIDTH-PROPORTION_HIGHT(30),  PROPORTION_HIGHT(15), PROPORTION_WIDTH(8),PROPORTION_HIGHT(15));
    self.rightImage.image = [UIImage imageNamed:@"icon_right"];
    //self.rightImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.rightImage];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
   self.titleLabel.frame = CGRectMake(38, 0,self.contentView.width-80, self.contentView.height);
    self.rightLa.frame = CGRectMake(SCREEN_WIDTH-110, STANDRD_H_20_y, 60, 20);
   self.rightImage.frame = CGRectMake( SCREEN_WIDTH-PROPORTION_HIGHT(30),  PROPORTION_HIGHT(15), PROPORTION_WIDTH(8),PROPORTION_HIGHT(15));
}


@end
