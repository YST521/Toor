//
//  XunjianquwnashuShowTableViewCell.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/27.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianquwnashuShowTableViewCell.h"

@interface XunjianquwnashuShowTableViewCell()
@property(nonatomic,strong)UIImageView * numbgImage;

@end

@implementation XunjianquwnashuShowTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addView];
    }
    return  self;
}

-(void)addView{
//    self.leftBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.leftBtn.frame = CGRectMake(0, STANDRD_H_20_y, 20, 20);
//    // self.leftBtn.backgroundColor =[UIColor redColor];
//    [self.contentView addSubview:self.leftBtn];
//    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
//    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    
    self.numbgImage=[[UIImageView alloc]init];
    self.numbgImage.frame =  CGRectMake(10, STANDRD_H_20_y, 20, 20);
    self.numbgImage.image = [UIImage imageNamed:@"home_paiban_num"];
    [self.contentView addSubview:self.numbgImage];
    // self.numbgImage.backgroundColor =[UIColor redColor];
    
    self.leftNumLa =[[UILabel alloc]init];
    //    self.leftNumLa.frame = self.numbgImage.bounds;
    //    self.leftNumLa.text = @"11";
    [self.numbgImage addSubview:self.leftNumLa];
    self.leftNumLa.font =[UIFont systemFontOfSize:14];
    self.leftNumLa.textAlignment = NSTextAlignmentCenter;
    
    self.leftAdressLa =[[UILabel alloc]init];
    self.leftAdressLa.frame = CGRectMake(CGRectGetMaxX(self.numbgImage.frame)+10, STANDRD_H_20_y, 120, 20);
    // self.leftAdressLa.backgroundColor=[UIColor blueColor];
    [self addSubview:self.leftAdressLa];
    //self.leftAdressLa.text = @"1232435436547568768";
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(SCREEN_WIDTH-100, STANDRD_H_20_y, 100, 20);
    // self.rightLa.backgroundColor=[UIColor greenColor];
    ///self.rightLa.text = @"12：00";
    self.rightLa.textAlignment = NSTextAlignmentCenter;
    self.rightLa.textColor = textColorPlace;
    [self addSubview:self.rightLa];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //self.leftBtn.frame = CGRectMake(10, STANDRD_H_20_y, 20, 20);
    
    self.numbgImage.frame =  CGRectMake(10, STANDRD_H_20_y, 20, 20);
    self.leftNumLa.frame = self.numbgImage.bounds;
    self.leftAdressLa.frame = CGRectMake(CGRectGetMaxX(self.numbgImage.frame)+10, STANDRD_H_20_y, 150, 20);
    
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
