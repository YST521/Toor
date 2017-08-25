//
//  RequestSelectPeopleCell.m
//  WiseAPP
//
//  Created by app on 16/12/15.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "RequestSelectPeopleCell.h"

@implementation RequestSelectPeopleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}
-(void)addView{

    self.leftBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.frame = CGRectMake(10, STANDRD_H_20_y, 20, 20);
    [self.contentView addSubview:self.leftBtn];
    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselect"] forState:(UIControlStateNormal)];
    [self.leftBtn setImage:[UIImage imageNamed:@"home_banciselectClickDuiGou"] forState:(UIControlStateSelected)];
    self.peopleNameLa=[[UILabel alloc]init];
    self.peopleNameLa.frame =CGRectMake(SCREEN_WIDTH/4, STANDRD_H_20_y, PROPORTION_WIDTH(200), PROPORTION_HIGHT(20));
    [self.contentView addSubview:self.peopleNameLa];

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
