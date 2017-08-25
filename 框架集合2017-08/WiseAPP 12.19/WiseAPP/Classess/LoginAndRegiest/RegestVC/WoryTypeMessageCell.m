//
//  WoryTypeMessageCell.m
//  WiseAPP
//
//  Created by app on 16/10/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "WoryTypeMessageCell.h"

@implementation WoryTypeMessageCell
//-(UIImageView *)leftIcon{
//
//    if (!_leftIcon) {
//        _leftIcon=[[UIImageView alloc]init];
//    }
//    return _leftIcon;
//}
//-(UIImageView *)rightImage{
//    if (!_rightImage) {
//        _rightImage=[[UIImageView alloc]init];
//    }
//
//    return _rightImage;
//
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addView];
        
    }
    return  self;
}

-(void)addView{
  
    self.leftIcon=[[UIImageView alloc]init];
    self.leftIcon.frame= CGRectMake(10, (self.contentView.height-PROPORTION_HIGHT(20))/2, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    //self.leftIcon.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.leftIcon];
    
    self.leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+10, self.leftIcon.y, PROPORTION_WIDTH(100), PROPORTION_HIGHT(20))];
   // self.leftLabel.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel=[[UILabel alloc]init];
    self.rightLabel.frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(120), PROPORTION_HIGHT(20), PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
   // self.rightLabel.backgroundColor=[UIColor redColor];
    self.rightLabel.text =@"未填写";
    self.rightLabel.textColor=[UIColor colorWithRed:23/255 green:134/255 blue:255/255 alpha:1];
    [self.contentView addSubview:self.rightLabel];
    
    self.rightImage=[[UIImageView alloc]init];
    self.rightImage.frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(30), PROPORTION_HIGHT(20), PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    //self.rightImage.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:self.rightImage];


}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftIcon.frame= CGRectMake(10, (self.contentView.height-PROPORTION_HIGHT(20))/2, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
    
    self.leftLabel.frame =CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+10, self.leftIcon.y, PROPORTION_WIDTH(150), PROPORTION_HIGHT(20));

    
      self.rightLabel.frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(120), PROPORTION_HIGHT(20), PROPORTION_WIDTH(80), PROPORTION_HIGHT(20));
    
     self.rightImage.frame = CGRectMake(self.contentView.width-PROPORTION_WIDTH(30), PROPORTION_HIGHT(20), PROPORTION_WIDTH(15), PROPORTION_HIGHT(20));

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
