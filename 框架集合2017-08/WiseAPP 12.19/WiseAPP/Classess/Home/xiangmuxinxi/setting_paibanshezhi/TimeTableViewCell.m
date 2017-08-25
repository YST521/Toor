//
//  TimeTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/30.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "TimeTableViewCell.h"

@implementation TimeTableViewCell
-(UIImageView *)timeBgImage{
    if (!_timeBgImage) {
        _timeBgImage=[[UIImageView alloc]init];
    }
    return _timeBgImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addTableView];
        
    }
    return self;
}

-(void)addTableView{
    self.backgroundColor=[UIColor clearColor];
   // self.timeBgImage =[[UIImageView alloc]init];
    self.timeBgImage.frame =CGRectMake(0, 0, SCREEN_WIDTH/3, PROPORTION_HIGHT(45));
   // self.timeBgImage.frame =self.contentView.bounds;
    [self addSubview:self.timeBgImage];
    self.timeBgImage.userInteractionEnabled = YES;
   // self.timeBgImage.image =[UIImage imageNamed:@"home_paiban_time.png"];
    
    self.timeLa=[[UILabel alloc]init];
    self.timeLa.frame =CGRectMake(10, 0, self.contentView.width-PROPORTION_WIDTH(50), self.contentView.height);
    self.timeLa.textColor =textCententColor;
    [self.timeBgImage addSubview:self.timeLa];
    self.timeLa.font =[UIFont systemFontOfSize:16];
    
    self.timeweekLa=[[UILabel alloc]init];
    self.timeweekLa.frame = CGRectMake(self.timeBgImage.width -PROPORTION_WIDTH(45), STANDRD_H_20_y, PROPORTION_WIDTH(30), PROPORTION_HIGHT(20));
    self.timeweekLa.textColor =textCententColor;
    [self.timeBgImage addSubview:self.timeweekLa];
    
    self.timeweekLa.font =[UIFont systemFontOfSize:12];
    
   //self.timeBgImage.backgroundColor=[UIColor greenColor];
//    self.timeLa.backgroundColor=[UIColor greenColor];
   // self.timeweekLa.backgroundColor =[UIColor redColor];
    

}
-(void)layoutSubviews{
    [super layoutSubviews];
     self.timeBgImage.frame =CGRectMake(0, 0, SCREEN_WIDTH/3, PROPORTION_HIGHT(45));
    self.timeLa.frame =CGRectMake(10, 0, self.contentView.width-PROPORTION_WIDTH(50), self.contentView.height);
    self.timeweekLa.frame = CGRectMake(self.timeBgImage.width -PROPORTION_WIDTH(45), STANDRD_H_20_y, PROPORTION_WIDTH(30), PROPORTION_HIGHT(20));

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
