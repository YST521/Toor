//
//  RightTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RightTableViewCell.h"

@implementation RightTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addTableView];
        
    }
    return self;
}

-(void)addTableView{
    self.leftPeopleImage =[[UIImageView alloc]init];
    self.leftPeopleImage.frame =CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    [self.contentView addSubview:self.leftPeopleImage];
    self.leftPeopleImage.image =[UIImage imageNamed:@"home_right_people.png"];
    self.peopleLa=[[UILabel alloc]init];
    self.peopleLa.frame =CGRectMake(CGRectGetMaxX(self.leftPeopleImage.frame)+5, STANDRD_H_20_y, PROPORTION_WIDTH(100), PROPORTION_HIGHT(20));
    [self.contentView addSubview:self.peopleLa];
    self.peopleLa.textAlignment =NSTextAlignmentCenter;
    self.peopleLa.textColor =textCententColor;
    
    self.deleateBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleateBtn.frame = CGRectMake(CGRectGetMaxX(self.peopleLa.frame)+PROPORTION_HIGHT(70), STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
       // self.deleateBtn.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.deleateBtn];
    [self.deleateBtn setImage:[UIImage imageNamed:@"home_tight_delete"] forState:(UIControlStateNormal)];
      [self.deleateBtn setImage:[UIImage imageNamed:@"home_tight_delete"] forState:(UIControlStateHighlighted)];
   // self.peopleLa.backgroundColor=[UIColor redColor];

    
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
