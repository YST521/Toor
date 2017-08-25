//
//  BaogangshowTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/25.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangshowTableViewCell.h"

@implementation BaogangshowTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
    
}
-(void)addView{
    
    self.leftLa = [[UILabel alloc]init];
    self.leftLa.frame=CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(100), 20);
    //self.leftLa.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.leftLa];
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame =CGRectMake(CGRectGetMaxX(self.leftLa.frame)+10, STANDRD_H_20_y, SCREEN_WIDTH-130, PROPORTION_HIGHT(20));
    //self.rightLa.backgroundColor=[UIColor greenColor];
    self.rightLa.textAlignment =NSTextAlignmentRight;
    [self.contentView addSubview:self.rightLa];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
     self.leftLa.frame=CGRectMake(10, STANDRD_H_20_y, PROPORTION_WIDTH(150), 20);
     self.rightLa.frame =CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(130), STANDRD_H_20_y, PROPORTION_WIDTH(120), PROPORTION_HIGHT(20));
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
