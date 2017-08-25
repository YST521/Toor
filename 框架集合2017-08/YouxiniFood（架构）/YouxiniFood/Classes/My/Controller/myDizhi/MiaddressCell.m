//
//  MiaddressCell.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/31.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "MiaddressCell.h"

@implementation MiaddressCell{
  UIView*  BgView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatViewUI];
    }
    return self;

}

-(void)creatViewUI{

    self.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    BgView = [[UIView alloc]init];
    BgView.frame = CGRectMake(20, 10, SceneWidth-40, 115);
    BgView.backgroundColor =[UIColor whiteColor];
    BgView.layer.cornerRadius = 8;
    BgView.layer.masksToBounds = YES;
    BgView.layer.borderWidth = 0.3;
    BgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:BgView];
    
    BgView.userInteractionEnabled = YES;
    
    self.nameLa = [self creatLabelCgrect:CGRectMake(20, 10, 100, 20) laFont:[UIFont systemFontOfSize:14] Alignment:(NSTextAlignmentLeft) labelTectColor:[UIColor colorWithHexStringg:@"#666666"]];
    self.phoneNumLa = [self creatLabelCgrect:CGRectMake(100, 10, SceneWidth/2, 20) laFont:[UIFont systemFontOfSize:14] Alignment:(NSTextAlignmentLeft) labelTectColor:[UIColor colorWithHexStringg:@"#666666"]];
      self.addressLa = [self creatLabelCgrect:CGRectMake(20, CGRectGetMaxY(self.nameLa.frame)+5, SceneWidth-100, 40) laFont:[UIFont systemFontOfSize:14] Alignment:(NSTextAlignmentLeft) labelTectColor:[UIColor colorWithHexStringg:@"#999999"]];
    
    self.defauitBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.defauitBtn.frame = CGRectMake(20, CGRectGetMaxY(self.addressLa.frame)+5, 20, 20);
    [BgView addSubview:self.defauitBtn];
      self.defauitBtn.backgroundColor = [UIColor grayColor];
    
    UILabel *defaulLa = [self creatLabelCgrect:CGRectMake(CGRectGetMaxX(self.defauitBtn.frame)+2, CGRectGetMaxY(self.addressLa.frame)+5, SceneWidth-100, 20) laFont:[UIFont systemFontOfSize:14] Alignment:(NSTextAlignmentLeft) labelTectColor:[UIColor colorWithHexStringg:@"#999999"]];
    defaulLa.text = @"默认地址";
    
    
    self.deleteBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteBtn.frame = CGRectMake(BgView.width - 100, CGRectGetMaxY(self.addressLa.frame)+5, 30, 20);
    [self.deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    self.deleteBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [self.deleteBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [BgView addSubview:self.deleteBtn];
    
    self.changeImageV =[[UIImageView alloc]init];
    self.changeImageV.frame =CGRectMake(BgView.width - 70, CGRectGetMaxY(self.addressLa.frame)+5, 20, 20);
    self.changeImageV.backgroundColor=[UIColor greenColor];
    [BgView addSubview:self.changeImageV];
    
    self.changeBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    self.changeBtn.frame = CGRectMake(BgView.width - 50, CGRectGetMaxY(self.addressLa.frame)+5, 40, 20);
    [self.changeBtn setTitle:@"修改" forState:(UIControlStateNormal)];
    self.changeBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [self.changeBtn setTitleColor:[UIColor colorWithHexStringg:@"#666666"] forState:(UIControlStateNormal)];
    [BgView addSubview:self.changeBtn];
  //
//    self.nameLa.text = @"小二郎";
//    self.phoneNumLa.text = @"13522659238";
    self.addressLa.numberOfLines = 0;
//    self.addressLa.text = @"广东省东莞市南城区车站路优信通信大厦2楼研发中心";
    
    
    [self.defauitBtn addTarget:self action:@selector(defaultBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.changeBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [self.deleteBtn addTarget:self action:@selector(deletBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];

}

//默认
-(void)defaultBtnAction:(UIButton *)sender
{
    if( [self.myDizhidelegate respondsToSelector:@selector(defaultButtonDidSelected:)])
    {
        [self.myDizhidelegate performSelector:@selector(defaultButtonDidSelected:) withObject:sender];
    }
}

//修改

-(void)editBtnAction:(UIButton *)sender
{
    if( [self.myDizhidelegate respondsToSelector:@selector(editBtnAction:)])
    {
        [self.myDizhidelegate performSelector:@selector(editBtnAction:) withObject:sender];
    }
}

//删除
-(void)deletBtnAction:(UIButton *)sender
{
    if( [self.myDizhidelegate respondsToSelector:@selector(delectBtnAction:)])
    {
        [self.myDizhidelegate performSelector:@selector(delectBtnAction:) withObject:sender];
    }
}



-(UILabel*)creatLabelCgrect:(CGRect)rect laFont:(UIFont*)
font Alignment:(NSTextAlignment)aliogment labelTectColor:(UIColor*)textColot{
    UILabel*la =[[UILabel alloc]init];
    la.frame = rect;
    la.font = font;
    la.textAlignment=aliogment;
    la.textColor = textColot;
    [BgView addSubview:la];
    
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
