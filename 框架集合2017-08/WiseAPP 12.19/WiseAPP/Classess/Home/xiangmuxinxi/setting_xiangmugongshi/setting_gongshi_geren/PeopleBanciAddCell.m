//
//  PeopleBanciAddCell.m
//  WiseAPP
//
//  Created by app on 16/11/29.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "PeopleBanciAddCell.h"


@interface PeopleBanciAddCell() 
@property(nonatomic,strong)UIImageView * quebianFiBg;

@end
@implementation PeopleBanciAddCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //self.backgroundColor=[UIColor redColor];
        [self addTabView];
    }
    return self;
}
-(void)addTabView{
    self.contentView.userInteractionEnabled = YES;
    
    self.quebianLeftLa =[[UILabel alloc]init];
    self.quebianLeftLa.frame =CGRectMake(10, STANDRD_H_20_y, 100, 20);
    [self.contentView addSubview:self.quebianLeftLa];
    self.quebianleftBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.quebianleftBtn.frame = CGRectMake(PROPORTION_WIDTH(145), 15/2,PROPORTION_WIDTH(30) , PROPORTION_HIGHT(30));
    // self.quebianleftBtn.backgroundColor =[UIColor purpleColor];
    [self.contentView addSubview:self.quebianleftBtn];
    [self.quebianleftBtn setImage:[UIImage imageNamed:@"home_jianhao"] forState:(UIControlStateNormal)];
    [self.quebianleftBtn setImage:[UIImage imageNamed:@"home_jianhao"] forState:(UIControlStateHighlighted)];
    
    self.quebianFiBg=[[UIImageView alloc]init];
    self.quebianFiBg.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(100), 15/2, PROPORTION_WIDTH(45), PROPORTION_HIGHT(30));
    self.quebianFiBg.image = [UIImage imageNamed:@"home_time.png"];
    [self.contentView addSubview:self.quebianFiBg];
    self.quebianFiBg.userInteractionEnabled =YES;
    
    self.quebianLa =[[UILabel alloc]init];
    self.quebianLa.frame = CGRectMake(2, 0, self.quebianFiBg.width-2, self.quebianFiBg.height);
  //self.quebianLa.backgroundColor=[UIColor blueColor];
    [self.quebianFiBg addSubview:self.quebianLa];
    self.self.quebianLa.textAlignment = NSTextAlignmentCenter;
    
    self.quebianRightBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.quebianRightBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(40), 15/2,PROPORTION_WIDTH(30) , PROPORTION_HIGHT(30));
    self.quebianRightBtn.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:self.quebianRightBtn];
    [ self.quebianRightBtn setImage:[UIImage imageNamed:@"home_jiahao"] forState:(UIControlStateNormal)];
    [ self.quebianRightBtn setImage:[UIImage imageNamed:@"home_jiahao"] forState:(UIControlStateHighlighted)];
    
//    self.quebianNexPageBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
//    //self.quebianNexPageBtn.backgroundColor=[UIColor redColor];
//    self.quebianNexPageBtn.frame = CGRectMake(self.contentView.width-90 , PROPORTION_HIGHT(15/2), PROPORTION_WIDTH(90), PROPORTION_HIGHT(30));
//    [self.quebianNexPageBtn setImage:[UIImage imageNamed:@"icon_right"] forState:(UIControlStateNormal)];
//    [self.quebianNexPageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.quebianNexPageBtn setTitle:@"申请班次" forState:UIControlStateNormal];
//    self.quebianNexPageBtn.titleLabel.font =[UIFont systemFontOfSize:12];
//    // UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
//    [self.quebianNexPageBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, PROPORTION_WIDTH(20))];
//    [self.quebianNexPageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, PROPORTION_WIDTH(70), 0, 0)];
//    [self.contentView addSubview:self.quebianNexPageBtn];
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.quebianLeftLa.frame =CGRectMake(10, STANDRD_H_20_y, 100, 20);
    
    self.quebianleftBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(125), 15/2,PROPORTION_WIDTH(30) , PROPORTION_HIGHT(30));
    
   self.quebianRightBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(40), 15/2,PROPORTION_WIDTH(30) , PROPORTION_HIGHT(30));
  self.quebianFiBg.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(90), 15/2, PROPORTION_WIDTH(45), PROPORTION_HIGHT(30));
     self.quebianRightBtn.frame = CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(40), 15/2,PROPORTION_WIDTH(30) , PROPORTION_HIGHT(30));
   // self.quebianrightLa.frame =CGRectMake(PROPORTION_WIDTH(287), STANDRD_H_20_y, 60, 20);
    //UIImage*image=[UIImage imageNamed:@"icon_right"];
//    self.quebianrightImageV.frame = CGRectMake(PROPORTION_WIDTH(352) , STANDRD_H_20_y, PROPORTION_WIDTH(12), PROPORTION_HIGHT(20));
//    self.quebianNexPageBtn.frame = CGRectMake(self.contentView.width-90 , PROPORTION_HIGHT(15/2), PROPORTION_WIDTH(90), PROPORTION_HIGHT(30));
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
