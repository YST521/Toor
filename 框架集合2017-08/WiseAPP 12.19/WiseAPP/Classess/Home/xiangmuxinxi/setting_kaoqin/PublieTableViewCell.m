//
//  PublieTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/10/31.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "PublieTableViewCell.h"

@implementation PublieTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI{
    
    self.leftLa =[[UILabel alloc]init];
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, 80, 20);
    //self.leftLa.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:self.leftLa];
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(self.contentView.width-100, self.leftLa.y, 60, 20);
    //self.rightLa.backgroundColor=[UIColor blueColor];
    self.rightLa.text = @"去填写";
    self.rightLa.textColor =textBlueColor;
    [self.contentView addSubview:self.rightLa];
    
    self.rightBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
 self.rightBtn .frame = CGRectMake(self.contentView.width-30, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_right"] forState:(UIControlStateNormal)];
    //self.rightBtn.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:self.rightBtn];
    
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.leftLa.frame = CGRectMake(10, self.contentView.height/4, SCREEN_WIDTH/2, 20);
    self.rightLa.frame = CGRectMake(self.contentView.width-100, self.leftLa.y, 60, 20);
    

  self.rightBtn .frame = CGRectMake(self.contentView.width-30, PROPORTION_HIGHT(15), PROPORTION_WIDTH(8), PROPORTION_HIGHT(15));
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
