//
//  XunjianquanshuTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/4.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianquanshuTableViewCell.h"

@implementation XunjianquanshuTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self addView];
    }
    return  self;
}

-(void)addView{
    self.leftBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.frame = CGRectMake(0, STANDRD_H_20_y, 20, 20);
    self.leftBtn.backgroundColor =[UIColor redColor];
    [self addSubview:self.leftBtn];
    
    self.leftNumLa =[[UILabel alloc]init];
    self.leftNumLa.frame = CGRectMake(CGRectGetMaxX(self.leftNumLa.frame)+10, STANDRD_H_20_y, 20, 20);
    self.backgroundColor = [UIColor redColor];
    self.leftNumLa.text = @"11";
    [self addSubview:self.leftNumLa];
    
    self.leftAdressLa =[[UILabel alloc]init];
    self.leftAdressLa.frame = CGRectMake(CGRectGetMaxX(self.leftNumLa.frame)+10, STANDRD_H_20_y, 120, 20);
    self.leftAdressLa.backgroundColor=[UIColor blueColor];
    [self addSubview:self.leftAdressLa];
    self.leftAdressLa.text = @"1232435436547568768";
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(SCREEN_WIDTH-100, STANDRD_H_20_y, 100, 20);
    self.rightLa.backgroundColor=[UIColor greenColor];
    self.rightLa.text = @"12：00";
    self.rightLa.textAlignment = NSTextAlignmentCenter;
    self.rightLa.textColor = textColorPlace;
    [self addSubview:self.rightLa];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftBtn.frame = CGRectMake(10, STANDRD_H_20_y, 20, 20);
    self.leftNumLa.frame = CGRectMake(CGRectGetMaxX(self.leftNumLa.frame)+10, STANDRD_H_20_y, 20, 20);
        self.leftAdressLa.frame = CGRectMake(CGRectGetMaxX(self.leftNumLa.frame)+10, STANDRD_H_20_y, 150, 20);
    self.rightLa.frame = CGRectMake(SCREEN_WIDTH-110, STANDRD_H_20_y, 100, 20);
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
