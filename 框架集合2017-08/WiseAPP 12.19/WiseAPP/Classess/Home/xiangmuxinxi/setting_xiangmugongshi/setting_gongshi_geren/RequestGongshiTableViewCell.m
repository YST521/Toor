//
//  RequestGongshiTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/29.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RequestGongshiTableViewCell.h"

@implementation RequestGongshiTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }

    return self;

}

-(void)addView{
    self.leftNameLa =[[UILabel alloc]init];
    self.leftNameLa.frame =CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
    self.leftNameLa.text = @"张三";
    self.leftNameLa.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:self.leftNameLa];
    
    self.leftBanciLa=[[UILabel alloc]init];
    self.leftBanciLa.frame = CGRectMake(CGRectGetMaxX(self.leftNameLa.frame)+2, STANDRD_H_20_y, PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
    self.leftBanciLa.text = @"日班";
    self.leftBanciLa.adjustsFontSizeToFitWidth =YES;
    self.leftBanciLa.backgroundColor=[UIColor cyanColor];
    [self.contentView addSubview:self.leftBanciLa];

    self.leftDaysLa= [[UILabel alloc]init];
    self.leftDaysLa.frame=CGRectMake(CGRectGetMaxX(self.leftBanciLa.frame)+2,STANDRD_H_20_y, PROPORTION_WIDTH(60), PROPORTION_HIGHT(20));
    self.leftDaysLa.text = @"20天";
    self.leftDaysLa.backgroundColor =[UIColor greenColor];
    [self.contentView addSubview:self.leftDaysLa];
    
    self.rightAuditLa=[[UILabel alloc]init];
    self.rightAuditLa.frame =CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(70), STANDRD_H_20_y, PROPORTION_WIDTH(60), PROPORTION_HIGHT(20));
    self.rightAuditLa.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.rightAuditLa];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftNameLa.frame =CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
     self.leftBanciLa.frame = CGRectMake(CGRectGetMaxX(self.leftNameLa.frame)+2, STANDRD_H_20_y, PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
    self.leftDaysLa.frame=CGRectMake(CGRectGetMaxX(self.leftBanciLa.frame)+2,STANDRD_H_20_y, PROPORTION_WIDTH(60), PROPORTION_HIGHT(20));
     self.rightAuditLa.frame =CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(70), STANDRD_H_20_y, PROPORTION_WIDTH(60), PROPORTION_HIGHT(20));
    
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
