//
//  YezhuMainTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/10/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuMainTableViewCell.h"

@implementation YezhuMainTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addView];
    }

    return  self;
}

-(void)addView{

    self.bgImag=[[UIImageView alloc]init];
   self.bgImag.frame = CGRectMake(0, 0, self.contentView.width,  self.contentView.height);
    [self.contentView addSubview:self.bgImag];
  
    
    self.leftLab=[[UILabel alloc]init];
    self.leftLab.frame = CGRectMake(10, (self.contentView.height/2), 120, 20);
    [self.contentView addSubview:self.leftLab];
    self.leftLab.textColor =textColorPlace;
    
    self.rightImage=[[UIImageView alloc]init];
    self.rightImage.frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(105),PROPORTION_HIGHT(10), PROPORTION_WIDTH(60), PROPORTION_WIDTH(60));
    self.rightImage.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.rightImage];
    self.rightImage.layer.cornerRadius = self.rightImage.width/2;
    self.rightImage.layer.masksToBounds = YES;

    
    self.nextImage =[[UIImageView alloc]init];
    self.nextImage.frame = CGRectMake(self.contentView.width-PROPORTION_HIGHT(15), self.leftLab.y, PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
    self.nextImage.image =[UIImage imageNamed:@"icon_right"];
    [self.contentView addSubview:self.nextImage];
    
    self.leftLab.text = @"姓名";
    self.rightImage.image=[UIImage imageNamed:@"home_head_image"];

}
-(void)layoutSubviews{
    [super layoutSubviews];

    
     self.bgImag.frame = CGRectMake(0, 0, self.contentView.width,  self.contentView.height);
     self.rightImage.frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(105),PROPORTION_HIGHT(10), PROPORTION_WIDTH(60), PROPORTION_WIDTH(60));
    self.nextImage.frame = CGRectMake(self.contentView.width-PROPORTION_HIGHT(15), self.leftLab.y, PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));

}

- (void)awakeFromNib {
    [super awakeFromNib];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
