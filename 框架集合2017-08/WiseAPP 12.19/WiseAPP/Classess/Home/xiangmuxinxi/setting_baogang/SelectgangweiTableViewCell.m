//
//  SelectgangweiTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/3.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SelectgangweiTableViewCell.h"

@implementation SelectgangweiTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

-(void)addView{

    self.selectBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.selectBtn.frame = CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.selectBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.selectBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    [self.contentView addSubview:self.selectBtn];
    
    self.selectLa =[[UILabel alloc]init];
    self.selectLa .frame = CGRectMake(CGRectGetMaxX(self.selectBtn.frame)+10, STANDRD_H_20_y, PROPORTION_WIDTH(200), PROPORTION_HIGHT(20));
    //self.selectLa.text = @"1号岗";
    [self.contentView addSubview:self.selectLa];



}

-(void)layoutSubviews{

    [super layoutSubviews];
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
