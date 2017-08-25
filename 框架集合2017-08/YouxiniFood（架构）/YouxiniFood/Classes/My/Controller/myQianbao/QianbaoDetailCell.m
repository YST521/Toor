//
//  QianbaoDetailCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "QianbaoDetailCell.h"

@implementation QianbaoDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self creatUI];
    }
    
    return self;

}

-(void)creatUI{

    self.chongziStatusLa =[self creatLabelCgrect:CGRectMake(20, 5, SceneWidth/2-20, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentLeft labelTectColor:CellTitleColor];
    
   self.monryLa =[self creatLabelCgrect:CGRectMake(SceneWidth/2, 5, SceneWidth/2-20, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentRight labelTectColor:[UIColor colorWithHexStringg:@"#333333"]];
    
  self.yuELa =[self creatLabelCgrect:CGRectMake(20, CGRectGetMaxY(self.chongziStatusLa.frame)+2, SceneWidth/2-20, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentLeft labelTectColor:CellTitleColor];
    
     self.dateLa =[self creatLabelCgrect:CGRectMake(SceneWidth/2, CGRectGetMaxY(self.chongziStatusLa.frame)+2, SceneWidth/2-20, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentRight labelTectColor:CellTitleColor];

//
    self.chongziStatusLa.text = @"充值到饭卡";
    self.monryLa.text = @"+20.00";
    self.yuELa.text = @"余额：100.00";
    self.dateLa.text = @"2017-07-07";
    
}

-(UILabel*)creatLabelCgrect:(CGRect)rect laFont:(UIFont*)
font Alignment:(NSTextAlignment)aliogment labelTectColor:(UIColor*)textColot{
    UILabel*la =[[UILabel alloc]init];
    la.frame = rect;
    la.font = font;
    la.textAlignment=aliogment;
    la.textColor = textColot;
    [self addSubview:la];
    
    return la;
    
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
