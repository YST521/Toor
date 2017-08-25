//
//  UibanhuiShowTableViewCell.m
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "UibanhuiShowTableViewCell.h"

@implementation UibanhuiShowTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
    
}
-(void)addView{
    
    self.leftLa = [[UILabel alloc]init];
    self.leftLa.frame=CGRectMake(10, STANDRD_H_20_y, 100, 20);
    //self.leftLa.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.leftLa];
    
    self.rightLa=[[UILabel alloc]init];
    self.rightLa.frame =CGRectMake(CGRectGetMaxX(self.leftLa.frame)+10, STANDRD_H_20_y, self.contentView.width-130, PROPORTION_HIGHT(20));
    //self.rightLa.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.rightLa];
    
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
