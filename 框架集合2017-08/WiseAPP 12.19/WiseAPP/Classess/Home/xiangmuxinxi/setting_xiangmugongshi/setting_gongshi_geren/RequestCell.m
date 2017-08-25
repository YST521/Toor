//
//  RequestCell.m
//  WiseAPP
//
//  Created by app on 16/12/13.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RequestCell.h"

@implementation RequestCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI{
    
    self.leftLa =[[UILabel alloc]init];
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, 80, 20);
    [self.contentView addSubview:self.leftLa];
    self.leftLa.textColor=textCententColor ;
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(self.contentView.width-100, self.leftLa.y, 60, 20);
    self.rightLa.text = @"去选择";
    [self.contentView addSubview:self.rightLa];
   // self.rightLa.textColor=textBlueColor;
    
    self.rightImage =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightImage .frame = CGRectMake(self.contentView.width-30, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
    [self.rightImage setBackgroundImage:[UIImage imageNamed:@"icon_right"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.rightImage];
    
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, SCREEN_WIDTH/2, 20);
    self.rightLa.frame = CGRectMake(self.contentView.width-100, self.leftLa.y, 60, 20);
    
    
    self.rightImage .frame = CGRectMake(self.contentView.width-30, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
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
