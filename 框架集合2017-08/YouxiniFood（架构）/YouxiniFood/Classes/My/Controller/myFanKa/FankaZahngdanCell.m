//
//  FankaZahngdanCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "FankaZahngdanCell.h"

@implementation FankaZahngdanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatFanKaCellUI];
        
    }
    return self;
}

- (void)creatFanKaCellUI{
    self.backgroundColor=[UIColor whiteColor];
    
    self.weekLa =[self creatLabelCgrect:CGRectMake(20, 5, 60, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentLeft labelTectColor:CellTitleColor];
 
  self.dateLa =[self creatLabelCgrect:CGRectMake(20, CGRectGetMaxY(self.weekLa.frame)+2, 60, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentLeft labelTectColor:CellTitleColor];

   //收支图
    self.shouzhiimageV = [[UIImageView alloc]init];
    self.shouzhiimageV.frame = CGRectMake(CGRectGetMaxX(self.weekLa.frame)+10, 10, 20, 20);
    [self addSubview:self.shouzhiimageV];
    
    if (/* DISABLES CODE */ (YES)) {
       self.shouzhiimageV.image = [UIImage imageNamed:@"bg_shou"];
    } else {
         self.shouzhiimageV.image = [UIImage imageNamed:@"bg_zhi"];
    }
    
      self.monryLa =[self creatLabelCgrect:CGRectMake(CGRectGetMaxX(self.shouzhiimageV.frame)+20, 5, 60, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentLeft labelTectColor:CellTitleColor];
    
      self.monryDetaliLa =[self creatLabelCgrect:CGRectMake(CGRectGetMaxX( self.shouzhiimageV.frame)+20, CGRectGetMaxY( self.monryLa.frame)+2, SceneWidth-self.monryLa.originX-20, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentLeft labelTectColor:CellTitleColor];
    
     self.statusLa =[self creatLabelCgrect:CGRectMake(SceneWidth-100, 5, 80, 20) laFont:[UIFont systemFontOfSize:14] Alignment:NSTextAlignmentRight labelTectColor:CellTitleColor];
    
    //
    self.weekLa.text = @"今天";
    self.dateLa.text = @"07-13";
    self.monryLa.text = @"+20.00";
    self.monryDetaliLa.text = @"充值20-15021218876";
    self.statusLa.text = @"交易关闭";

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
