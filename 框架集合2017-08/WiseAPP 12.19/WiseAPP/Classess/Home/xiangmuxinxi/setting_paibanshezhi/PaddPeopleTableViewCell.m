//
//  PaddPeopleTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/2.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "PaddPeopleTableViewCell.h"

@interface PaddPeopleTableViewCell()
@property(nonatomic,strong)UIImageView* rightNumLaBg;

@end

@implementation PaddPeopleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self addView];
        
    }

    return  self;
}

-(void)addView{
    self.backgroundColor = [UIColor whiteColor];
    self.leftBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.frame = CGRectMake(10, PROPORTION_HIGHT((45-20)/2), 20,20);
    [self.contentView addSubview:self.leftBtn];
    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    
    self.leftLa = [[UILabel alloc]init];
    self.leftLa.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame)+10, PROPORTION_HIGHT((45-20)/2), 130, 20);
    [self.contentView addSubview:self.leftLa];
    
    self.rightLa =[[UILabel alloc]init];
    self.rightLa.frame = CGRectMake(kContentViewW-50, kContentViewY, 80, 20);
    [self.contentView addSubview:self.rightLa];
    self.rightLa.font =[UIFont systemFontOfSize:13];
    
    self.rightNumLaBg=[[UIImageView alloc]init];
    self.rightNumLaBg.frame = CGRectMake(kContentViewW-45, 5, 35, 35);
    [self.contentView addSubview:self.rightNumLaBg];
    self.rightNumLaBg.image =[UIImage imageNamed:@"home_paiban_num"];
    
    self.rightNumLa=[[UILabel alloc]init];
    self.rightNumLa .frame = CGRectMake(0, 0, 20, 20);
    self.rightNumLa.center = self.rightNumLaBg.center;
    [self.contentView addSubview:self.rightNumLa];
   

//    self.leftBtn.backgroundColor=[UIColor redColor];
//    self.leftLa.backgroundColor =[UIColor yellowColor];
//    self.rightLa.backgroundColor = [UIColor greenColor];
//    self.rightNumLa.backgroundColor = [UIColor cyanColor];
//    self.rightNumLaBg.backgroundColor=[UIColor orangeColor];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
   self.leftBtn.frame = CGRectMake(10, PROPORTION_HIGHT((45-20)/2), 20,20);
   self.leftLa.frame = CGRectMake(CGRectGetMaxX(self.leftBtn.frame)+10, PROPORTION_HIGHT((45-20)/2), 120, 20);
    self.rightLa.frame = CGRectMake(kContentViewW-130, kContentViewY, 80, 20);
    self.rightNumLa.layer.cornerRadius = 15;
    self.rightNumLa.layer.masksToBounds = YES;
     self.rightNumLa .frame = CGRectMake(kContentViewW-30, kContentViewY, 30, 30);
     self.rightNumLaBg.frame = CGRectMake(kContentViewW-45, 5, 35, 35);
       self.rightNumLa.center = self.rightNumLaBg.center;
    
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
