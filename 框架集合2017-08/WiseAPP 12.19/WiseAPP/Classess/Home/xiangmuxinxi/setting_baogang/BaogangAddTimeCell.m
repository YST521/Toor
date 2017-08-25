//
//  BaogangAddTimeCell.m
//  WiseAPP
//
//  Created by app on 16/12/8.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaogangAddTimeCell.h"

@implementation BaogangAddTimeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
        
    }
    return self;

}

-(void)addView{

    [self.contentView addSubview:self.leftLa];
    [self.contentView addSubview:self.rightBtn];
    self.leftLa.textColor=textCententColor;
}
-(UIButton *)rightBtn{

    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        _rightBtn.frame =CGRectMake(SCREEN_WIDTH-PROPORTION_WIDTH(30), STANDRD_H_20_y, PROPORTION_WIDTH(20), PROPORTION_HIGHT(20));
        [_rightBtn setImage:[UIImage imageNamed:@"home_tight_delete"] forState:(UIControlStateNormal)];
        [_rightBtn setImage:[UIImage imageNamed:@"home_tight_delete"] forState:(UIControlStateHighlighted)];

    }
    return _rightBtn;
}


-(UILabel *)leftLa{
    if (!_leftLa) {
        _leftLa=[[UILabel alloc]init];
         _leftLa.frame =CGRectMake(10, STANDRD_H_20_y,SCREEN_WIDTH/2, PROPORTION_HIGHT(20));
    }

    return _leftLa;
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
